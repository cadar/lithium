(define-module web_calc
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Web calculator")

(defun body () 
	 (list 
	  (make-textbox id 'number1 text '"")
	  (make-br)
	  (make-textbox id 'number2  text '"")
	  (make-br)
	  (make-button id 'add text '"+" postback 'add_button)
	  (make-button text '"c" postback 'clear_button)
	  (make-panel id 'res1)
	  (make-hr)
	  (make-link url '"viewsource?module=web_calc" text '"source")))

(defun event 
  (('add_button) 
   (let* ((s1 (: wf q 'number1))
          (s2 (: wf q 'number2))
          (n1 (list_to_integer (: lists flatten s1)))
          (n2 (list_to_integer (: lists flatten s2)))
          (sum1 (+ n1 n2)))
     (: wf update 'res1 (integer_to_list sum1)))
   'ok)
  (('clear_button) 
   (: wf wire '"obj('number1').value=''; obj('number2').value='';") 'ok)
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))


