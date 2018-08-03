%{
#include <fstream>
#include <string>
#include <iostream>
#include <cassert>


extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);

%}
%union{
	int num;
	char* str;
}
%token  INT CHAR CHAR_WORD COMMA
%token IDENTIFIER RETURN NUMBER WORD
%token L_BRACE R_BRACE L_BRACKET R_BRACKET END_STATEMENT
%token T_EQUALS T_PLUS T_DIVIDE T_MOD T_MULT T_MINUS


%type <num> NUMBER
%type <str>  IDENTIFIER WORD
%%



program:
	 			chunk



chunk:
			variable_declaration
			|variable_declaration chunk
			|function
			|function chunk


function:
				type IDENTIFIER L_BRACKET R_BRACKET L_BRACE block R_BRACE
				|type IDENTIFIER L_BRACKET arguments_formal R_BRACKET L_BRACE block R_BRACE
				|type IDENTIFIER L_BRACKET R_BRACKET END_STATEMENT
				|type IDENTIFIER L_BRACKET arguments_formal R_BRACKET END_STATEMENT
block:
			statement
			|  block statement

statement:
					expression END_STATEMENT
					|RETURN expression END_STATEMENT
					|variable_declaration
					|variable_assign

variable_declaration:
					type variable_assign
variable_assign:
					IDENTIFIER END_STATEMENT
					|IDENTIFIER T_EQUALS expression END_STATEMENT


expression:
					NUMBER | CHAR_WORD | WORD | IDENTIFIER | function_call
					|expression math_op expression

function_call:
							IDENTIFIER L_BRACKET  R_BRACKET
							|IDENTIFIER L_BRACKET arguments R_BRACKET

arguments_formal:
							 type IDENTIFIER
							|type IDENTIFIER COMMA arguments_formal

arguments:
					expression
					| expression COMMA arguments

type: INT | CHAR
math_op: T_EQUALS | T_PLUS | T_DIVIDE | T_MOD | T_MULT | T_MINUS

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
