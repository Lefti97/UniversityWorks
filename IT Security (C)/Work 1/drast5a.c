#include <stdio.h>
#include <openssl/bn.h>

void printBN(char *msg, BIGNUM * a);

int main()
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *e = BN_new(); //(e, n) public key
	BIGNUM *n = BN_new(); //(e, n) public key
	BIGNUM *Scor = BN_new(); // correct Signature
	BIGNUM *Sinc = BN_new(); // incorrect Signature
	BIGNUM *msgCor = BN_new(); // correct Message
	BIGNUM *msgInc = BN_new(); // incorrect Message

	// Ekxwrisi timwn
	BN_hex2bn(&e, "010001");
	BN_hex2bn(&n, "AE1CD4DC432798D933779FBD46C6E1247F0CF1233595113AA51B450F18116115");
	BN_hex2bn(&Scor, "643D6F34902D9C7EC90CB0B2BCA36C47FA37165C0005CAB026C0542CBDB6802F");
	BN_hex2bn(&Sinc, "643D6F34902D9C7EC90CB0B2BCA36C47FA37165C0005CAB026C0542CBDB6803F");

	// Epalitheusi ypografis msg = S ^ e mod n
	BN_mod_exp(msgCor, Scor, e, n , ctx);
	BN_mod_exp(msgInc, Sinc, e, n , ctx);

	// Ektypwsh apotelesmatwn
	printBN("e = ", e);
	printBN("n = ", n);
	printBN("Scor = ", Scor);
	printBN("Sinc = ", Sinc);
	printBN("msgCor = ", msgCor);
	printBN("msgInc = ", msgInc);
}

void printBN(char *msg, BIGNUM * a)
{
	char * number_str = BN_bn2hex(a);
	printf("%s%s\n", msg, number_str);
	OPENSSL_free(number_str);
}