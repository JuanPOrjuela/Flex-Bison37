/* Example 1-2: English to American fb1-2.l */
/* English -> American */
%{
#include <stdio.h>
%}

%option noyywrap

%%
"colour"       { printf("color"); }
"flavour"      { printf("flavor"); }
"clever"       { printf("smart"); }
"smart"        { printf("elegant"); }
"conservative" { printf("liberal"); }
.              { printf("%s", yytext); }
%%

int main(int argc, char **argv)
{
    yylex();
    return 0;
}
