(define-module web_blog1
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"LFEweb")

(defun body () (make-label text '"First LFEweb page"))

(defun event (_) 'ok)

