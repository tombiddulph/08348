%{
	
%}

%token COLON ENDP DECLARATIONS CODE OF TYPE SEMICOLON COMMA CHARACTER INTEGER REAL TO
	   IF ENDIF THEN ELSE IS OR GREATERTHAN GREATERTHANEQUALTO LESSTHANEQUALTO LESSTHAN 
	   WHILE FULLSTOP NEWLINE BRA KET ADD MINUS DIVIDE MULTIPLY EQUALS NOTEQUAL
	   FOR ENDFOR APOSTROPHE ASSIGNMENT READ WRITE NOT DO ENDDO ENDWHILE AND BY

%token IDENTIFIER	   

%%
program :  IDENTIFIER  COLON block ENDP IDENTIFIER
        ;

block   :  DECLARATIONS declaration_block CODE statement_list
        ;

declaration_block  :    identifiers  OF TYPE type SEMICOLON 
					  | identifiers  OF TYPE type SEMICOLON declaration_block
                      ;

identifiers :  IDENTIFIER | IDENTIFIER COMMA identifiers
            ;

type    :  CHARACTER | INTEGER | REAL
        ;

statement_list  :  statement SEMICOLON statement_list | statement
                ;

statement  :  assignment_statement
			  | if_statement
			  | do_statement
			  | while_statement
			  | for_statement
			  | write_statement
			  | read_statement
			  ;

assignment_statement    :  expression ASSIGNMENT IDENTIFIER
                        ;

if_statement  :     IF conditional THEN statement_list ENDIF
			        | IF conditional THEN statement_list ELSE statement_list ENDIF
                    ;

do_statement    :  DO statement_list WHILE conditional ENDDO
                ;

while_statement     :  WHILE conditional DO statement_list ENDWHILE
                    ;

for_statement  :    FOR IDENTIFIER IS expression BY expression TO expression
				    DO statement_list ENDFOR
                    ;

write_statement  :  WRITE BRA output_list KET 
					| NEWLINE
                    ;
					
read_statement  :  READ BRA IDENTIFIER KET
                ;

output_list  :  value COMMA output_list 
				| value
                ;   

conditional  :  expression comparator expression
				| NOT conditional
				| expression comparator expression AND conditional
				| expression comparator expression OR conditional
                ;

comparator  : EQUALS 
			| NOTEQUAL 
			| LESSTHAN 
			| GREATERTHAN 
			| LESSTHANEQUALTO 
			| GREATERTHANEQUALTO
            ;

expression  :  expression ADD term
			   | expression MINUS term
			   | term 
               ;

term  :  term ADD value
		 | term MINUS value
		 | value
         ;

value  :  IDENTIFIER 
		  | constant
		  | BRA expression KET
          ;

constant    :  number_constant | character_contstant  
            ;

character_contstant :  APOSTROPHE character APOSTROPHE
                    ;

number_constant  :  integer 
					| MINUS integer 
					| integer FULLSTOP integer
					| MINUS  integer FULLSTOP integer
                    ;

integer     :  digit | digit integer	
            ;
			  
%%

