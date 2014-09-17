%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror();
%}

%union {
        int ival;
        float fval;
	char *sval;
}

%token	<ival>		INT
%token	<fval>		FLOAT
%token	<sval>		STRING
%token			IF
%token			OPEN
%token			CLOSE

%%
/* note: http://matt.might.net/articles/standalone-lexers-with-lex/ 
 * for article on syntactically significant whitespace */
code:
    code INT      { printf("int: %i\n", $2); }
    | code FLOAT  { printf("float: %f\n", $2); }
    | code STRING { printf("string: %s\n", $2); }
    | code IF     { printf("IF!\n"); }
    | code grouping ;
    | INT         { printf("int: %i\n", $1); }
    | FLOAT       { printf("float: %f\n", $1); } 
    | STRING      { printf("string: %s\n", $1); }
    | IF     { printf("IF!\n"); }
    | grouping ;
    ;

grouping:	
	OPEN code CLOSE  { printf("  "); }
	| OPEN grouping CLOSE { printf("  "); }
	;

%%
int main () {
    FILE *f = fopen("test.file", "r");
    if (!f) {
        printf("Can't open file!\n");
        return -1;
    }

    yyin = f;

    do {
	yyparse();
    } while(!feof(yyin));
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(-1);
}
