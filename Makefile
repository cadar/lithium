vpath %.lfe  ./src
vpath %.lfe  ./src/pages
vpath %.lfe  ./include
vpath %.beam ./ebin
vpath %.beam ./lib/lfe/ebin
vpath %.beam ./lib/nitrogen/ebin
vpath %.beam ./lib/mochiweb/ebin
vpath %.beam ./lib/hrl-to-lfe

LSRCS := $(wildcard src/*.lfe src/pages/*.lfe)
LOBJS := ebin/lithium_app.beam $(LSRCS:src/pages/%.lfe=ebin/%.beam)

.PHONY: all
all: mochiweb nitrogen lfe hrl-to-lfe wf.lfe global_lithium.lfe $(LOBJS)

################ Prepare ################

erlang:
	(cd lib ; wget http://erlang.org/download/otp_src_R13B03.tar.gz)
	(cd lib ; tar zxvf otp_src_R13B03.tar.gz)
	(cd lib/otp_src_R13B03 && ./configure)
	(cd lib/otp_src_R13B03 && ${MAKE})
	@echo
	@echo \### We need the bin folder first in PATH:
	@echo export PATH=$(shell pwd)/lib/otp_src_R13B03/bin:\$$PATH
	@echo \###
	@echo Success! Now run \"make init\".

init:
	git submodule init
	git submodule update
	mkdir -p ./lib/mochiweb/ebin
	ln -sf ../lib/nitrogen/www wwwroot/nitrogen
	@echo
	@echo Success! Now run \"make start\".

################ Dep ####################

lfe: lfe_comp.beam
lfe_comp.beam:
	(cd lib/lfe && $(MAKE))

nitrogen: wf.beam
wf.beam:
	(cd lib/nitrogen ; $(MAKE))

hrl-to-lfe: h2l.beam
h2l.beam:
	(cd lib/hrl-to-lfe ; erl -make)

mochiweb: mochiweb.beam
mochiweb.beam:
	(cd lib/mochiweb ; $(MAKE) all)

# Convert wf.inc (Erlang hrl file) to lfe.
HRL=./lib/nitrogen/include/wf.inc
H2L=./lib/hrl-to-lfe/
wf.lfe:
	cat ${HRL} | erl -pa ${H2L} -noshell -s h2l pipe > ./include/wf.lfe

################ Compile ################

ERL_LOAD='code:load_file(lfe_comp).'
ERL_COMP='File=hd(init:get_plain_arguments()), try lfe_comp:file(File,[report,{outdir,"ebin"}]) of {ok,_Module} -> halt(0); error -> halt(1); All -> io:format("./~s:1: ~p~n",[File,All]) catch X:Y -> io:format("./~s:1: Catch outside of compiler: ~p ~p ~n",[File,X,Y]) end, halt(1).'

global_lithium.lfe:
	@echo Create: include/global_lithium.lfe
	@echo "(defun updated () '\"<I>$(shell date +"%F %R - cadar")</I>\")" > include/global_lithium.lfe
	@echo "(defun src-path () '\"$(shell pwd)/src/pages/\")" >> include/global_lithium.lfe

ebin/%.beam: src/%.lfe
	@echo Recompile: $<
	@erl -pa ./lib/lfe/ebin -noshell -eval $(ERL_LOAD) -eval $(ERL_COMP) -extra $<

ebin/%.beam: src/pages/%.lfe
	@echo Recompile: $<
	@erl -pa ./lib/lfe/ebin -noshell -eval $(ERL_LOAD) -eval $(ERL_COMP) -extra $<

start: all
	@echo Starting Lithium..
	@ERL_LIBS=`pwd`/lib erl -name lithium@localhost \
	-pa ./ebin -pa ./lib/lfe/ebin -pa ./lib/nitrogen/ebin \
	-s make all -eval "application:start(lithium)"

clean:
	rm -rf compile.err compile.out *.dump
	rm include/global_lithium.lfe
	rm -rf ./ebin/*.beam

wipe: clean
	rm ./include/wf.lfe
	(cd lib/lfe ; $(MAKE) clean)
	(cd lib/nitrogen ; $(MAKE) clean)
	(cd lib/mochiweb ; $(MAKE) clean)
	(cd lib/h2l-to-lfe ; $(MAKE) clean)

################ Flymake ################

FLY_BEAM=$(notdir $(CHK_SOURCES:.lfe=.beam))
BEAM=$(notdir $(CHK_SOURCES:_flymake.lfe=.beam))
MODULE=$(notdir $(CHK_SOURCES:_flymake.lfe=))

#	1. Only one screen, 2. run "screen","screen -t server1","sh start.sh"
#	Install mozrepl for page reload, http://wiki.github.com/bard/mozrepl
check-syntax:
	erl -noshell -pa ${HOME}/elib/lfe/ebin -eval $(ERL_LOAD) -eval $(ERL_COMP) -extra $(CHK_SOURCES)
#	If flymake-mode is not working, comment lines below.
	mv ebin/$(FLY_BEAM) ebin/$(BEAM) > compile.out 2> compile.err
	@screen -p server1 -X stuff $''code:purge($(MODULE)),code:load_file($(MODULE)).' \
		 >> compile.out 2>> compile.err
	@echo BrowserReload\(\)\; repl.quit\(\) | nc localhost 4242 >> compile.out 2>> compile.err


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

