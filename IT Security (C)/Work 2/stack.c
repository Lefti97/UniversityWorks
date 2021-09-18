#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int bof(char *str)
{
	char buffer[24];
	printf("%p\n", &buffer);
	strcpy(buffer, str);
	return 1;
}

int main(int argc, char **argv)
{
	char str[517];
	FILE *badfile;
	badfile = fopen("badfile", "r");
	fread(str, sizeof(char), 517, badfile);
	bof(str);
	printf("returned Properly\n");
	return 1;
}