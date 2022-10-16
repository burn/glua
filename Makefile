-include ../etc/Makefile

README.md: glua.lua ## update readme
	printf "\n# GLUA\n(pronounced 'glue')\n" > README.md
	printf "<img src=lib.png width=250 align=right>" >> README.md
	lua ../readme/readme.lua $^ >> README.md
