Parse.exe: parse.l parse.y
	bison -d parse.y
	flex parse.l
	gcc parse.tab.c lex.yy.c -o Parse.exe
