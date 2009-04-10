; A power plant instruction manual from the 50th.

(define-module web_index2
  (export all))

(include-file "lfeweb/wf.lfe")

(defun main () (make-template file '"./lfeweb/www/template.html"))

(defun title () '"LFEweb") 

(defun body () (list 
                (make-h3 text '"A world record in code reuse")
                (make-h3 text '"(50 years of Lisp, 20 years of Erlang, 5 months of Nitrogen)")
                (make-br)
                (make-br)
                (make-h2 text '"What to expect")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-h2 text '"Examples")
                (make-link url '"/web/blog" text '"Blog")
                (make-br)
                (make-link url '"/web/chat" text '"Chat")
                (make-br)
                (make-link url '"/web/link" text '"Upload")
                (make-h2 text '"Install")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-link url '"http://github.com/rvirding/lfe/tree/master" text '"LFE at github")
                (make-br)
                (make-link url '"http://github.com/rklophaus/nitrogen/tree/master" text '"Nitrogen at github")
                (make-br)
                (make-link url '"http://github.com/cadar/lfeweb/tree/master" text '"LFEweb at github")
                (make-h2 text '"Dev setup")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-h2 text '"Server setup")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-h2 text '"Continuous integration with Git")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-p body '"code:purge(web_blog), code:load_file(web_blog).")
                (make-h2 text '"Load testing with Tsung")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
		(make-image image '"/images/responsetime.png")
	 	(make-br)
		(make-image image '"/images/throughput.png")
                (make-h2 text '"Contribute to world progress")
                (make-p body '"How? Help me create this page or run a copy on your own server.")
                (make-hr)
                (make-link url '"/web/viewsource?module=web_index2" text '"source")))

(defun event (_) 'ok) 

; Pick up three stones in your hand. Do you feel the weight? Can you count them? (1, 2 .. 3) Do you hear the sound when they roll?
; Ok, That is the goal.
