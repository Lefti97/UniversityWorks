/* Onoma arxeiou:       simple-bison-code.y
   Perigrafh:           Ypodeigma gia anaptyksh syntaktikou analyth me xrhsh tou ergaleiou Bison
   Syggrafeas:          Ergasthrio Metaglwttistwn, Tmhma Mhxanikwn Plhroforikhs kai Ypologistwn,
                        Panepisthmio Dytikhs Attikhs
   Sxolia:              To paron programma ylopoiei (me th xrhsh Bison) enan aplo syntaktiko analyth
			pou anagnwrizei thn prosthesh akeraiwn arithmwn (dekadikou systhmatos) & metablhtwn
			kai ektypwnei to apotelesma sthn othonh (thewrontas oti oi metablhtes exoun
			panta thn timh 0). Leitourgei autonoma, dhladh xwris Flex kai anagnwrizei kena
			(space & tab), akeraious (dekadikou systhmatos) kai onomata metablhtwn ths glwssas
			Uni-C enw diaxeirizetai tous eidikous xarakthres neas grammhs '\n' (new line)
			kai 'EOF' (end of file). Kathara gia logous debugging typwnei sthn othonh otidhpote
			epistrefei h synarthsh yylex().
   Odhgies ekteleshs:   Dinete "make" xwris ta eisagwgika ston trexonta katalogo. Enallaktika:
			bison -o simple-bison-code.c simple-bison-code.y
                        gcc -o simple-bison-code simple-bison-code.c
                        ./simple-bison-code
*/

%{
/* Orismoi kai dhlwseis glwssas C. Otidhpote exei na kanei me orismo h arxikopoihsh
   metablhtwn & synarthsewn, arxeia header kai dhlwseis #define mpainei se auto to shmeio */
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *);
FILE *inputfile;
FILE *outputfile;
%}

/* Orismos twn anagnwrisimwn lektikwn monadwn. */
%token ADD SUB MUL DIV MOD 						    // ARITHMETIC
%token DECR INCR
%token EQ 																// EQUALITY
%token NOT NOT_EQ 												// BOOLEAN
%token GREATER LESS GREATER_EQ LESS_EQ		// ORDER RELATION
%token ADDRESS														// MEMORY ADDRESS
%token INTCONST VARIABLE STRING						// VARIABLE TYPE
%token ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN		 			// ASSIGNMENT		
%token NEWLINE 														// SPECIAL

/* Orismos proteraiothtwn sta tokens */
%left INCR DECR
%left ADD_ASSIGN SUB_ASSIGN
%left ASSIGN MUL_ASSIGN DIV_ASSIGN
%left ADD SUB
%left MUL DIV
%right EQ NOT_EQ
%left NOT


%%

/* Orismos twn grammatikwn kanonwn. Kathe fora pou antistoixizetai enas grammatikos
   kanonas me ta dedomena eisodou, ekteleitai o kwdikas C pou brisketai anamesa sta
   agkistra. H anamenomenh syntaksh einai:
				onoma : kanonas { kwdikas C } */
program: 
	program expr NEWLINE { printf("RESULT : %d\n", $2); 
	fprintf(outputfile, "RESULT : %d\n", $2);}
	|
	;
expr:
	  INTCONST { $$ = $1; }
	| VARIABLE { $$ = $1; }
 	| expr ADD expr { $$ = $1 + $3; }
	| expr SUB expr { $$ = $1 - $3; }
	| expr MUL expr { $$ = $1 * $3; }
	| expr DIV expr { $$ = $1 / $3; }
	| expr MOD expr { $$ = $1 % $3; }
	| expr NOT_EQ expr { $$ = $1 != $3;}
	| expr EQ expr { $$ = $1 == $3;}
	| expr NOT VARIABLE expr { $$ = !$2; }
	| VARIABLE ASSIGN expr { $$ = $3; } /* Anathesi arithmitikwn ekfrasewn se metavlites */
	| VARIABLE ADD_ASSIGN expr { $$ += $3; }
	| VARIABLE SUB_ASSIGN expr { $$ -= $3; }
	| VARIABLE MUL_ASSIGN expr { $$ *= $3; }
	| VARIABLE DIV_ASSIGN expr { $$ /= $3; }
	| INCR VARIABLE { $$ = ++$2; }
	| VARIABLE INCR { $$ = $1++; }
	| DECR VARIABLE { $$ = --$2; }
	| VARIABLE DECR { $$ = $1--; }
	| expr ADDRESS VARIABLE expr { $$ = &$3; }
	| expr GREATER expr { $$ = $1 > $3; }  
	| expr LESS expr { $$ = $1 < $3; }
	| expr GREATER_EQ expr { $$ = $1 >= $3; }
	| expr LESS_EQ expr { $$ = $1 <= $3; };
  |
%%

/* H synarthsh yylex ylopoiei enan autonomo lektiko analyth. Edw anagnwrizontai
   oi lektikes monades ths glwssas Uni-C */
int yylex() {
	char buf[100];
	char num = 0;
	int zero = 0;
 	char c;

	// Diabase enan xarakthra apo thn eisodo
  c = fgetc(inputfile);

	// Ean o xarakthras einai keno h tab, agnohse ton kai diabase ton epomeno
  while (c == ' ' || c == '\t') { yylval = 0; c = fgetc(inputfile); }

	// An brethei enas xarakthras A-Z, a-z h _ tote prokeitai gia metablhth
	if ((c >= 'A' && c <= 'Z') ||
	    (c >= 'a' && c <= 'z') ||
	    (c == '_')){
		
		sprintf(buf, "%c", c);
		c = fgetc(inputfile);

		// O epomenos xarakthras meta ton prwto mporei na einai kai pshfio 0-9
		while((c >= 'A' && c <= 'Z') ||
			  (c >= 'a' && c <= 'z') ||
			  (c >= '0' && c <= '9') ||
			  (c == '_')) {
				sprintf(buf, "%s%c", buf, c);
				c = fgetc(inputfile);
		}
		
		ungetc(c, inputfile);
		yylval = 0;
		printf("\tScanner returned: VARIABLE (%s)\n", buf);
		fprintf(outputfile, "\tScanner returned: VARIABLE (%s)\n", buf);
		return VARIABLE;
	}

	// Gia kathe xarakthra pou einai arithmos ginetai h topothethsh tou sthn yylval
	while (c >= '0' && c <= '9') {
		if (zero > 0) { zero = 0; yyerror("integer starting with zero"); exit(1); }
		if (c == '0') zero++;
		if (num == 0) yylval = 0;

		yylval = (yylval * 10) + (c - '0');
		num = 1;
		c = fgetc(inputfile);
	}
	
	if (num) {
		ungetc(c, inputfile);
		printf("\tScanner returned: INTCONST (%d)\n", yylval);
		fprintf(outputfile, "\tScanner returned: INTCONST (%d)\n", yylval);
		return INTCONST;
	}
	
	/* 
	* ARITHMETIC TOKENS
	*/

	// ADDITION or ADD_ASSIGN or INCREMENTATION
  	if (c == '+')	{
		char c2 = fgetc(inputfile);
	  	if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: ADD ASSIGN (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: ADD ASSIGN (%s)\n", buf);
			return ADD_ASSIGN;
		}
		else if (c2 == '+'){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: INCREMENT (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: INCREMENT (%s)\n", buf);
			return INCR;
		}
		printf("\tScanner returned: ADDITION (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: ADDITION (%c)\n", c);
		return ADD;
	}

	// SUBTRACTION or SUB_ASSIGN or DECREMENTATION
	if (c == '-')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: SUB ASSIGN (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: SUB ASSIGN (%s)\n", buf);
			return SUB_ASSIGN;
		}
		else if (c2 == '-'){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: DECREMENT  (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: DECREMENT  (%s)\n", buf);
			return DECR;
		}
		printf("\tScanner returned: SUBTRACT (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: SUBTRACT (%c)\n", c);
		return SUB;
	}

	// MULTIPLE or MUL ASSIGN
	if (c == '*')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: MULTIPLICATION ASSIGN (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: MULTIPLICATION ASSIGN (%s)\n", buf);
			return MUL_ASSIGN;
		}
		printf("\tScanner returned: MULTIPLICATION (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: MULTIPLICATION (%c)\n", c);
		return MUL;
	}

	// DIVISION or DIV ASSIGN
	if (c == '/')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: DIV ASSIGN (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: DIV ASSIGN (%s)\n", buf);
			return DIV_ASSIGN;
		}
		printf("\tScanner returned: DIVISION (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: DIVISION (%c)\n", c);
		return DIV;
	}

	// MODULUS
	if (c == '%')	{
		printf("\tScanner returned: MODULUS (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: MODULUS (%c)\n", c);
		return MOD;
	}
	
	/* 
	* ASSIGNMENT TOKENS
	*/

	// ASSIGN
	if (c == '=')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){ // EQUALS
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: EQ (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: EQ (%s)\n", buf);
			return EQ;
		}
		ungetc(c2, inputfile);
		printf("\tScanner returned: ASSIGN (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: ASSIGN (%c)\n", c);
		return ASSIGN;
	}
	
	/* 
	* BOOLEAN TOKENS
	*/

	// Ean o xarakthras einai to symbolo ! prokeitai gia oxi
	if (c == '!')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: NOT_EQ (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: NOT_EQ (%s)\n", buf);
			return NOT_EQ;
		}
		ungetc(c2, inputfile);
		printf("\tScanner returned: NOT (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: NOT (%c)\n", c);
		return NOT;
	}

	/* 
	* ORDER RELATION TOKENS
	*/	

	// Ean o xarakthras einai to symbolo > prokeitai gia megalutero
	if (c == '>')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: GREATER EQUAL (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: GREATER EQUAL (%s)\n", buf);
			return GREATER_EQ;
		}
		ungetc(c2, inputfile);
		printf("\tScanner returned: GREATER (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: GREATER (%c)\n", c);
		return GREATER;
	}

	// Ean o xarakthras einai to symbolo < prokeitai gia mikrotero
	if (c == '<')	{
		char c2 = fgetc(inputfile);
	    if (c2 == '='){
			buf[0] = c; buf[1] = c2; buf[2] = '\0';
			printf("\tscanner returned: LESS EQUAL (%s)\n", buf);
			fprintf(outputfile, "\tscanner returned: LESS EQUAL (%s)\n", buf);
			return LESS_EQ;
		}
		ungetc(c2, inputfile);
		printf("\tScanner returned: LESS (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: LESS (%c)\n", c);
		return LESS;
	}

	/* 
	* MEMORY ADDRESS TOKENS
	*/	
	
	// Ean o xarakthras einai to symbolo & prokeitai gia dieythinsi
	if (c == '&')	{
		printf("\tScanner returned: ADDRESS (%c)\n", c);
		fprintf(outputfile, "\tScanner returned: ADDRESS (%c)\n", c);
		return ADDRESS;
	}

	/* 
	* SPECIAL TOKENS
	*/	

	// Ean prokeitai gia ton eidiko xarakthra neas grammhs
  if (c == '\n') {
		yylval = 0;
		printf("\tScanner returned: NEWLINE (\\n)\n");
		fprintf(outputfile, "\tScanner returned: NEWLINE (\\n)\n");
		return NEWLINE;
	}

	// Ean prokeitai gia ton eidiko xarakthra telous arxeiou
	if (c == EOF) {
		printf("\tScanner returned: EOF (EOF)\n");
		fprintf(outputfile, "\tScanner returned: EOF (EOF)\n");
		exit(0);
	}

	// Gia otidhpote allo kalese thn yyerror me mhnyma lathous
	yyerror("invalid character");
}


/* H synarthsh yyerror xrhsimopoieitai gia thn anafora sfalmatwn. Sygkekrimena kaleitai
   apo thn yyparse otan yparksei kapoio syntaktiko lathos. Sthn parakatw periptwsh h
   synarthsh epi ths ousias typwnei mhnyma lathous sthn othonh. */
void yyerror(char *s) {
        fprintf(stderr, "Error: %s\n", s);
}

/* H synarthsh main pou apotelei kai to shmeio ekkinhshs tou programmatos.
   Sthn sygkekrimenh periptwsh apla kalei thn synarthsh yyparse tou Bison
   gia na ksekinhsei h syntaktikh analysh. */
int main( int argc, char *argv[] )  {

	if (argc == 3) {
		inputfile = fopen(argv[1], "r");
		outputfile = fopen(argv[2], "w");
		yyparse();
		fclose(inputfile);
		fclose(outputfile);
	}
	else{
		fprintf(stderr, "Incorrect number of arguements");
		inputfile = NULL;
		outputfile = NULL;
	}

	return 0;
}