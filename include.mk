vpath %.lfe  ./src/pages
vpath %.lfe  ./lfeweb/examples
vpath %.beam ./ebin


LSRCS=web_blog1.lfe web_viewsource.lfe $(AND_FILE)

LOBJS=$(LSRCS:.lfe=.beam)
LFE_EBIN=${HOME}/lfe/ebin/

ERL_LOAD='code:load_file(lfe_comp).'
ERL_COMP='File=hd(init:get_plain_arguments()), try lfe_comp:file(File,[{outdir,"./ebin"}]) of {ok,_Module} -> halt(0); error -> halt(0); All ->  io:format("./~s:1: ~p~n",[File,All]) catch X:Y -> io:format("./~s:1: Catch outside of compiler: ~p ~p ~n",[File,X,Y]) end, halt(0).'

.PHONY: all

all: compile $(LOBJS)

%.beam : %.lfe
	@echo Recompile: $<
	@erl -noshell -pa $(LFE_EBIN) -eval $(ERL_LOAD) -eval $(ERL_COMP) \
	-extra $< 

lclean: clean
	rm -rf compile.err compile.out *.dump 

wipe: clean lclean
	rm -rf *.beam


FLY_BEAM=$(notdir $(CHK_SOURCES:.lfe=.beam))
BEAM=$(notdir $(CHK_SOURCES:_flymake.lfe=.beam)) 
MODULE=$(notdir $(CHK_SOURCES:_flymake.lfe=)) 
LOG=2> compile.err | tee compile.out

check-syntax:
	@erl -noshell -pa ${LFE_EBIN} -eval $(ERL_LOAD) -eval $(ERL_COMP) \ 
	-extra  $(CHK_SOURCES) $(LOG)
	mv ebin/$(FLY_BEAM) ebin/$(BEAM)  $(LOG)
	@screen -p server -X stuff $''code:purge($(MODULE)),code:load_file($(MODULE)).
	echo BrowserReload\(\)\; repl.quit\(\) | nc localhost 4242



help:
	@echo ";; Copy to .emacs, then restart."
	@echo "(when (load \"flymake\" t)"
	@echo "  (setq flymake-log-level 3)"
	@echo "  (add-hook 'find-file-hook 'flymake-find-file-hook)"
	@echo "  (add-to-list 'flymake-allowed-file-name-masks"
	@echo "	       '(\"\\\\\.lfe\\\\\'\" flymake-simple-make-init)))"
	@echo ""
	@echo "(autoload 'moz-minor-mode \"moz\" \"Mozilla Minor and Inferior Mozilla Modes\" t)"
	@echo "(add-hook 'javascript-mode-hook 'javascript-custom-setup)"
	@echo "    (defun javascript-custom-setup ()"
	@echo "      (moz-minor-mode 1))"
	@echo "(global-set-key (kbd \"C-x p\")"
	@echo "                (lambda ()"
	@echo "                  (interactive)"
	@echo "                  (comint-send-string (inferior-moz-process)"
	@echo "                                      \"BrowserReload();\")))"

