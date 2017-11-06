%{

/* SPL01.y - SPL01 parser */
/* Author: Peter Parsons */
/* Revision: Oct 08 BCT */

/* Skeleton yacc file that can be used */
/* This file shows how a parser could build up a parse tree

   Do not use this until you need to, and understand some
   of the material on tree building and walking.             */

/* declare some standard headers to be used to import declarations
   and libraries into the parser. */

#include <stdio.h>
#include <stdlib.h>

/* make forward declarations to avoid compiler warnings */
int yylex (void);
void yyerror (char *);

/* 
   Some constants.
*/

  /* These constants are used later in the code */
#define SYMTABSIZE     50
#define IDLENGTH       15
#define NOTHING        -1
#define INDENTOFFSET    2

  enum ParseTreeNodeType { PROGRAM, BLOCK } ;  
                          /* Add more types here, as more nodes
                                           added to tree */

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef NULL
#define NULL 0
#endif

/* ------------- parse tree definition --------------------------- */

struct treeNode {
    int  item;
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;
    struct treeNode *third;
  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE        *TERNARY_TREE;

/* ------------- forward declarations --------------------------- */

TERNARY_TREE create_node(int,int,TERNARY_TREE,TERNARY_TREE,TERNARY_TREE);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
};

typedef  struct symTabNode SYMTABNODE;
typedef  SYMTABNODE        *SYMTABNODEPTR;

SYMTABNODEPTR  symTab[SYMTABSIZE]; 

int currentSymTabSize = 0;
%}

%start  program

%debug

%union 
{
    int iVal;
    TERNARY_TREE  tVal;
}

// These are lexical tokens

%token<ival> 	IDENTIFIER BRA KET CHARACTER_CONSTANT NUMBER_CONSTANT

%token<iVal> 	DECLARATIONS CODE IF THEN ELSE ENDIF 
				FOR IS BY TO END_FOR WRITE READ NOT AND OR DO END_DO 
				WHILE END_WHILE NEWLINE OF TYPE word CHAR REAL INTEGER
				ASSIGNMENT EQUAL_TO NOT_EQUAL LESS_THAN GREATER_THAN
				LESS_THAN_EQUAL_TO GREATER_THAN_EQUAL_TO
				MULTIPLY ADD MINUS DIVIDE
    
// These tokens don't return a value
%token 		COLON FULL_STOP ENDP SEMI_COLON COMMA
    

// These rules return a type of tVal    
%type<tVal>  	program expr term factor statement_block statement 
				for_statement if_statement declarations declaration_blocks 
				declaration_block identifier_block assignment_statement value 
				write_statement conditional comparator output_block read_statement 
				character_constant constant number_constant while_statement do_statement



%%

program             	: IDENTIFIER COLON declarations CODE ENDP IDENTIFIER FULL_STOP
						;
						
declarations			: DECLARATIONS declaration_blocks
						;
	
declaration_blocks		: declaration_blocks declaration_block 
						| declaration_block
						;
				
declaration_block   	: IDENTIFIER OF TYPE CHAR SEMI_COLON
						| IDENTIFIER OF TYPE INTEGER SEMI_COLON
						| IDENTIFIER OF TYPE REAL SEMI_COLON
						;       
	
identifier_block		: identifier_block COMMA IDENTIFIER
						| IDENTIFIER
						
statement_block			: statement_block SEMI_COLON statement 
						| statement
						;
	
statement				: assignment_statement
						| write_statement
						| read_statement
						| if_statement
						| do_statement
						| while_statement
						| for_statement
						;
					
assignment_statement	: expr ASSIGNMENT IDENTIFIER
						;

write_statement			: WRITE BRA output_block KET
						| NEWLINE
						;
						
read_statement			: READ BRA IDENTIFIER KET
						;
						
if_statement			: IF conditional THEN statement_block ENDIF
						| IF conditional THEN statement_block ELSE ENDIF
						;
						
do_statement			: DO statement_block WHILE conditional END_DO
						;
						
while_statement			: WHILE conditional DO statement_block END_WHILE		
						;
						
for_statement			: FOR IDENTIFIER IS expr BY expr TO expr DO statement_block END_FOR						
					
output_block			: output_block COMMA value 
						| value
						;
						
value					: constant
						| IDENTIFIER
						| BRA expr KET
						;
						
constant				: NUMBER_CONSTANT
						| CHARACTER_CONSTANT
						;
						
character_constant		: CHARACTER_CONSTANT
						;
						
number_constant			: INTEGER 
						| REAL
						| MINUS INTEGER
						| MINUS REAL
						;
						
conditional				: expr comparator expr
						| expr comparator OR conditional
						| expr comparator AND conditional
						| NOT conditional
						;

comparator				: EQUAL_TO
						| NOT_EQUAL
						| LESS_THAN
						| GREATER_THAN
						| LESS_THAN_EQUAL_TO
						| GREATER_THAN_EQUAL_TO
						;
						
expr					: expr ADD term
						| expr MINUS term
						| term
						;
						
term					: term MULTIPLY factor
						| term DIVIDE factor
						| factor
						;
						
factor					: IDENTIFIER
						| constant
						| BRA expr KET
						;

%%

/* Code for routines for managing the Parse Tree */

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1,
			 TERNARY_TREE  p2, TERNARY_TREE  p3)
{
    TERNARY_TREE t;
    t = (TERNARY_TREE)malloc(sizeof(TREE_NODE));
    t->item = ival;
    t->nodeIdentifier = case_identifier;
    t->first = p1;
    t->second = p2;
    t->third = p3;
    return (t);
}


/* Put other auxiliary functions here */

#include "lex.yy.c"