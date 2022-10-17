-include ../etc/Makefile

README.md: ../readme/readme.lua glua.lua ## update readme
	printf "\n# GLUA\n(pronounced 'glue')\n" > README.md
	printf "<img src='img/lib.png' width=150 align=right>" >> README.md
	lua $< glua.lua >> README.md
