all:
	bison -d uni-c.y 
	flex uni-c.l
	gcc uni-c.tab.c lex.yy.c -lfl -o uni-c  
	./uni-c input.txt output.txt

clean:
	rm uni-c.tab.c uni-c.tab.h lex.yy.c

flex:
	flex -o uni-c.c uni-c.l
	gcc -o uni-c uni-c.c
	./uni-c input.txt output.txt

clean-flex:
	rm uni-c uni-c.c

bison:
	bison -o uni-c.c uni-c.y
	gcc -o uni-c uni-c.c
	./uni-c input.txt output.txt

clean-bison:
	rm uni-c.c uni-c