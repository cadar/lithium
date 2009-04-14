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


                (make-panel class '"abstract" body '"Abstract: Lfeweb is using Lfe (Lisp Flavoured Erlang) to add lisp syntax to Nitrogen. Lfe is created by Roberg Virding and described as a lisp syntax front-end to the Erlang compiler. Nitrogen is a web framework created by Rusty Klophaus that nicely put javascript, comet and jquery functionality in the background, making it easier to work on an even higher abstraction level than before. This page demonstrate how much of Nitrogen is working using Lfe and hopefully – how addicting the lisp syntax is.")
                (make-br)
                (make-br)


                (make-h2 text '"What to expect")
                (make-p body '"A small warning to begin with. This page is not done. If this could be a issue we recommend that you come back in a month or two. If new things excites you then this is probably just exiting. Then welcome. Ok, Lisp is an old language with extremely simple concepts, that we can build upon. If someone say Lisp is simple. That is true. But that doesn't mean that all you build with lisp will be simple. The most respectable thing you can do in software is to build simple things based on simple concepts. Let's go on and install Lfeweb, to see if things turn up simple.")


                (make-h2 text '"Install")
                (make-p body '"Lfeweb depends on Lfe and Nitrogen. Lfe and Nitrogen depends on Erlang. Therefor we start with the installation of Erlang. Erlang works on every operation system out there. We recommend testing it out on Linux with the latest Ubuntu.")

                (make-p body '"<pre>
mkdir ~/elib && cd ~/elib
git clone git://github.com/rvirding/lfe.git
git clone git://github.com/rklophaus/nitrogen.git
cd nitrogen && make
echo export ERL_LIBS=~/elib/ >> ~/.bashrc
echo export PATH=$PATH:~/elib/nitrogen/support/ >> ~/.bashrc
source ~/.bashrc
</pre>")
                (make-p body '"Now we have lfe and nitrogen. Before we install lfeweb we need to create a nitrogen project. Then add lfeweb inside the project folder.")


                (make-h2 text '"First project")
                (make-p body '"<pre>
nitrogen create myproject
cd myproject 
git clone git://github.com/cadar/lfeweb.git
echo include lfeweb/include.mk >> Makefile
mv lfeweb/examples/web_blog.lfe src/pages/web_blog.lfe
make all
sh start.sh
</pre>")
                (make-p body '"Health check.")
                (make-p body '"<pre>
curl localhost:8000/web/blog
</pre>")


                (make-h2 text '"Dev setup")
                (make-p body '"My dev setup is a small experiment. At the moment I use flymake to trigger the refresh _and_ the auto reload of beam-files. It's not 100% reliable, but it's okej. I don't have to hit the browser refresh button all the time (Instead I must restart flymake-mode when it flips out). To make use of auto-refresh we must install moz-repl for firefox and then screen.")
                (make-link url '"http://wiki.github.com/bard/mozrepl" text '"Download page for moz-repl")
                (make-p body '"After installation of moz-repl, make sure you enable it in the menu. Then enter moz-minor-mode in emacs and hit C-c C-s to get a moz-prompt. Then you know you got contact with your browser. To refresh the browser you can hit C-x p or make sure your make file sends refresh to your repl.")


                (make-h2 text '"Examples")
                (make-p body '"Here are working demo examples.")
                (make-link url '"/web/blog" text '"Blog")
                (make-br)
                (make-link url '"/web/chat" text '"Chat")


                (make-h2 text '"Server setup")
                (make-p body '"On the server I use Nginx, a rock solid reverse proxy. Perfect for mapping the url to the folders on your disk. For static files, it extremely fast. Then after the Nginx setup a usually install mochiweb and enables it in the ./ebin/myproject.app file. ")


                (make-h2 text '"Continuous integration with Git")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-p body '"code:purge(web_blog), code:load_file(web_blog).")


                (make-h2 text '"Load testing with Tsung")
                (make-p body '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mauris ligula, vulputate ac, tincidunt id, pellentesque in, purus. Duis scelerisque, lacus in auctor faucibus, turpis sem varius odio, ac adipiscing augue erat sed ante. Donec id lectus at urna porta tempor. Cras semper vulputate tellus. Morbi quis mauris in mauris vestibulum pulvinar. Aenean blandit, enim ac sagittis accumsan, tellus enim mollis dui, nec tincidunt ipsum risus sed tortor. Curabitur hendrerit.")
                (make-image image '"/images/responsetime.png")
                (make-br)
                (make-image image '"/images/throughput.png")


                (make-h2 text '"Links")
                (make-link url '"http://github.com/rvirding/lfe/tree/master" text '"LFE at github")
                (make-br)
                (make-link url '"http://github.com/rklophaus/nitrogen/tree/master" text '"Nitrogen at github")
                (make-br)
                (make-link url '"http://github.com/cadar/lfeweb/tree/master" text '"LFEweb at github")


                (make-hr)
                (make-panel class '"lfecode" body
                        (make-link url '"/web/viewsource?module=web_index2" text '"source"))))

; screen, moz-repl, mochiweb, lfe, erlang, make
(defun event (_) 'ok) 

; Pick up three stones in your hand. Do you feel the weight? Can you count them? (1, 2 .. 3) Do you hear the sound when they roll?
; Ok, That is the goal.
