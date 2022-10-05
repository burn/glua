#            ___                         
#           /\_ \                        
#    __     \//\ \     __  __     __     
#  /'_ `\     \ \ \   /\ \/\ \  /'__`\   
# /\ \L\ \     \_\ \_ \ \ \_\ \/\ \L\.\_ 
# \ \____ \    /\____\ \ \____/\ \__/.\_\
#  \/___L\ \   \/____/  \/___/  \/__/\/_/
#    /\____/                             
#    \_/__/                              

MAKEFLAGS += --silent
SHELL=/bin/bash
R=$(shell dirname $(shell git rev-parse --show-toplevel))

help: ## print help
	printf "\n#tree\nmake [OPTIONS]\n\nOPTIONS:\n"
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}\
	               {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

README.md: glua.lua ## update readme
	printf "\n# GLUA\n(pronounced 'glue')\n" > README.md
	printf "<img src=lib.png width=250 align=right>" >> README.md
	lua $R/readme/readme.lua $^ >> README.md

install: $R/readme 

$R/readme:; cd $R; git clone https://github.com/timm/readme

itso: ## commit to Git. To add a message, set `y=message`.
	git commit -am "$y"; git push; git status
	cd ../dotrc; $(MAKE) push

~/tmp/%.pdf: %.lua  ## .lua ==> .pdf
	mkdir -p ~/tmp
	echo "pdf-ing $@ ... "
	a2ps                 \
		-Br                 \
		-l 100                 \
		--file-align=fill      \
		--line-numbers=1        \
		--borders=no             \
		--pro=color               \
		--left-title=""            \
		--pretty-print="$R/dotrc/lua.ssh" \
		--columns 3                  \
		-M letter                     \
		--footer=""                    \
		--right-footer=""               \
	  -o	 $@.ps $<
	ps2pdf $@.ps $@; rm $@.ps
	open $@
