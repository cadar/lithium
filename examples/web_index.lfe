(define-module web_index
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"LFEweb")

(defun body () (list 
                (make-label text '"Examples")
                (make-link url '"/web/blog" text '"Blog")
                (make-br)
                (make-link url '"/web/chat" text '"Chat")
                (make-hr)
                (make-label text '"Links")
                (make-link url '"http://github.com/rvirding/lfe/tree/master" text '"LFE at github")
                (make-br)
                (make-link url '"http://github.com/rklophaus/nitrogen/tree/master" text '"Nitrogen at github")
                (make-br)
                (make-link url '"http://github.com/cadar/lfeweb/tree/master" text '"LFEweb at github")
                (make-hr)
                (make-link url '"/web/viewsource?module=web_index" text '"source")))

(defun event (_) 'ok)
