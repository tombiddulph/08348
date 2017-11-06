%{
    #include<stdio.h>
 

	#ifdef PRINT

    #define _TOKEN_(t) 				printf("Token: " #t "\n");
	#define _TOKEN_INTEGER_(t) 		printf("Integer token:  %i\n", atoi(yytext));
	#define _TOKEN_REAL_(t) 		printf("Real token: %f\n", atof(yytext));
	#define _TOKEN_CHARACTER_(t) 	printf("Character token: %c\n", yytext[1]);
    #define _TOKEN_IDENTIFIER_(t) 	printf("Identifier token: %s\n",yytext); 
	#define _TOKEN_UNKNOWN_(t)		printf("Unkown token: %s\n", yytext);

    #else

    #define _TOKEN_(t) 				return(t);
	#define _TOKEN_INTEGER_(t) 		yylval.iVal	= atoi(yytext); return(t);
	#define _TOKEN_REAL_(t) 		yylval.iVal	= atof(yytext); return(t);
	#define _TOKEN_CHARACTER_(t) 	yylval.iVal	= strdup(yytext)[1]; return(t);
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
"<>"                _TOKEN_(NOTEQUAL);
"<"                 _TOKEN_(LESS THAN);
">"                 _TOKEN_(GREATER THAN);
"<="                _TOKEN_(LESS_THAN _EQUAL_TO);
">="                _TOKEN_(GREATER_THAN_EQUAL_TO);
"'"					_TOKEN_(APOSTROPHE);
":"                 _TOKEN_(COLON);
";"                 _TOKEN_(SEMI_COLON);
","                 _TOKEN_(COMMA);
"."                 _TOKEN_(FULL STOP);
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
ENDIF               _TOKEN_(ENDIF);
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


{characterConstant} _TOKEN_CHARACTER_(characterConstant);
{identifier}        _TOKEN_IDENTIFIER_(identifier);
{integer}           _TOKEN_INTEGER_(integer); 
{real}             	_TOKEN_REAL_(real);
.|\n				_TOKEN_UNKNOWN_(UNKOWN);
