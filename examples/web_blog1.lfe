(define-module web_blog1
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"The great blog")

(defun body () (list 
		(make-label text '"LFEweb page")
		(make-hr)
		(make-textarea)
                (make-br)
                (make-button) 
                (make-br)
		(make-link url '"viewsource?module=web_blog1" text '"source")))

(defun event (_) 'ok)

