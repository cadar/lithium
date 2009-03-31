(define-module web_chat
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Web chat")

(defun body () 
  (ensure-database-running)
  (let* ((body (list 
		(make-p)
		(make-span text '"Your chattrom")
		(make-textbox id 'usernametextbox text '"Neo" style '"with: 100px" next 'message-text-box)
		(make-p)
		(make-panel id 'chathistory class 'chat_history)
		(make-p)
		(make-textbox id 'messagetextbox style '"width: 70%;")
		(make-br)
		(make-button id 'sendbutton text '"Send" postback 'chat)
		(make-hr)
		(make-link url '"viewsource?module=web_chat" text '"source")))
	 (pid (: wf comet (lambda () (listenformessages))))
	 )
    (: io format '"comet pid is ~p, registered database is ~p~n" (list pid (whereis 'database)))
    (! 'database (tuple 'join pid))
    (: wf render body)))

(defun event 
  (('chat) (let ((username (hd (: wf q 'usernametextbox)))
		 (message (hd (: wf q 'messagetextbox))))
	     (: io format '"Event arrived ~p ~p~n" (list username message))
	     (! 'database (tuple 'message username message))
	     'ok))
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))

  
(defun listenformessages ()
  (receive 
     ((tuple 'message username message) 
      (let ((term (list 
		   (make-p)
		   '"<"
		   (make-span text username class 'username)
		   '"> "
		   (make-span text message class 'message))))
	(: wf insert_bottom 'chathistory term)
	(: wf wire '"obj('chathistory').scrollTop = obj('chathistory').scrollHeight;")
	(: wf comet_flush))))
  (listenformessages))


(defun thedatabase (users)
  (: io format '"  thedatabase waiting...~n")
  (receive
    ('list (: io format '"List ~p~n" (list users))
	   (thedatabase users))
    ((tuple 'join userpid) (begin 
			      (: io format '"  ~p is joining ~p~n" (list userpid users))
			      (: erlang monitor 'process userpid)
			      (thedatabase (cons userpid users)) 
			      ))
    ((tuple 'DOWN monitorref process userpid info) 
     (: io format '" DOWN ~p ~p~n" (list userpid info))
     (thedatabase (: lists delete userpid users)))
    ((tuple 'message username message) 					 
     (lc ((<- x users)) (! x (tuple 'message username message)))
     (thedatabase users))))

(defun ensure-database-running ()
  (let* ((dbpid (whereis 'database))
	 (dbonline (andalso (/= dbpid 'undefined) (is_process_alive dbpid)))
	 (dbonline2 'true))
    (: io format '"~nonline=~p dbpid=~p res=~p~n " (list dbonline 
						     dbpid 
						     (andalso
						      (/= dbpid 'undefined)
						      (is_process_alive dbpid))
						     ))
    (case dbonline
      ('true 'ok)
      ('false (let* ((n (spawn (lambda () (thedatabase (list))))))
		(: io format '"register~n")
		(register 'database n))))))

