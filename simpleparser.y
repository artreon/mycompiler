%{
#include <stdio.h>
#include <string.h>
#include <iostream>
extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);

%}
%union {
	int ival;
	char *sval;
}
%token INCLUDE HEADER_NAME
%token TYPE IDENTIFIER RETURN NUMBER
%token L_BRACE R_BRACE L_BRACKET R_BRACKET END_STATEMENT
%%
program:
	header function

header:
        INCLUDE HEADER_NAME

function:
	TYPE IDENTIFIER L_BRACKET R_BRACKET L_BRACE expression R_BRACE

expression:
	RETURN NUMBER END_STATEMENT

	%%

	int main(int, char**) {

	FILE *myfile = fopen("simplecode.txt", "r");

	if (!myfile) {
		std::cout << "cant open!" << std::endl;
		return -1;
	}

	yyin = myfile;

	
	yyparse();
}

void yyerror(const char *s) {
	std::cout << " parse error.  Message: " << s << std::endl;

	exit(-1);
}
