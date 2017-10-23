%{

    #define YYDEBUG
    extern int yylineno; /* from lexer */
    void yyerror(char *s, ...);

%}


%debug

%union 
{
    int iVal;
    TERNARY_TREE  tVal;
}

// These are lexical togens
%token<iVal> IDENTIFIER  DECLARATIONS CODE IF THEN ELSE ENDIF FOR IS BY TO ENDFOR WRITE READ NOT AND OR DO ENDDO WHILE ENDWHILE NEWLINE OF TYPE word
    
// These tokens don't return a value
%token COLON FULLSTOP ENDP
    

// These rules return a type of tVal    
%token<tVal>  block line expr term factor

%%

program             : IDENTIFIER COLON block ENDP IDENTIFIER FULLSTOP
                    ;
                    
block               : DECLARATIONS declaration_block CODE statement_list
                    ;

declaration_block   : identifier OF TYPE
                    ;       

identifier          : word     
                    ;


%%
