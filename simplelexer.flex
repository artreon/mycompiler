%option noyywrap

%{
// Avoid error "error: 'fileno' was not declared in this scope"
extern "C" int fileno(FILE *stream);


#include "simpleparser.tab.hpp"
#include <string>


%}

DIGIT					 [0-9]
OCT						 [0-7]
HEX					   [a-fA-F0-9]
ID						 [a-zA-Z_]
USS						 [uU]
LGS						 [Ll]

%%

"//"[^\n]*    {;}
[ \t\n]+      {;}

"{"			      {fprintf(stderr,"L_BRACE\n "); return L_BRACE;}
"}"				     {fprintf(stderr,"R_BRACE\n\n"); return R_BRACE;}
"("			      {fprintf(stderr,"L_BRACKET "); return L_BRACKET;}
")"			      {fprintf(stderr,"R_BRACKET "); return R_BRACKET;}
";"           {fprintf(stderr,"END_STATEMENT\n "); return END_STATEMENT;}
","           {fprintf(stderr, "COMMA " ); return COMMA;}
"&"           {fprintf(stderr, "AMPERSAND " ); return AMPERSAND;}

"="           {fprintf(stderr,"T_EQUALS "); return T_EQUALS;}
"+"           {fprintf(stderr,"T_PLUS "); return T_PLUS;}
"-"           {fprintf(stderr,"T_MINUS "); return T_MINUS;}
"/"           {fprintf(stderr,"T_DIVIDE "); return T_DIVIDE;}
"*"           {fprintf(stderr,"T_MULT "); return T_MULT;}
"%"           {fprintf(stderr,"T_MOD "); return T_MOD;}

"<"			      {fprintf(stderr,"T_LESSTHAN "); return T_LESSTHAN;}
">"			      {fprintf(stderr,"T_MORETHAN "); return T_MORETHAN;}
"=="			    {fprintf(stderr,"T_EQUALSTO "); return T_EQUALSTO;}
"!="			    {fprintf(stderr,"T_NOT_EQUAL "); return T_NOT_EQUAL;}
"<="			    {fprintf(stderr,"T_LESSOREQUAL "); return T_LESSOREQUAL;}
">="			    {fprintf(stderr,"T_MOREOREQUAL "); return T_MOREOREQUAL;}
"&&"			    {fprintf(stderr,"T_MOREOREQUAL "); return T_ANDCOND;}
"||"			    {fprintf(stderr,"T_MOREOREQUAL "); return T_ORCOND;}


{DIGIT}+        { fprintf(stderr,"NUMBER: %i ", atoi(yytext)); yylval.num = atoi(yytext);
                return NUMBER;}
"'"."'"           {fprintf(stderr,"CHAR_WORD: %s ", yytext); yylval.str= yytext;
                return CHAR_WORD;}

"\""[^\"]+"\""           {fprintf(stderr,"WORD: %s ", yytext); yylval.str= yytext;
                        return WORD;}


"return"      {fprintf(stderr,"RETURN "); return RETURN; }

"int"         {fprintf(stderr,"INT "); return INT;}
"char"        {fprintf(stderr,"CHAR "); return CHAR;}
"if"          {fprintf(stderr, "IF "); return IF;}
"else"          {fprintf(stderr, "ELSE "); return ELSE;}



{ID}({DIGIT}|{ID})*			 {fprintf(stderr,"IDENTIFIER: %s ", yytext); yylval.str = yytext; return IDENTIFIER;}



 %%
