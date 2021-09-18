#include <stdio.h>
#include <openssl/bn.h>

void printBN(char *msg, BIGNUM * a);

int main()
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *e = BN_new(); //(e, n) public key
	BIGNUM *n = BN_new(); //(e, n) public key
	BIGNUM *d = BN_new(); // private key
	BIGNUM *M1 = BN_new();
	BIGNUM *M2 = BN_new();
	BIGNUM *signedM1 = BN_new();
	BIGNUM *signedM2 = BN_new();

	// Ekxwrisi timwn
	BN_hex2bn(&e, "010001");
	BN_hex2bn(&n, "DCBFFE3E51F62E09CE7032E2677A78946A849DC4CDDE3A4D0CB81629242FB1A5");
	BN_hex2bn(&d, "74D806F9F3A62BAE331FFE3F0A68AFE35B3D2E4794148AACBC26AA381CD7D30D");
	BN_hex2bn(&M1, "466f722074686520486f72646521"); // "For the Horde!"
	BN_hex2bn(&M2, "466f722074683320486f72646521"); // "For th3 Horde!"

	// Ypografh M1, M2 (signedM = M ^ d mod n)
	BN_mod_exp(signedM1, M1, d, n , ctx);
	BN_mod_exp(signedM2, M2, d, n , ctx);


	// Ektypwsh apotelesmatwn
	printBN("e = ", e);
	printBN("n = ", n);
	printBN("d = ", d);
	printBN("M1 = ", M1);
	printBN("M2 = ", M2);
	printBN("signedM1 = ", signedM1);
	printBN("signedM2 = ", signedM2);

}

void printBN(char *msg, BIGNUM * a)
{
	char * number_str = BN_bn2hex(a);
	printf("%s%s\n", msg, number_str);
	OPENSSL_free(number_str);
}