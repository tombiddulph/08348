%{
    #include<stdio.h>
    #define PRINT_TOKEN(t) printf("TOKEN: " #t);
%}

delim                   [ \t\n]
ws                      {delim}+
character               [A-Za-z]
digit                   [0-9]
integer                 {digit}
float                   {digit}\.{digit}
identifier              {character}({character}|{digit})*

%%

{ws}                 ; /* white space, do nothing */
{integer}           printf("unsigned integer: %d\n", atoi(yytext)); 
{identifier}        printf("identifier: %s", yytext);

"="                 printf("Comparator: EQUALS");
"<>"                printf("Comparator: NOT EQUAL");
"<"                 printf("Comparator: LESS THAN");
">"                 printf("Comparator: GREATER THAN");
"<="                printf("Comparator: GREATER THAN EQUAL TO");
">="                printf("Comparator: LESS THAN EQUAL TO");
":"                 printf("COLON");
";"                 printf("SEMI COLON");
","                 printf("COMMA");
"."                 printf("FULL STOP");
"("                 printf("BRA");
")"                 printf("KET");



IF                  PRINT_TOKEN(IF);
THEN                PRINT_TOKEN(THEN);
ELSE                PRINT_TOKEN(ELSE);
ENDIF               PRINT_TOKEN(END_IF);

FOR                 PRINT_TOKEN(FOR);
IS                  PRINT_TOKEN(IS);
BY                  PRINT_TOKEN(BY);
TO                  PRINT_TOKEN(TO);
DO                  PRINT_TOKEN(DO);
END_FOR             PRINT_TOKEN(END_FOR);
WRITE               PRINT_TOKEN(WRITE);
READ                PRINT_TOKEN(READ);
NOT                 PRINT_TOKEN(NOT);
AND                 PRINT_TOKEN(AND);
OR                  PRINT_TOKEN(OR);
WHILE               PRINT_TOKEN(WHILE);


%%
