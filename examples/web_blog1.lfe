(define-module web_blog1
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"The great blog")

(defun body () (list 
                (make-label text '"Blog example")
                (make-hr)
                (make-inplace_textbox id 'inbox1 tag 'tag1 text '"The story")
                (make-br)
                (make-textbox id 'box1 text '"The computer" postback 'box1)
                (make-br)
                (make-textarea id 'area1 text '"The happy computer.")
                (make-checkbox id 'check1 text '"Public" postback 'checkbox_clicked)
                (make-br)
                (make-button text '"save" postback 'save)
                (make-button text '"clear" postback 'clear)
                (make-br)                
                (make-br)
                (make-button text '"unhandled box" postback 'unhandled1)
                (make-hr)
                (make-link url '"viewsource?module=web_blog1" text '"source")))


(defun event 
  (('checkbox_clicked) (: wf flash (list '"Clicked, " (: wf q 'check1))) 'ok)
  (('box1) (: wf flash (list '"box1 is " (: wf q 'box1))) 'ok)
  (('save) (: wf flash (list (: wf q 'inbox1) 
                             '" Saved " 
                             (: wf q 'area1))) 'ok)
  (('clear) (: wf wire '"obj('area1').value=''") 'ok)
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))

(defun inplace_textbox_event (tag value) 
  (: wf flash (: wf f '"Inplace textbox, tag=~p value=~p~n" (list tag value)))
  value)

