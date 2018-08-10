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
%token  INT CHAR CHAR_WORD COMMA IF ELSE AMPERSAND
%token IDENTIFIER RETURN NUMBER WORD
%token L_BRACE R_BRACE L_BRACKET R_BRACKET END_STATEMENT
%token T_EQUALS T_PLUS T_DIVIDE T_MOD T_MULT T_MINUS
%token T_EQUALSTO T_LESSTHAN T_MORETHAN T_LESSOREQUAL T_MOREOREQUAL T_NOT_EQUAL T_ANDCOND T_ORCOND


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
					|selective_statement

selective_statement:
					IF L_BRACKET condition R_BRACKET L_BRACE block R_BRACE
					|IF L_BRACKET condition R_BRACKET L_BRACE block R_BRACE ELSE L_BRACE block R_BRACE
					|IF L_BRACKET condition R_BRACKET statement
					|IF L_BRACKET condition R_BRACKET statement ELSE L_BRACE block R_BRACE
					|IF L_BRACKET condition R_BRACKET L_BRACE block R_BRACE ELSE statement
					|IF L_BRACKET condition R_BRACKET statement ELSE statement




condition:
					expression
					| expression condition_op expression


variable_declaration:
					type variable_assign
variable_assign:
					IDENTIFIER END_STATEMENT
					|IDENTIFIER T_EQUALS expression END_STATEMENT


expression:
					NUMBER | CHAR_WORD | WORD | IDENTIFIER | function_call
					|expression math_op expression
					| T_MULT expression
					| AMPERSAND expression
					| L_BRACKET expression R_BRACKET

function_call:
							IDENTIFIER L_BRACKET  R_BRACKET
							|IDENTIFIER L_BRACKET arguments R_BRACKET

arguments_formal:
							 type IDENTIFIER
							|type IDENTIFIER COMMA arguments_formal

arguments:
					expression
					| expression COMMA arguments

pointer: type T_MULT
type: INT | CHAR | pointer
math_op: T_EQUALS | T_PLUS | T_DIVIDE | T_MOD | T_MULT | T_MINUS
condition_op: T_EQUALSTO | T_LESSTHAN | T_MORETHAN | T_LESSOREQUAL | T_MOREOREQUAL | T_NOT_EQUAL | T_ANDCOND | T_ORCOND

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
