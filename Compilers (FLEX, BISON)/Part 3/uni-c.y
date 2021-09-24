%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);

%}

/*
	Contrary to last time, we have decided to use a union in order to detect more than one data types.
	Bison defaults to an int type. Its much too complicated to typecast everything, so we instead define
	a union and bind the data type to our tokens. 
*/

%union {
  int ival;
  float fval;
  char *sval;
}

/* Tokens defined here should match the tokens in the lex file. */

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING VARIABLE

%token KEYWORD OPERATOR UNKNOWN_TOKEN DELIMITER NEWLINE
%token ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN		 			
%token GREATER LESS GREATER_EQ LESS_EQ								
%token BOOLEAN_AND BOOLEAN_OR										
%token ADD SUB MUL DIV MOD											
%token LEFT RIGHT
%token NOT NOT_EQ 													
%token DECR INCR													
%token ADDRESS 														
%token EQ														

/* Token priority is defined (top -> bottom) and (left -> right). For example, INCR has a higher priority than ADD_ASSIGN. */

%left INCR DECR
%left ADD_ASSIGN SUB_ASSIGN
%left ASSIGN MUL_ASSIGN DIV_ASSIGN
%left ADD SUB
%left MUL DIV
%left LEFT RIGHT
%right EQ NOT_EQ
%left NOT
%left BOOLEAN_AND BOOLEAN_OR

%type<ival> int_expr
%type<fval> float_expr

%start program

/*
	Down below are all the grammar rules that match expressions with the corresponding lexical rule.
	We wanted a more detailed view of what the compiler was being fed, so we moved the print statements
	from the inLine section to the corresponding subsections. This way we get a print for every single step.
	Given enough time we would make this a bad@ss compiler.
*/

/*
	The logical expressions evaluate to 0 | 1 (false | true).
	For example 1 > 0 will print 1 which is the logical true.
*/

%%

program: 
	| program inLine;

inLine: 											
	| int_expr NEWLINE
	| float_expr NEWLINE
	| string_expr NEWLINE
	| error NEWLINE { yyerror("\nError occured! Recovering..."); yyerrok; }
	;

int_expr:
	INT { printf("INT => %d\n", $1); }
 	| int_expr ADD int_expr { printf("ADD INTS => RESULT: %d\n", $1 + $3); }
	| int_expr SUB int_expr { printf("SUB INTS => RESULT: %d\n", $1 - $3); }
	| int_expr MUL int_expr { printf("SUB INTS => RESULT: %d\n", $1 * $3); }
	| int_expr DIV int_expr { printf("DIV INTS => RESULT: %d\n", $1 / $3); }
	| int_expr MOD int_expr { printf("MOD INTS => RESULT: %d\n", $1 % $3); }
	| int_expr NOT_EQ int_expr { printf("NOT_EQ INTS => RESULT: %d\n", $1 != $3); }
	| int_expr EQ int_expr {printf("EQ INTS => RESULT: %d\n", $1 != $3); }
	| int_expr GREATER int_expr { printf("GREATER INTS => RESULT: %d\n", $1 > $3); }
	| int_expr LESS int_expr { printf("LESS INTS => RESULT: %d\n", $1 < $3); }
	| int_expr GREATER_EQ int_expr { printf("GREATER_EQ INTS => RESULT: %d\n", $1 >= $3); }
	| int_expr LESS_EQ int_expr { printf("LESS_EQ INTS => RESULT: %d\n", $1 <= $3); }
	| int_expr BOOLEAN_AND int_expr { printf("BOOLEAN_AND INTS => RESULT: %d\n", $1 && $3); }
	| int_expr BOOLEAN_OR int_expr { printf("BOOLEAN_OR INTS => RESULT: %d\n", $1 || $3); }
	| LEFT int_expr RIGHT { }
	;

float_expr:
	FLOAT { printf("FLOAT => %f\n", $1); }
	| float_expr ADD float_expr { printf("ADD FLOATS => RESULT: %f\n", $1 + $3); }
	| float_expr SUB float_expr { printf("SUB FLOATS => RESULT: %d\n", $1 - $3); }
	| float_expr MUL float_expr { printf("SUB FLOATS => RESULT: %d\n", $1 * $3); }
	| float_expr DIV float_expr { printf("DIV FLOATS => RESULT: %d\n", $1 / $3); }
//	| float_expr MOD float_expr { printf("MOD FLOATS => RESULT: %d\n", $1 % $3); }
	| float_expr NOT_EQ float_expr { printf("NOT_EQ FLOATS => RESULT: %d\n", $1 != $3); }
	| float_expr EQ float_expr {printf("EQ FLOATS => RESULT: %d\n", $1 != $3); }
	| float_expr GREATER float_expr { printf("GREATER FLOATS => RESULT: %d\n", $1 > $3); }
	| float_expr LESS float_expr { printf("LESS FLOATS => RESULT: %d\n", $1 < $3); }
	| float_expr GREATER_EQ float_expr { printf("GREATER_EQ FLOATS => RESULT: %d\n", $1 >= $3); }
	| float_expr LESS_EQ float_expr { printf("LESS_EQ FLOATS => RESULT: %d\n", $1 <= $3); }
	| float_expr BOOLEAN_AND float_expr { printf("BOOLEAN_AND FLOATS => RESULT: %d\n", $1 && $3); }
	| float_expr BOOLEAN_OR float_expr { printf("BOOLEAN_OR FLOATS => RESULT: %d\n", $1 || $3); }
	| LEFT float_expr RIGHT { }
	;


string_expr:
	| VARIABLE { printf("VARIABLE => %s\n", $1); }
	| STRING { printf("STRING => %s\n", $1);}
	// | expr NOT VARIABLE expr { $$ = !$2; }
	// | VARIABLE ASSIGN expr { $$ = $3; }
	// | VARIABLE ADD_ASSIGN expr { $$ += $3; }
	// | VARIABLE SUB_ASSIGN expr { $$ -= $3; }
	// | VARIABLE MUL_ASSIGN expr { $$ *= $3; }
	// | VARIABLE DIV_ASSIGN expr { $$ /= $3; }
	// | INCR VARIABLE { $$ = ++$2; }
	// | VARIABLE INCR { $$ = $1++; }
	// | DECR VARIABLE { $$ = --$2; }
	// | VARIABLE DECR { $$ = $1--; }
	// | expr ADDRESS VARIABLE { $$ = &$3; }
	;

	// TODO #3 Fix string_expr section

%%

/* Simple error matching function */

void yyerror(const char *s) {
  printf("%s", s);
}

int main(int argc, char **argv) {
  FILE *mfile = fopen(argv[1], "r");

  if (!mfile) {
    printf("I can't read the damn file!");
    return -1;
  }

  yyin = mfile;

  int parse = yyparse();

	if (parse==0)
		printf("Parsing succeeded!\n");
	else
		printf("Parsing went south...\n");

  return 0;
}
