/* This line causes the program to end (by emmiting 1) after encountering an EOF */
%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

/* By including the header file, we are getting the data types generated from Bison */
#include "uni-c.tab.h"

int line = 1;

%}

/* 
	Down below are all the lexical rules that apply to uni-c. We have decided to:
	- Declare all the language reserved keywords together
	- Have distinct declarations for symbols in order to maintain greater control. 
	- Use regexes for the rest of the syntax (numbers, strings, etc)

	! Keep in mind that the order in which the rules are declared is important. If a lexical rule down the line is being matched
	  by a previous one, it will not be recognized. For example, symbol declaration should always precede int or float declarations. !
*/

%%

break|case|func|const|continue|double|do|else|float|for|if|int|long|return|short|sizeof|struct|switch|void|while	{ return KEYWORD; }
"("      																											{ return LEFT; }
")"      																											{ return RIGHT; }
"+"      																											{ return ADD; }
"+="     																											{ return ADD_ASSIGN; }
"-="     																											{ return SUB_ASSIGN; }
"*="     																											{ return MUL_ASSIGN; }
"/="     																											{ return DIV_ASSIGN; }
"&&"     																											{ return BOOLEAN_AND; }
"||"     																											{ return BOOLEAN_OR; }
"=="     																											{ return EQ; }
"!="     																											{ return NOT_EQ; }
"++"     																											{ return ADD_ASSIGN; }
"--"     																											{ return SUB_ASSIGN; }
"<="     																											{ return LESS_EQ; }
">="     																											{ return GREATER_EQ; }
"&"      																											{ return ADDRESS; }
"-"      																											{ return SUB; }
"*"      																											{ return MUL; }
"/"      																											{ return DIV; }	
"%"      																											{ return MOD; }
"="      																											{ return ASSIGN; }
"<"      																											{ return LESS; }
">"      																											{ return GREATER; }
"!"      																											{ return NOT; }
[-+]?(00?|([1-9][0-9]*|0[1-7][0-7]*|0[xX][0-9A-F]+))        														{ yylval.ival = atoi(yytext); return INT; }
[-+]?(0|[1-9][0-9]*)(\.[0-9]+([eE][-]?[0-9])?|[eE][-]?[0-9])[0-9]* 												 	{ yylval.fval = atof(yytext); return FLOAT; }
(\/\/.*)|(\/\*([^*]|(\*+[^*/]))*\*+\/)       																		{ }
[A-Za-z_][0-9A-Za-z_]{0,31}        																					{ yylval.sval = strdup(yytext); return VARIABLE; }
\"([^"\\\n]|\\[\\n"])*\"          																					{ yylval.sval = strdup(yytext); return STRING; }
[^ \t;\n/]+   																										{ return UNKNOWN_TOKEN; }
[\n]                    																							{ line++; return NEWLINE;}
[;]                     																							{ return DELIMITER;}
[ \t]+     																											{ }

%%
