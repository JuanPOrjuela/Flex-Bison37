/* Ejercicio 2: Calculadora Hexadecimal y Decimal (Flex) */
%{
#include <stdio.h>
#include <stdlib.h>
#include "ejercicio_2_hex.tab.h"
%}

%option noyywrap

%%
"+"             { return ADD; }
"-"             { return SUB; }
"*"             { return MUL; }
"/"             { return DIV; }
"|"             { return ABS; }
"("             { return OP; }
")"             { return CP; }
0x[a-fA-F0-9]+  { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
0X[a-fA-F0-9]+  { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
[0-9]+          { yylval = (int)strtol(yytext, NULL, 10); return NUMBER; }
\n              { return EOL; }
"//".*          { /* ignora comentarios de una linea */ }
[ \t]           { /* ignora espacios y tabulaciones */ }
.               { printf("Caracter no reconocido: %c\n", *yytext); }
%%
