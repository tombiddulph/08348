#include <stdio.h>
#include <stdlib.h>
int yyparse(void);



int main(void)
{
	
	#if YYDEBUG == 1
	extern int yydebug;
	yydebug = 1;
	#endif
    return(yyparse());
}

void yyerror(char *s)
{
    fprintf(stderr, "Error : Exiting %s\n", s);
	exit(-1);
}

void yywarning(char *s)
{
	 fprintf(stderr, "Warning : %s\n", s);
}
