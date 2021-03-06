%{
#include <stdio.h>

#include "parse.tab.h"
%}
%option noyywrap
%%
#.*\n            ;
[ \t\n]         ;
[0-9]+\.[0-9]*  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
if              { return IF; }
"("               { return OPEN; }
")"               { return CLOSE; }
[a-zA-Z0-9_]+   { yylval.sval = strdup(yytext); return STRING; }
.               ;
%%

