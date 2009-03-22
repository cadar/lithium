(define-module web_blog1
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"The great blog")

(defun body () (list 
		(make-label text '"Second LFEweb page")		
		(make-hr)
		(make-link url '"viewsource?module=web_blog1" text '"source")))

(defun event (_) 'ok)


