/* Ejercicio 2: Calculadora Hexadecimal y Decimal (Bison) */
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(char *s);
%}

/* Declaracion de tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL

%%

calclist: /* regla vacia */
    | calclist exp EOL { printf("= %d (hex: 0x%X)\n", $2, $2); }
    | calclist EOL     { /* linea vacia o que solo contiene comentario */ }
    ;

exp: factor
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

factor: term
    | factor MUL term { $$ = $1 * $3; }
    | factor DIV term { 
        if ($3 == 0) {
            yyerror("Division por cero");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
    }
    ;

term: NUMBER
    | ABS term   { $$ = $2 >= 0 ? $2 : -$2; }
    | OP exp CP  { $$ = $2; }
    ;

%%

int main(int argc, char **argv)
{
    printf("=== Calculadora Hexadecimal y Decimal ===\n");
    printf("Ingresa expresiones (ej: 0x1A + 10 o (0xFF - 5) * 2):\n");
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
