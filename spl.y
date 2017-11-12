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

  enum ParseTreeNodeType { PROGRAM, BLOCK, STATEMENT_BLOCK, DECLARATIONS_RULE, ASSIGNMENT_STATEMENT} ;  
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

%token<iVal>			ID BRA_T KET_T NUMBER_CONSTANT

%token<iVal>	IF_T THEN_T ELSE_T END_IF_T DECLARATIONS_T
				FOR_T IS_T BY_T TO_T END_FOR_T WRITE_T READ_T NOT_T AND_T OR_T END_DO_T
				WHILE_T END_WHILE_T NEWLINE_T OF_T TYPE_T word 
				ASSIGNMENT_T EQUAL_TO_T NOT_EQUAL_T LESS_THAN_T GREATER_THAN_T
				LESS_THAN_EQUAL_TO_T GREATER_THAN_EQUAL_TO_T APOSTROPHE_T
				MULTIPLY_T ADD_T MINUS_T DIVIDE_T
				CHARACTER_CONSTANT INTEGER_CONSTANT REAL_CONSTANT
				CHARACTER_T INTEGER_T REAL_T CODE_T COMMA_T
    
// These tokens don't return a value
%token 		COLON_T FULL_STOP_T ENDP_T SEMI_COLON_T DO_T
    

// These rules return a type of tVal    
%type<tVal>  	program expr term factor statement_block statement 
				for_statement if_statement declarations 
				assignment_statement  
				write_statement conditional comparator output_block read_statement 
				character_constant constant number_constant while_statement do_statement block type



%%

program             	: ID COLON_T  block ENDP_T ID FULL_STOP_T
						{
							TERNARY_TREE parseTree;
							parseTree = create_node($1, PROGRAM, $3, NULL, NULL);
							
							if($1 != $3)
							{
								/* IDs don't match work out how to handle this */
								
							}
							
						}
						;
						
						
block					: DECLARATIONS_T declarations CODE_T statement_block
						{
							$$ = $1;
						}
						| CODE_T statement_block
						{
							$$ = $1;
						}
						
						
						
declarations			: ID OF_T TYPE_T type SEMI_COLON_T
						{
							$$ = $1;
						}
						
						| ID OF_T TYPE_T type SEMI_COLON_T declarations
						{
							$$ = $1;
						}
						| ID COMMA_T declarations
						{
							$$ = $1;
						}
					
						;
	
						
statement_block			: statement_block SEMI_COLON_T statement 
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, $3, NULL);
						}
						| statement
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, NULL, NULL);
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
					
assignment_statement	: expr ASSIGNMENT_T ID
						{
							$$ = create_node($3, ASSIGNMENT_STATEMENT, $1, NULL, NULL);
						}
						;

write_statement			: WRITE_T BRA_T output_block KET_T
						{
							$$ = $1;
						}
						| NEWLINE_T
						{
							$$ = $1;
						}
						;
						
read_statement			: READ_T BRA_T ID KET_T
						{
							$$ = $1;
						}
						;
						
if_statement			: IF_T conditional THEN_T statement_block END_IF_T
						{
							$$ = $1;
						}
						| IF_T conditional THEN_T statement_block ELSE_T statement_block END_IF_T
						{
							$$ = $1;
						}
						;
						
do_statement			: DO_T statement_block WHILE_T conditional END_DO_T
						{
							$$ = 0;
						}
						;
						
while_statement			: WHILE_T conditional DO_T statement_block END_WHILE_T
						{
							$$ = $1;
						}		
						;
						
for_statement			: FOR_T ID IS_T expr BY_T expr TO_T expr DO_T statement_block END_FOR_T
						{
							$$ = $1;
						}			
						;			
					
output_block			: output_block COMMA_T term 
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
						| MINUS_T INTEGER_CONSTANT
						{
							$$ = $1;
						}
						| MINUS_T REAL_CONSTANT
						{
							$$ = $1;
						}
						;
						
conditional				: expr comparator expr
						{
							$$ = $1;
						}
						| expr comparator expr OR_T conditional
						{
							$$ = $1;
						}
						| expr comparator expr AND_T conditional
						{
							$$ = $1;
						}
						| NOT_T conditional
						{
							$$ = $1;
						}
						;

comparator				: EQUAL_TO_T
						{
							$$ = $1;
						}
						| NOT_EQUAL_T
						{
							$$ = $1;
						}
						| LESS_THAN_T
						{
							$$ = $1;
						}
						| GREATER_THAN_T
						{
							$$ = $1;
						}
						| LESS_THAN_EQUAL_TO_T
						{
							$$ = $1;
						}
						| GREATER_THAN_EQUAL_TO_T
						{
							$$ = $1;
						}
						;
						
expr					: expr ADD_T term
						{
							$$ = $1;
						}
						| expr MINUS_T term
						{
							$$ = $1;
						}
						| term
						{
							$$ = $1;
						}
						;
						
term					: term MULTIPLY_T factor
						{
							$$ = $1;
						}
						| term DIVIDE_T factor
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
						| BRA_T expr KET_T
						{
							$$ = $1;
						}
						;
						
type					: INTEGER_T
						{
							$$ = $1;
						}
						| REAL_T
						{
							$$ = $1;
						}
						| CHARACTER_T
						{
							$$ = $1;
						}
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