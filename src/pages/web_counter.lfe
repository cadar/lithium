(define-module web_counter
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Counter")

(defun body () 
  (list 
   (make-panel id 'counter_and_hvalue body (list '"0" 
                                                 (make-hidden id 'value1 text '"0")))
   (make-br)
   (make-button  text '"++" postback (tuple 'inc1 1))
   (make-button  text '"--" postback (tuple 'inc1 -1))
   (make-hr)
   (make-link url '"viewsource?module=web_counter" text '"source")))

(defun event
  (((tuple 'inc1 d)) (let ((next_value (integer_to_list (+ d (list_to_integer (hd (: wf q 'value1)))))))
                       (: wf update 'counter_and_hvalue
                          (make-panel body (list next_value 
                                                 (make-hidden id 'value1 text next_value)))))
   'ok)
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 
   'ok))

