%{
#include <stdio.h>
#include <string>
#include <iostream>
#include <cassert>
#define YYSTYPE char*
extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);

%}
%union {
	int num;
	char* str;
}
%token INCLUDE HEADER_NAME
%token TYPE IDENTIFIER RETURN NUMBER
%token L_BRACE R_BRACE L_BRACKET R_BRACKET END_STATEMENT

%type <num> NUMBER
%type <str> INCLUDE HEADER_NAME TYPE IDENTIFIER
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

	int main() {

	FILE *myfile = fopen("simplecode.txt", "r");

	if (!myfile) {
		std::cout << "cant open!" << std::endl;
		return -1;
	}

	yyin = myfile;


	yyparse();
}

void yyerror(const char *s) {
	std::cout << " error.  Msg: " << s << std::endl;

	exit(-1);
}
