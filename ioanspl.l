%{

#include <string.h>

#define PRINT

#ifdef PRINT
#define TOKEN(t) printf("Token: " #t "\n");
#define TOKEN_INTEGER(t) printf("Token integer: " #t " %d\n",atoi(yytext));
#define TOKEN_REAL(t) printf("Token real: " #t " %f\n",atof(yytext));
#define TOKEN_IDENTIFIER(t) printf("Token identifier: " #t " %s\n",yytext);
#else
#define TOKEN(t) return(t);
#define TOKEN_INTEGER(t)  yylval.iVal = atoi(yytext);  return(t);
#define TOKEN_REAL(t)  yylval.fVal = atof(yytext);  return(t);
#define TOKEN_IDENTIFIER(t)  yylval.name = strdup(yytext);  return(t);
					
#endif

//characterConstant	\'{character}\'
//real	          	(\-?){integer}+\.{integer}+
%}

delim           	[ \t\r\n]
ws              	{delim}+
digit           	[0-9]
integer          	{digit}+
real	          	{integer}+\.{integer}+
character			[a-zA-Z]+
characterConstant	"'"{character}"'"
identifier			{character}({character}|{integer})*
%%
{ws}            	; /* Do Nothing */
"+"             	TOKEN(PLUS);
"*"             	TOKEN(TIMES);
"-"					TOKEN(MINUS);
"/"					TOKEN(DIVIDE);
"<"					TOKEN(L_THAN);
"<="				TOKEN(LE_THAN);
">"					TOKEN(GR_THAN);
">="				TOKEN(GRE_THAN);
"->"				TOKEN(ASSIGN);
"("            		TOKEN(BRA);
":"					TOKEN(COLON);
";"					TOKEN(SEMICOLON);
"'"					TOKEN(APOSTROPHE);
"."					TOKEN(DOT);
")"            		TOKEN(KET);
","            		TOKEN(COMMA);
"="            		TOKEN(EQUAL);
"<>"            	TOKEN(DIFFERENT);
"WHILE"				TOKEN(WHILE);
"ENDWHILE"			TOKEN(ENDWHILE);
"FOR"				TOKEN(FOR);
"TO"				TOKEN(TO);
"DO"				TOKEN(DO);
"IF"				TOKEN(IF);
"ELSE"				TOKEN(ELSE);
"ENDIF"				TOKEN(ENDIF);
"DECLARATIONS"		TOKEN(DECLARATIONS);
"CODE"				TOKEN(CODE);
"ENDP"				TOKEN(ENDP);
"EMPTY"				TOKEN(EMPTY);
"READ"				TOKEN(READ);
"IS"				TOKEN(IS);
"BY"				TOKEN(BY);
"THEN"				TOKEN(THEN);
"NOT"				TOKEN(NOT);
"AND"				TOKEN(AND);
"OR"				TOKEN(OR);
"WRITE"				TOKEN(WRITE);
"NEWLINE"			TOKEN(NEWLINE);
"REAL"				TOKEN(REAL_T);
"CHARACTER"			TOKEN(CHAR_T);
"INTEGER"			TOKEN(INTEGER_T);
"OF"				TOKEN(OF);
"TYPE"				TOKEN(TYPE);
{integer}        	TOKEN_INTEGER(INTEGER);
{real}        		TOKEN_REAL(REAL);
{identifier}        TOKEN_IDENTIFIER(identifier);
