


simpleparser.tab.c simpleparser.tab.h: simpleparser.y
	bison -d simpleparser.y

lex.yy.c: simplelexer.flex simpleparser.tab.h
	flex simplelexer.flex

simple: lex.yy.c simpleparser.tab.c simpleparser.tab.h
		g++ simpleparser.tab.c lex.yy.c -lfl -o simple
