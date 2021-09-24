all:
	flex -o flex-code.c flex-code.l
	gcc -o flex-code flex-code.c
	./flex-code input.txt output.txt
clean:
	rm flex-code flex-code.c
