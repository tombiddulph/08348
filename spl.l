%{
    #include<stdio.h>
    //#define PRINT

    #define PRINT

    #ifdef PRINT
    #define _TOKEN_(t) printf("TOKEN: " #t "\n");
    #define KEYWORD(k) _TOKEN_(k);

    #define _CHARACTER_CONSTANT_(c) printf("Character constant: " #c "\n", yytext);
    #define _FLOAT_(f) printf("Float token: %d" #f "\n", atof(yytext));
    #define _INTEGER_(i) printf("Integer token: %d" #i "\n", atoi(yytext));

     

    #else

    //#define _TOKEN_(t) return(t_##x);
    //#define KEYWORD(x) yylval.iVal = (t_##x); _TOKEN_(x);

    #endif
%}

delim                   [ \t\n]
ws                      {delim}+
character               [A-Za-z]
digit                   [0-9]
integer                 {digit}+
float                   {integer}+\.{integer}+
identifier              {character}({character}|{integer})*
characterConstant		\'{character}\'

%%

{ws}                ; /* white space, do nothing */
{integer}           printf("unsigned integer: %d\n", atoi(yytext)); 
{float}             printf("float %f\n", atof(yytext));


"="                 _TOKEN_(EQUALS);
"<>"                _TOKEN_(NOTEQUAL);
"<"                 _TOKEN_(LESSTHAN);
">"                 _TOKEN_(GREATERTHAN);
"<="                _TOKEN_(LESSTHANEQUALTO);
">="                _TOKEN_(GREATERTHANEQAULTO);
"'"					_TOKEN_(APOSTROPHE);
":"                 _TOKEN_(COLON);
";"                 _TOKEN_(SEMICOLON);
","                 _TOKEN_(COMMA);
"."                 _TOKEN_(FULLSTOP);
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
ENDFOR              _TOKEN_(ENDFOR);
WRITE               _TOKEN_(WRITE);
READ                _TOKEN_(READ);
NOT                 _TOKEN_(NOT);
AND                 _TOKEN_(AND);
OR                  _TOKEN_(OR);
DO                  _TOKEN_(DO);
ENDDO               _TOKEN_(ENDDO);
WHILE               _TOKEN_(WHILE);
ENDWHILE            _TOKEN_(ENDWHILE);
NEWLINE				_TOKEN_(NEWLINE);
OF					_TOKEN_(OF);
TYPE				_TOKEN_(TYPE);
ENDP				_TOKEN_(ENDP);
INTEGER				_TOKEN_("TYPE: INTEGER");
CHARACTER			_TOKEN_("TYPE: CHARACTER");
REAL				_TOKEN_("TYPE: REAL");


{characterConstant} KEYWORD(CHARACTER_CONSTANT);
{identifier}        printf("Identifier: %s\n", yytext);
.|\n                printf("Unknown symbol! %s\n", yytext);



%%
