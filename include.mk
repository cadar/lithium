
PAGES=src/pages/
MAIN=web_blog1
LFE_EBIN=${HOME}/lfe/ebin/

all: compile ebin/web_blog1.beam

ebin/web_blog1.beam:
	@erl -noshell -pa ${LFE_EBIN} -eval 'code:load_file(lfe_comp).' -eval 'lfe_comp:file(hd(init:get_plain_arguments())), halt(0).' -extra ${PAGES}${MAIN}.lfe
	mv web_blog1.beam ebin



check-syntax:
	@erl -noshell -pa ${LFE_EBIN} \
	-eval 'code:load_file(lfe_comp).' \
	-eval 'File=hd(init:get_plain_arguments()), try lfe_comp:file(File) of {ok,_Module} -> halt(0); error -> halt(0); All ->  io:format("./~s:1: ~p~n",[File,All]) catch X:Y -> io:format("./~s:1: Catch outside of compiler: ~p ~p ~n",[File,X,Y]) end, halt(0).' \
	-extra ${PAGES}${MAIN}_flymake.lfe 2> compile.err | tee compile.out
	rm ${MAIN}_flymake.beam
#	@screen -p server -X stuff $''sync:go().'

help:
	@echo ";; Copy to .emacs, then restart."
	@echo "(when (load \"flymake\" t)"
	@echo "  (setq flymake-log-level 3)"
	@echo "  (add-hook 'find-file-hook 'flymake-find-file-hook)"
	@echo "  (add-to-list 'flymake-allowed-file-name-masks"
	@echo "	       '(\"\\\\\.lfe\\\\\'\" flymake-simple-make-init)))"

