%{
    #include<stdio.h>
    #define PRINT_TOKEN(t) printf("TOKEN: " #t "\n");
%}

delim                   [ \t\n]
ws                      {delim}+
character               [A-Za-z]
digit                   [0-9]
integer                 {digit}+
float                   {integer}+\.{integer}+
identifier              {character}({character}|{integer})*

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
":"                 PRINT_TOKEN("COLON");
";"                 PRINT_TOKEN("SEMI COLON");
","                 PRINT_TOKEN("COMMA");
"."                 PRINT_TOKEN("FULL STOP");
"("                 PRINT_TOKEN("BRA");
")"                 PRINT_TOKEN("KET");


IF                  PRINT_TOKEN(IF);
THEN                PRINT_TOKEN(THEN);
ELSE                PRINT_TOKEN(ELSE);
ENDIF               PRINT_TOKEN(END_IF);
FOR                 PRINT_TOKEN(FOR);
IS                  PRINT_TOKEN(IS);
BY                  PRINT_TOKEN(BY);
TO                  PRINT_TOKEN(TO);
END_FOR             PRINT_TOKEN(END_FOR);
WRITE               PRINT_TOKEN(WRITE);
READ                PRINT_TOKEN(READ);
NOT                 PRINT_TOKEN(NOT);
AND                 PRINT_TOKEN(AND);
OR                  PRINT_TOKEN(OR);
DO                  PRINT_TOKEN(DO);
ENDDO               PRINT_TOKEN(ENDDO);
WHILE               PRINT_TOKEN(WHILE);
ENDWHILE            PRINT_TOKEN(ENDWHILE);


{identifier}        printf("Identifier: %s\n", yytext);

%%
