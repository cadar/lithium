(define-module web_index
  (export all))

(include-file "include/wf.lfe")
(include-file "include/global_lithium.lfe")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"LFE on the web")

(defun body () (list
 (make-h3 text '"A world record in code reuse")
                (make-h3 text '"(50 years of Lisp, 20 years of Erlang, 1 year of Nitrogen)")
                (make-br)
                (make-panel class '"abstract" body '"Abstract: Lfeweb is using Lfe (Lisp Flavoured Erlang) to add lisp syntax to Nitrogen. Lfe, created by Robert Virding, is as a lisp syntax front-end to the Erlang compiler. Nitrogen is a web framework created by Rusty Klophaus that put javascript, comet and jquery in the background; making it possible to work on an even higher level than before.")
                (make-hr)
                (make-label text '"Examples")
                (make-link url '"/web/counter" text '"Counter")
                (make-br)
                (make-link url '"/web/calc" text '"Calculator")
                (make-br)
                (make-link url '"/web/blog" text '"Blog")
                (make-br)
                (make-link url '"/web/chat" text '"Chat")
                (make-hr)
                (make-label text '"Links")
                (make-link url '"http://github.com/rvirding/lfe/tree/master" text '"LFE at github")
                (make-br)
                (make-link url '"http://github.com/rklophaus/nitrogen/tree/master" text '"Nitrogen at github")
                (make-br)
                (make-link url '"http://github.com/cadar/lithium/tree/master" text '"Lithium at github")
                (make-hr)
                (updated)))

(defun source ()
                (make-link url '"/web/viewsource?module=web_index" text '"source"))

(defun event (_) 'ok)
