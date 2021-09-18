#include <stdio.h>
#include <openssl/bn.h>

void printBN(char *msg, BIGNUM * a);
void calcPrivateKey(BIGNUM *d, BIGNUM *p, BIGNUM *q, BIGNUM *e);

int main()
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *p = BN_new();
	BIGNUM *q = BN_new();
	BIGNUM *e = BN_new(); //(e, n) public key
	BIGNUM *n = BN_new(); //(e, n) public key
	BIGNUM *d = BN_new(); // private key
	BIGNUM *name = BN_new(); // "Eleftherios Vangelis" in HEX
	BIGNUM *encrypted_msg = BN_new();
	BIGNUM *decrypted_msg = BN_new();

	// Drastiriotita 1
	BN_hex2bn(&p, "953AAB9B3F23ED593FBDC690CA10E703");
	BN_hex2bn(&q, "C34EFC7C4C2369164E953553CDF94945");
	BN_hex2bn(&e, "0D88C3");
	BN_mul(n, p, q, ctx); // n = p * q
	calcPrivateKey(d, p, q, e); // d => e * d mod (p-1)*(q-1) = 1

	// Drastiriotita 2
	BN_hex2bn(&name, "456c656674686572696f732056616e67656c6973");
	BN_mod_exp(encrypted_msg, name, e, n, ctx); // encrypted_msg = name ^ e mod n
	BN_mod_exp(decrypted_msg, encrypted_msg, d, n, ctx); // decrypted_msg = encrypted_msg ^ d mod n

	// Ektypwsh apotelesmatwn
	printBN("p = ", p);
	printBN("q = ", q);
	printBN("e = ", e);
	printBN("n = ", n);
	printBN("d = ", d);
	printf("name ASCII\t= \"Eleftherios Vangelis\"\n");
	printBN("name HEX\t= ", name);
	printBN("Encrypted name\t= ", encrypted_msg);
	printBN("Decrypted name\t= ", decrypted_msg);

}

void printBN(char *msg, BIGNUM * a)
{
	char * number_str = BN_bn2hex(a);
	printf("%s%s\n", msg, number_str);
	OPENSSL_free(number_str);
}

void calcPrivateKey(BIGNUM *d, BIGNUM *p, BIGNUM *q, BIGNUM *e)
{
	BN_CTX *ctx = BN_CTX_new();
	BIGNUM *one = BN_new();
	BIGNUM *tmp1 = BN_new();
	BIGNUM *tmp2 = BN_new();

	BN_hex2bn(&one, "1");

	BN_sub(tmp1, p, one); // tmp1 = p-1
	BN_sub(tmp2, q, one); // tmp2 = p-1
	BN_mul(tmp1, tmp1, tmp2, ctx); // tmp1 = tmp1 * tmp2
	// e * d mod tmp1 = 1 , lunei ws prws d , kai apothikeyi sto d
	BN_mod_inverse(d, e, tmp1, ctx); 

	OPENSSL_free(ctx);
	OPENSSL_free(one);
	OPENSSL_free(tmp1);
	OPENSSL_free(tmp2);
}