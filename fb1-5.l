/* Example 1-6: Calculator scanner fb1-5.l */
/* recognize tokens for the calculator and return them to the parser */
%{
#include <stdio.h>
#include <stdlib.h>
#include "fb1-5.tab.h"
%}

%option noyywrap

%%
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { printf("Mystery character %c\n", *yytext); }
%%
