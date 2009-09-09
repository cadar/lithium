(define-module web_piki
  (export all))

(include-file "include/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Piki")

(defun body () 
  (list 
  
   (make-p body '"Text")
   (make-textarea id 'area1 text '"non")))

(defun event 
  (('checkbox_clicked) (: wf flash (list '"Clicked, " (: wf q 'check1))) 'ok)
  (('box1) (: wf flash (list '"box1 is " (: wf q 'box1))) 'ok)
  (('save) (: wf flash (list (: wf q 'inbox1) 
                             '" Saved " 
                             (: wf q 'area1))) 'ok)
  (('clear) (: wf wire '"obj('area1').value=''") 'ok)
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))

(defun inplace_textbox_event (tag value) 
  (: io format '"~s~n" (list value))
  value)
