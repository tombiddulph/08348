%{
    #include<stdio.h>
    //#define PRINT


    #define PRINT_TOKEN(t) printf("TOKEN: " #t "\n");
    #define KEYWORD(k) PRINT_TOKEN(k);

    #ifdef PRINT

   

    #else

    //#define PRINT_TOKEN(t) return(t_##x);
    //#define KEYWORD(x) yylval.iVal = (t_##x); PRINT_TOKEN(x);

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


"="                 PRINT_TOKEN("Comparator: EQUALS");
"<>"                PRINT_TOKEN("Comparator: NOT EQUAL");
"<"                 PRINT_TOKEN("Comparator: LESS THAN");
">"                 PRINT_TOKEN("Comparator: GREATER THAN");
"<="                PRINT_TOKEN("Comparator: GREATER THAN EQUAL TO");
">="                PRINT_TOKEN("Comparator: LESS THAN EQUAL TO");
"'"					PRINT_TOKEN(APOSTROPHE);
":"                 PRINT_TOKEN(COLON);
";"                 PRINT_TOKEN(SEMI COLON);
","                 PRINT_TOKEN(COMMA);
"."                 PRINT_TOKEN(FULL STOP);
"("                 PRINT_TOKEN(BRA);
")"                 PRINT_TOKEN(KET);
"*"					PRINT_TOKEN("OPERATOR: MULTIPLY");
"+"					PRINT_TOKEN("OPERATOR: ADD");
"-"					PRINT_TOKEN("OPERATOR: MINUS");
"/"					PRINT_TOKEN("OPERATOR: DIVIDE");
"->"				PRINT_TOKEN("OPERATOR: ASSIGNMENT");

DECLARATIONS		PRINT_TOKEN(DECLARATIONS);
CODE				PRINT_TOKEN(CODE);
IF                  PRINT_TOKEN(IF);
THEN                PRINT_TOKEN(THEN);
ELSE                PRINT_TOKEN(ELSE);
ENDIF               PRINT_TOKEN(ENDIF);
FOR                 PRINT_TOKEN(FOR);
IS                  PRINT_TOKEN(IS);
BY                  PRINT_TOKEN(BY);
TO                  PRINT_TOKEN(TO);
ENDFOR              PRINT_TOKEN(ENDFOR);
WRITE               PRINT_TOKEN(WRITE);
READ                PRINT_TOKEN(READ);
NOT                 PRINT_TOKEN(NOT);
AND                 PRINT_TOKEN(AND);
OR                  PRINT_TOKEN(OR);
DO                  PRINT_TOKEN(DO);
ENDDO               PRINT_TOKEN(ENDDO);
WHILE               PRINT_TOKEN(WHILE);
ENDWHILE            PRINT_TOKEN(ENDWHILE);
NEWLINE				PRINT_TOKEN(NEWLINE);
OF					PRINT_TOKEN(OF);
TYPE				PRINT_TOKEN(TYPE);
ENDP				PRINT_TOKEN(ENDP);
INTEGER				PRINT_TOKEN("TYPE: INTEGER");
CHARACTER			PRINT_TOKEN("TYPE: CHARACTER");
REAL				PRINT_TOKEN("TYPE: REAL");


{characterConstant} KEYWORD(CHARACTER_CONSTANT);
{identifier}        printf("Identifier: %s\n", yytext);
.|\n                printf("Unknown symbol! %s\n", yytext);



%%
