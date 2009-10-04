(define-module web_chat
  (export all)
  (import (from io (format 2))))

(include-file "include/wf.lfe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The html page will make sure
;; 1. the database is running.
;; 2. you have a user-interface-proxy pid.
;; 3. you store the user-interface-proxy pid in the database process.
;;
;; The message will travel this path:
;; 
;;        Html
;;         |
;;         | post
;;         v
;;       event ('chat)
;;         |
;;         | pid
;;         v
;;       database ('send-to-all message from-user)
;;        /|\
;;       / | \ pid
;;      .  |  v
;;     .   |  user-interface-proxy ('new message from-user)
;;         v
;;        user-interace-proxy  ('new message from-user)
;;         |
;;         | comet 
;;         v
;;        Html
;;


;; ---------- page code (run once) ---------
(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Web chat")

(defun body () 
  (let* ((body (list 
                (make-p)
                (make-span text '"Your chatroom name: ")
                (make-textbox id 'usernametextbox1 text '"Neo" style '"with: 100px")
                (make-p)
                (make-panel id 'chathistory1 class 'chat_history)
                (make-p)
                (make-textbox id 'message1 style '"width: 70%;")
                (make-button id 'sendbutton1 text '"Send" postback 'chat) ; ---------------- *start here*
                (make-button id 'listbutton1 text '"List" postback 'list) ;                |
                (make-hr)                                                              ;   |
                (make-link url '"viewsource?module=web_chat" text '"source")))         ;   |
         (proxy-pid (: wf comet (lambda () (user-interface-proxy)))))                  ;   |
    (ensure-database-running)                                                          ;   |
    (format '"proxy pid is ~p, database is ~p~n" (list proxy-pid (whereis 'database))) ;   |
    (! 'database (tuple 'add proxy-pid))                                               ;   |
    (: wf render body)))                                                               ;   |
                                                                                       ;   |
                                                                                       ;   |
(defun event                                              ;                                |
  (('chat)                                                ; <----------- 'chat -------------
   (let ((from-user (hd (: wf q 'usernametextbox1)))               
         (message (hd (: wf q 'message1))))
     (format '"  Event arrived from interface ~p ~p~n" (list from-user message))
     (! 'database (tuple 'send-to-all message from-user)) ; ----- 'send-to-all -----
     (: wf wire '"obj('message1').value=''")              ;                        |
     'ok))                                                ;                        V
  (('list) 
   (! 'database 'list))
  ((all) 
   (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))


;; ---------- user code (server) ---------
;; User-interface-proxy hold the comet 
;; connection to html page.
(defun user-interface-proxy ()
  (receive 
    ((tuple 'new message from-user)           ; <-------------- 'new ----------------------
     (let ((html (list                        ;                                           |
                  (make-p) 
                  '"<" (make-span text from-user class 'username) '"> "
                  (make-span text message class 'message))))
       (: wf insert_bottom 'chathistory1 html)
       (: wf wire '"obj('chathistory1').scrollTop = obj('chathistory1').scrollHeight;")
       (: wf comet_flush))))  ; update html *the end*
  (user-interface-proxy))

(defun ensure-database-running ()
  (try (is_process_alive (whereis 'database))
       (case  ('true 'all-is-ok))
       (catch ((tuple _ n o) 
               (let ((db-pid (spawn (lambda () (database '())))))
                 (format '"register ~p as database~n" (list db-pid))
                 (register 'database db-pid))))))


;; ---------- shared code (server) ---------
;; Datbase stores user-interface-proxy pid's.
(defun database (users)
  (macrolet ((t (arglist `(tuple ,@arglist))))  ;; make t = tuple
            (receive
              ((t 'add user-pid) 
               (begin  
                 (format '"  ~p is joining ~p~n" (list user-pid users))
                 (: erlang monitor 'process user-pid)
                 (database (cons user-pid users))))
                                                   ;                             |   
              ((t 'send-to-all message from-user)  ;  <----- 'send-to-all --------
               (: lists foreach 
                 (lambda (user-proxy-pid)                             ;                   ^
                   (! user-proxy-pid (tuple 'new message from-user))) ; ----- 'new -------|
                 users)
               (database users))

              ('list (format '"  List ~p~n" (list users))
                     (database users))
              
              ((t 'DOWN monitorref process user-pid info) 
               (format '"  DOWN ~p ~p~n" (list user-pid info))
               (database (: lists delete user-pid users))))))
