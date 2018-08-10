


src/simpleparser.tab.cpp src/simpleparser.tab.hpp: src/simpleparser.y
	bison -v -d src/simpleparser.y -o src/simpleparser.tab.cpp

src/simplelexer.yy.cpp: src/simplelexer.flex src/simpleparser.tab.hpp
	flex -o src/simplelexer.yy.cpp src/simplelexer.flex

bin/simplething: src/simplelexer.yy.cpp src/simpleparser.tab.cpp src/simpleparser.tab.hpp
		mkdir -p bin
		g++ src/simpleparser.tab.cpp src/simplelexer.yy.cpp -lfl -o bin/simplething

clean:

	rm src/*.tab.cpp
	rm src/*.yy.cpp
	rm src/*.tab.hpp
	rm src/*.output
	rm bin/*
