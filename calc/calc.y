%{
  #include <stdio.h>
  void yyerror (char *s);
  int yylex();
%}

%union {int val;}
%start program
%token<val> NUM  LPAR RPAR PLUS MINUS
%type<val> expr

%%

program	: expr { printf("\nexpression valid! final res: %d\n", $1);}

expr	: expr PLUS expr	{$$ = $1 + $3; printf("'+'");}
	| expr MINUS expr	{$$ = $1 - $3; printf("'-'");}
	| LPAR expr RPAR	{$$ = $2; printf("'()'");}
	| NUM				{$$ = $1;printf("'%d'", $1);}
	;

 
%%

void yyerror (char *s) {
	fprintf (stderr, "%s\n", s);
}

int main() {
  return yyparse();
}
