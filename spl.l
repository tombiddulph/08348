%{
    #include<stdio.h>
	#include<string.h>
 

	#ifdef PRINT

    #define _TOKEN_(t) 				printf("Token: " #t "\n");
	#define _TOKEN_INTEGER_(t) 		printf("Integer token:  %i\n", atoi(yytext));
	#define _TOKEN_REAL_(t) 		printf("Real token: %f\n", atof(yytext));
	#define _TOKEN_CHARACTER_(t) 	printf("Character constant token: %c\n", yytext[1]);
    #define _TOKEN_IDENTIFIER_(t) 	printf("Identifier token: %s\n",yytext); 
	#define _TOKEN_UNKNOWN_(t)		printf("Unkown token: %s\n", yytext);

    #else

	extern SYMTABNODEPTR symbolTable[SYMTABSIZE];
	extern int currentSymTabSize;
    int installId(char *id);
	
    #define _TOKEN_(t) 				return(t##_T);
	#define _TOKEN_INTEGER_(t) 		yylval.iVal = atoi(yytext); return(t);
	#define _TOKEN_REAL_(t) 		yylval.iVal = atof(yytext); return(t);
    #define _TOKEN_CHARACTER_(t) 	yylval.iVal = installId(yytext); return(t);
	#define _TOKEN_IDENTIFIER_(t) 	yylval.iVal = installId(yytext); return(t##_T);
	#define _TOKEN_UNKNOWN_(t)		printf("Unknown token:" #t  "\n");
	    
    #endif
%}

delim                   [ \t\n]
ws                      {delim}+
character               [A-Za-z]
digit                   [0-9]
integer                 {digit}+
real                   	{integer}+\.{integer}+
identifier              {character}({character}|{integer})*
characterConstant		\'{character}\'

%%

{ws}                ; /* white space, do nothing */

"="                 _TOKEN_(EQUAL_TO);
"<>"                _TOKEN_(NOT_EQUAL);
"<"                 _TOKEN_(LESS_THAN);
">"                 _TOKEN_(GREATER_THAN);
"<="                _TOKEN_(LESS_THAN_EQUAL_TO);
">="                _TOKEN_(GREATER_THAN_EQUAL_TO);
"'"					_TOKEN_(APOSTROPHE);
":"                 _TOKEN_(COLON);
";"                 _TOKEN_(SEMI_COLON);
","                 _TOKEN_(COMMA);
"."                 _TOKEN_(FULL_STOP);
"("                 _TOKEN_(BRA);
")"                 _TOKEN_(KET);
"*"					_TOKEN_(MULTIPLY);
"+"					_TOKEN_(ADD);
"-"					_TOKEN_(MINUS);
"/"					_TOKEN_(DIVIDE);
"->"				_TOKEN_(ASSIGNMENT);

DECLARATIONS		_TOKEN_(DECLARATIONS);
CODE				_TOKEN_(CODE);
IF                  _TOKEN_(IF);
THEN                _TOKEN_(THEN);
ELSE                _TOKEN_(ELSE);
ENDIF               _TOKEN_(END_IF);
FOR                 _TOKEN_(FOR);
IS                  _TOKEN_(IS);
BY                  _TOKEN_(BY);
TO                  _TOKEN_(TO);
ENDFOR              _TOKEN_(END_FOR);
WRITE               _TOKEN_(WRITE);
READ                _TOKEN_(READ);
NOT                 _TOKEN_(NOT);
AND                 _TOKEN_(AND);
OR                  _TOKEN_(OR);
DO                  _TOKEN_(DO);
ENDDO               _TOKEN_(END_DO);
WHILE               _TOKEN_(WHILE);
ENDWHILE            _TOKEN_(END_WHILE);
NEWLINE				_TOKEN_(NEWLINE);
OF					_TOKEN_(OF);
TYPE				_TOKEN_(TYPE);
ENDP				_TOKEN_(ENDP);
INTEGER				_TOKEN_(INTEGER);
CHARACTER			_TOKEN_(CHARACTER);
REAL				_TOKEN_(REAL);


{characterConstant} _TOKEN_CHARACTER_(CHARACTER_CONSTANT_T);
{identifier}        _TOKEN_IDENTIFIER_(ID);
{integer}           _TOKEN_INTEGER_(INTEGER_CONSTANT_T); 
{real}             	_TOKEN_REAL_(REAL_CONSTANT_T);
.|\n				_TOKEN_UNKNOWN_(UNKOWN);


%%

/* Here is the code for the library of symbol table routines */

/* code for a simple symbol table, which is an array of pointers to
   structs, each of which contains an identifier.
*/

#ifndef PRINT

SYMTABNODEPTR newSymTabNode()
{
    return ((SYMTABNODEPTR)malloc(sizeof(SYMTABNODE)));
}

int lookup(char *s)
{
    extern SYMTABNODEPTR symbolTable[SYMTABSIZE];
    extern int currentSymTabSize;
    int i;

    for(i=0; i<currentSymTabSize; i++)
    {
        if(strncmp(s,symbolTable[i]->identifier,IDLENGTH) == 0)
        {
            return (i);
        }
    }
    return (-1);    
}

/* Look up an identifier in the symbol table, if its there return
   its index.  If its not there, put it in the end position,
   as long as the table isn't full, and return its index.
*/

int installId(char *id) 
{
    extern SYMTABNODEPTR symbolTable[SYMTABSIZE]; 
    extern int currentSymTabSize;
    int index;

    index = lookup(id);
    if (index >= 0)
    {
        return (index);
    }
    else 
       if (currentSymTabSize >= SYMTABSIZE) 
          /* symbolTable is full */
          return (NOTHING) ;
    else
    {
       symbolTable[currentSymTabSize] = newSymTabNode();

       /* Recommended code for preventing buffer overrun on bounded strings */

       strncpy(symbolTable[currentSymTabSize]->identifier,id,IDLENGTH);
       symbolTable[currentSymTabSize]->identifier[IDLENGTH-1] = '\0';
       
       if(id == "INTEGER_CONSTANT_T" || id == "REAL_CONSTANT_T" || id == "CHARACTER_CONSTANT_T"){
        symbolTable[currentSymTabSize]->type = id;
       }
      
       
       return(currentSymTabSize++);
    }
}
#endif

