


simpleparser.tab.cpp simpleparser.tab.hpp: simpleparser.y
	bison -v -d simpleparser.y -o simpleparser.tab.cpp

lex.yy.cpp: simplelexer.flex simpleparser.tab.hpp
	flex -o simplelexer.yy.cpp simplelexer.flex

simplething: simplelexer.yy.cpp simpleparser.tab.cpp simpleparser.tab.hpp
		g++ simpleparser.tab.cpp simplelexer.yy.cpp -lfl -o simplething

clean:

	rm *.tab.cpp
	rm *.yy.cpp
	rm *.tab.hpp
	rm *.output
	rm simplething
	
