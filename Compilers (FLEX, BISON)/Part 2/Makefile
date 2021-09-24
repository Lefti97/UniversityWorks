all:
	bison -o simple-bison-code.c simple-bison-code.y
	gcc -o simple-bison-code simple-bison-code.c
	./simple-bison-code input.txt output.txt
clean:
	rm simple-bison-code.c simple-bison-code
