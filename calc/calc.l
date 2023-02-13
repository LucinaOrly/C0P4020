%{
  #include "y.tab.h"
  int yylex();
%}

%%

[- ][0-9]+ {yylval.val = atoi(yytext); return NUM;}
\+ return PLUS;
- return MINUS;
\( return LPAR;
\) return RPAR;

\n return 0;

%%

int yywrap(void) {return 1;}
