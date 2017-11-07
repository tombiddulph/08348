#include <stdio.h>
int yyparse(void);

#if YYDEBUG == 1
extern int yydebug;
yydebug = 1;
#endif

int main(void)
{
    return(yyparse());
}

void yyerror(char *s)
{
    fprintf(stderr, "Error : Exiting %s\n", s);
}
