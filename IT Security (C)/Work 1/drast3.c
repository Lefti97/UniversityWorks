#include <stdio.h>
#include <openssl/bn.h>

void printBN(char *msg, BIGNUM * a);

int main()
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *e = BN_new(); //(e, n) public key
	BIGNUM *n = BN_new(); //(e, n) public key
	BIGNUM *d = BN_new(); // private key
	BIGNUM *C = BN_new(); // encrypted message HEX
	BIGNUM *decrypted_C = BN_new(); // decrypted message C in HEX

	// Ekxwrisi timwn
	BN_hex2bn(&e, "010001");
	BN_hex2bn(&n, "DCBFFE3E51F62E09CE7032E2677A78946A849DC4CDDE3A4D0CB81629242FB1A5");
	BN_hex2bn(&d, "74D806F9F3A62BAE331FFE3F0A68AFE35B3D2E4794148AACBC26AA381CD7D30D");
	BN_hex2bn(&C, "B3AF0A70793BB53492B5311AED5EA843D94661924C97A446E9DD75846DF860DF");

	// Apokriptografisi C
	BN_mod_exp(decrypted_C, C, d, n, ctx); // decrypted_C = C ^ d mod n

	// Ektypwsh apotelesmatwn
	printBN("e = ", e);
	printBN("n = ", n);
	printBN("d = ", d);
	printBN("C = ", C);
	printBN("decrypted_C = ", decrypted_C);
}

void printBN(char *msg, BIGNUM * a)
{
	char * number_str = BN_bn2hex(a);
	printf("%s%s\n", msg, number_str);
	OPENSSL_free(number_str);
}