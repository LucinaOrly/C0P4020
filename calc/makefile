CC	= gcc
YACC	= yacc
LEX	= lex

comp:	y.tab.c lex.yy.c
	$(CC) lex.yy.c y.tab.c

y.tab.c: calc.y
	$(YACC) -d calc.y

lex.yy.c: calc.l y.tab.h
	$(LEX) calc.l

clean:
	rm lex.yy.c y.tab.c y.tab.h
