#include <stdio.h>
#include <openssl/bn.h>

void printBN(char *msg, BIGNUM * a);

int main()
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *e = BN_new(); //(e, n) public key
	BIGNUM *n = BN_new(); //(e, n) public key
	BIGNUM *S = BN_new(); // correct Signature
	BIGNUM *msg = BN_new(); // correct Message

	// Ekxwrisi timwn
	BN_hex2bn(&e, "010001");
	BN_hex2bn(&n, "DCBFFE3E51F62E09CE7032E2677A78946A849DC4CDDE3A4D0CB81629242FB1A5");
	BN_hex2bn(&S, "DB3F7CDB93483FC1E70E4EACA650E3C6505A3E5F49EA6EDF3E95E9A7C6C7A320");

	// Epalitheusi ypografis msg = S ^ e mod n
	BN_mod_exp(msg, S, e, n , ctx);

	// Ektypwsh apotelesmatwn
	printBN("e = ", e);
	printBN("n = ", n);
	printBN("S = ", S);
	printBN("msg = ", msg);
}

void printBN(char *msg, BIGNUM * a)
{
	char * number_str = BN_bn2hex(a);
	printf("%s%s\n", msg, number_str);
	OPENSSL_free(number_str);
}