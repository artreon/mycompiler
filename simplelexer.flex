%option noyywrap

%{
// Avoid error "error: 'fileno' was not declared in this scope"
extern "C" int fileno(FILE *stream);

#include "simpleparser.tab.hpp"

%}

%%

WHITESPACE				[ \n\t\v\f\r]
IDENTIFIER        [_a-zA-Z][0-9_a-zA-Z]*
DECIMAL_CONSTANT        [1-9][0-9]*
%%


\{				      { fprintf(stderr, "L_BRACE\n");
						    return L_BRACE; }
"}"				     { fprintf(stderr, "R_BRACE\n");
						    return R_BRACE; }
\(				      { fprintf(stderr, "L_BRACKET\n");
						    return L_BRACKET; }
\)				      { fprintf(stderr, "R_BRACKET\n");
						    return R_BRACKET; }
{IDENTIFIER}		{ fprintf(stderr, "Identifier : %s\n", yytext);
						     toString();
						     return IDENTIFIER; }


                 
