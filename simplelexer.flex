%option noyywrap

%{
// Avoid error "error: 'fileno' was not declared in this scope"
extern "C" int fileno(FILE *stream);

#include "simpleparser.tab.h"

%}


%%

"//"[^\n]*    { /* Discard comments. */ }
[ \t\n]+      { /* Ignore whitespace */ }

"{"			      { fprintf(stderr, "L_BRACE\n");
						    return L_BRACE; }
"}"				     { fprintf(stderr, "R_BRACE\n");
						    return R_BRACE; }
"("			      { fprintf(stderr, "L_BRACKET\n");
						    return L_BRACKET; }
")"			      { fprintf(stderr, "R_BRACKET\n");
						    return R_BRACKET; }
";"           {fprintf(stderr, "END_STATEMENT\n" );
                return END_STATEMENT;}

[0-9]+        { yylval.ival = atoi(yytext);
                fprintf(stderr, "NUMBER\n" );
                return NUMBER; }
"return"      { fprintf(stderr, "RETURN\n" );return RETURN; }

"int"         { fprintf(stderr, "TYPE\n" );return TYPE; }
"main"        { fprintf(stderr, "IDENTIFIER\n" );return IDENTIFIER; }
"#include"    { fprintf(stderr, "INCLUDE\n" );return INCLUDE; }
"<"[a-z.]+">" { fprintf(stderr, "HEADER_NAME\n" );return HEADER_NAME; }
 %%
