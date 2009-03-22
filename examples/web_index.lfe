(define-module web_index
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"LFEweb")

(defun body () (list 
		(make-label text '"First LFEweb page.")
		(make-hr)
		(make-link url '"viewsource?module=web_index" text '"This page")
		(make-br)
		(make-link url '"viewsource?module=web_blog1" text '"Blog")
		(make-br)
		(make-link url '"viewsource?module=web_viewsource" text '"Viewsource")
		(make-br)))

(defun event (_) 'ok)

