-include ../etc/Makefile

README.md: ../readme/readme.lua glua.lua ## update readme
	echo ":: $(filter $<,$^)"
	printf "\n# GLUA\n(pronounced 'glue')\n" > README.md
	lua $^ $(filter $<,$^) >> README.md
	printf "<img src='img/lib.png' width=150 align=right>" >> README.md
