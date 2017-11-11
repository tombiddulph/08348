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

   
extern int yydebug;

   
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

%token<iVal>			ID BRA KET NUMBER_CONSTANT

%token<iVal>	DECLARATIONS IF_T THEN ELSE_T END_IF 
				FOR_T IS BY TO END_FOR WRITE READ NOT AND OR  END_DO 
				WHILE_T END_WHILE NEWLINE OF TYPE word 
				ASSIGNMENT EQUAL_TO NOT_EQUAL LESS_THAN GREATER_THAN
				LESS_THAN_EQUAL_TO GREATER_THAN_EQUAL_TO APOSTROPHE
				MULTIPLY ADD MINUS DIVIDE STATEMENT_BLOCK
				CHARACTER_CONSTANT INTEGER_CONSTANT REAL_CONSTANT
				CHARACTER_T INTEGER_T REAL_T CODE COMMA
    
// These tokens don't return a value
%token 		COLON FULL_STOP ENDP SEMI_COLON DO_T
    

// These rules return a type of tVal    
%type<tVal>  	program expr term factor statement_block statement 
				for_statement if_statement declarations declaration_blocks 
				declaration_block identifier_block assignment_statement  
				write_statement conditional comparator output_block read_statement 
				character_constant constant number_constant while_statement do_statement



%%

program             	: ID COLON declarations CODE statement_block ENDP ID FULL_STOP 
						{
							TERNARY_TREE parseTree;
							parseTree = create_node($1, PROGRAM, $3, NULL, NULL);
							
							if($1 != $3)
							{
								/* IDs don't match work out how to handle this */
								
							}
							
						}
						;
						
declarations			: DECLARATIONS declaration_blocks
						{
							
						}
						| /* empty*/
						{
							$$ = create_node(NULL, DECLARATION, NULL, NULL, NULL);
						}
						;
	
declaration_blocks		: declaration_blocks declaration_block 
						{
							$$ = $1;
						}
						| declaration_block
						{
							$$ = $1;
						}
						;
				
declaration_block   	: identifier_block OF TYPE CHARACTER_T SEMI_COLON
						{
							$$ = $1;
						}
						| identifier_block OF TYPE INTEGER_T SEMI_COLON
						{
							$$ = $1;
						}
						| identifier_block OF TYPE REAL_T SEMI_COLON
						{
							$$ = $1;
						}
						;       
	
identifier_block		: identifier_block COMMA ID
						{
							$$ = $1;
						}
						| ID
						{
							$$ = $1;
						}
						;
						
statement_block			: statement_block SEMI_COLON statement 
						{
							$$ = $1;
						}
						| statement
						{
							$$ = $1;
						}
						;
	
statement				: assignment_statement
						{
							$$ = $1;
						}
						| write_statement
						{
							$$ = $1;
						}
						| read_statement
						{
							$$ = $1;
						}
						| if_statement
						{
							$$ = $1;
						}
						| do_statement
						{
							$$ = $1;
						}
						| while_statement
						{
							$$ = $1;
						}
						| for_statement
						{
							$$ = $1;
						}
						;
					
assignment_statement	: expr ASSIGNMENT ID
						{
							$$ = $1;
						}
						;

write_statement			: WRITE BRA output_block KET
						{
							$$ = $1;
						}
						| NEWLINE
						{
							$$ = $1;
						}
						;
						
read_statement			: READ BRA ID KET
						{
							$$ = $1;
						}
						;
						
if_statement			: IF_T conditional THEN statement_block END_IF
						{
							$$ = $1;
						}
						| IF_T conditional THEN statement_block ELSE_T statement_block END_IF
						{
							$$ = $1;
						}
						;
						
do_statement			: DO_T statement_block WHILE_T conditional END_DO
						{
							$$ = 0;
						}
						;
						
while_statement			: WHILE_T conditional DO_T statement_block END_WHILE
						{
							$$ = $1;
						}		
						;
						
for_statement			: FOR_T ID IS expr BY expr TO expr DO_T statement_block END_FOR
						{
							$$ = $1;
						}			
						;			
					
output_block			: output_block COMMA term 
						{
							$$ = $1;
						}
						| term
						{
							$$ = $1;
						}
						;
						

						
constant				: number_constant
						{
							$$ = $1;
						}
						| character_constant
						{
							$$ = $1;
						}
						;
						
character_constant		: CHARACTER_CONSTANT
						{
							$$ = $1;
						}
						;
						
number_constant			: INTEGER_CONSTANT 
						{
							$$ = $1;
						}
						| REAL_CONSTANT
						{
							$$ = $1;
						}
						| MINUS INTEGER_CONSTANT
						{
							$$ = $1;
						}
						| MINUS REAL_CONSTANT
						{
							$$ = $1;
						}
						;
						
conditional				: expr comparator expr
						{
							$$ = $1;
						}
						| expr comparator expr OR conditional
						{
							$$ = $1;
						}
						| expr comparator expr AND conditional
						{
							$$ = $1;
						}
						| NOT conditional
						{
							$$ = $1;
						}
						;

comparator				: EQUAL_TO
						{
							$$ = $1;
						}
						| NOT_EQUAL
						{
							$$ = $1;
						}
						| LESS_THAN
						{
							$$ = $1;
						}
						| GREATER_THAN
						{
							$$ = $1;
						}
						| LESS_THAN_EQUAL_TO
						{
							$$ = $1;
						}
						| GREATER_THAN_EQUAL_TO
						{
							$$ = $1;
						}
						;
						
expr					: expr ADD term
						{
							$$ = $1;
						}
						| expr MINUS term
						{
							$$ = $1;
						}
						| term
						{
							$$ = $1;
						}
						;
						
term					: term MULTIPLY factor
						{
							$$ = $1;
						}
						| term DIVIDE factor
						{
							$$ = $1;
						}
						| factor
						{
							$$ = $1;
						}
						;
						
factor					: ID
						{
							$$ = $1;
						}
						| constant
						{
							$$ = $1;
						}
						| BRA expr KET
						{
							$$ = $1;
						}
						;

%%

/* Code for routines for managing the Parse Tree */

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1, TERNARY_TREE  p2, TERNARY_TREE  p3)
			
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