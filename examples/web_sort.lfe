(define-module web_sort
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Human sort")

(defun body () (list 
		(make-hr)
                (make-link url '"/web/viewsource?module=web_vote" text '"source")))

(defun event 
  (('save) (: wf flash (: wf q 'area1)) 'ok)
  ((all) (: wf flash (: wf f '"no match, ~p~n" (list all))) 'ok))


