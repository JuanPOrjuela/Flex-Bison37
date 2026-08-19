/* Ejercicio 3: Calculadora con Operadores a Nivel de Bits (Bison) */
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(char *s);
%}

/* Declaracion de tokens */
%token NUMBER
%token ADD SUB MUL DIV
%token OR_OR_ABS AND XOR NOT
%token OP CP
%token EOL

%%

calclist: /* regla vacia */
    | calclist bitwise_or EOL { printf("= %d (0x%X, bin: ", $2, $2); 
                                for(int b = 15; b >= 0; b--) {
                                    printf("%d", ($2 >> b) & 1);
                                    if(b % 4 == 0 && b > 0) printf(" ");
                                }
                                printf(")\n"); }
    | calclist EOL            { /* linea vacia */ }
    ;

bitwise_or: bitwise_xor
    | bitwise_or OR_OR_ABS bitwise_xor { $$ = $1 | $3; }
    ;

bitwise_xor: bitwise_and
    | bitwise_xor XOR bitwise_and      { $$ = $1 ^ $3; }
    ;

bitwise_and: exp
    | bitwise_and AND exp              { $$ = $1 & $3; }
    ;

exp: factor
    | exp ADD factor                   { $$ = $1 + $3; }
    | exp SUB factor                   { $$ = $1 - $3; }
    ;

factor: term
    | factor MUL term                  { $$ = $1 * $3; }
    | factor DIV term                  { 
        if ($3 == 0) { yyerror("Division por cero"); $$ = 0; }
        else { $$ = $1 / $3; }
    }
    ;

term: NUMBER
    | NOT term                         { $$ = ~$2; }
    | OR_OR_ABS term                   { $$ = $2 >= 0 ? $2 : -$2; }
    | OP bitwise_or CP                 { $$ = $2; }
    ;

%%

int main(int argc, char **argv)
{
    printf("=== Calculadora con Operadores Bitwise (&, |, ^, ~) ===\n");
    printf("Ejemplos: 0xFF & 0x0F | (1 << 2), 5 ^ 3, ~0\n");
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
