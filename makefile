


simpleparser.tab.c simpleparser.tab.h: simpleparser.y
	bison -d simpleparser.y

lex.yy.c: simplelexer.flex simpleparser.tab.h
	flex simplelexer.flex

simplething: lex.yy.c simpleparser.tab.c simpleparser.tab.h
		g++ simpleparser.tab.c lex.yy.c -lfl -o simplething

clean:
	rm simplething
	rm *.tab.c
	rm *.yy.c
	rm *.tab.h
