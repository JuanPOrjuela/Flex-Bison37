/* Example 1-3: A simple flex scanner fb1-3.l */
/* recognize tokens for the calculator and print them out */
%{
#include <stdio.h>
%}

%option noyywrap

%%
"+"    { printf("PLUS\n"); }
"-"    { printf("MINUS\n"); }
"*"    { printf("TIMES\n"); }
"/"    { printf("DIVIDE\n"); }
"|"    { printf("ABS\n"); }
[0-9]+ { printf("NUMBER %s\n", yytext); }
\n     { printf("NEWLINE\n"); }
[ \t]  { /* ignore whitespace */ }
.      { printf("Mystery character %s\n", yytext); }
%%

int main(int argc, char **argv)
{
    yylex();
    return 0;
}
