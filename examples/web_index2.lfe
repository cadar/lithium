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
		(make-p body '"Abstract: Lfeweb is using Lfe (Lisp Flavoured Erlang) to add lisp syntax to Nitrogen. Lfe is created by Roberg Virding and described as a lisp syntax front-end to the Erlang compiler. Nitrogen is a web framework created by Rusty Klophaus that nicely put javascript, comet and jquery functionallity in the background, making it easier to work on an even higher abstaction level than before. This page demonstrate how much of Nitrogen is working using Lfe and hopefully how addicting the lisp syntax is." style '"font-style: italic; text-align: center;" class '"abstract")
                (make-br)
                (make-br)
                (make-h2 text '"What to expect")
                (make-p body '"A small warning to begin with. This page is not done. If this could be a issue we recommend that you visit us in a month or two. If new things exites you then this is probably just exiting. Then welcome. Ok, Lisp is an old language with extreamly simple consepts, that we can build upon. If someone say Lisp is simple. That is true. But that doesn't mean that all you build with lisp will be simple. It recueries curage tobuild simple tings with simple parts. That is the most respectable thing you can do in software. Let's go on and install Lfeweb, to see how simple things look like. ")

                (make-h2 text '"Install")
                (make-p body '"Lfeweb depends on Lfe and Nitrogen. Lfe and Nitrogen depends on Erlang. Therefor we start with the installation of Erlang. Erlang works on nerly every operation system out there. We recommend testing it out on Linux with the latest Ubuntu. Installing Linux will not be explained here.")
		(make-p body '"<pre>apt-get install erlang<pre>")
                (make-link url '"http://github.com/rvirding/lfe/tree/master" text '"LFE at github")
                (make-br)
                (make-link url '"http://github.com/rklophaus/nitrogen/tree/master" text '"Nitrogen at github")
                (make-br)
                (make-link url '"http://github.com/cadar/lfeweb/tree/master" text '"LFEweb at github")
                (make-h2 text '"Dev setup")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")


                (make-h2 text '"Examples")
		(make-p body '"Here are working demo examples.")
                (make-link url '"/web/blog" text '"Blog")
                (make-br)
                (make-link url '"/web/chat" text '"Chat")

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
                (make-hr)
                (make-link url '"/web/viewsource?module=web_index2" text '"source")))

(defun event (_) 'ok) 

; Pick up three stones in your hand. Do you feel the weight? Can you count them? (1, 2 .. 3) Do you hear the sound when they roll?
; Ok, That is the goal.
