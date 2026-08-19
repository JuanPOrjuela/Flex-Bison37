/* Ejercicio 3: Calculadora con Operadores a Nivel de Bits (Flex) */
%{
#include <stdio.h>
#include <stdlib.h>
#include "ejercicio_3_bitwise.tab.h"
%}

%option noyywrap

%%
"+"             { return ADD; }
"-"             { return SUB; }
"*"             { return MUL; }
"/"             { return DIV; }
"|"             { return OR_OR_ABS; }  /* El caracter '|' se analiza en el parser */
"&"             { return AND; }
"^"             { return XOR; }
"~"             { return NOT; }
"("             { return OP; }
")"             { return CP; }
0x[a-fA-F0-9]+  { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
[0-9]+          { yylval = (int)strtol(yytext, NULL, 10); return NUMBER; }
\n              { return EOL; }
"//".*          { /* comentario */ }
[ \t]           { /* espacios */ }
.               { printf("Caracter no reconocido: %c\n", *yytext); }
%%
