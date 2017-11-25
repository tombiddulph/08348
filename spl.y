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
#include <stdarg.h>
#include <string.h>


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


  enum ParseTreeNodeType
						{
							PROGRAM, DECLARATIONS, BLOCK_DECLARATIONS, BLOCK, STATEMENT_BLOCK,
							ASSIGNMENT_STATEMENT, WRITE_STATEMENT, READ_STATEMENT, IF_STATEMENT,
							IF_STATEMENT_ELSE, DO_STATEMENT, WHILE_STATEMENT, NEWLINE_STATEMENT,
							FOR_STATEMENT, FOR_BODY, WRITE_BLOCK, CONDITIONAL, OUTPUT_BLOCK,
							CONDITIONAL_NOT, CONDITIONAL_AND, CONDITIONAL_OR, CONDITION, EXPR,
							VAL_ID, VAL_BRACKETS, VAL_NEGATIVE, VAL, COMPARATOR_EQUAL_TO,
							COMPARATOR_NOT_EQUAL_TO, COMPARATOR_LESS_THAN, COMPARATOR_GREATER_THAN,
							COMPARATOR_LESS_THAN_EQUAL_TO, COMPARATOR_GREATER_THAN_EQUAL_TO,
							OP_ADD, OP_MINUS, OP_MULTIPLY, OP_DIVIDE, TYPE_INT, TYPE_REAL, TYPE_CHARACTER,
							CONST_INT, CONST_REAL,CONST_CHARACTER, CONST, TYPE, STATEMENT, IDENTIFIER_BLOCK,
							DECLARATION
						};

	char *NodeName[] =	{	
							"PROGRAM", "DECLARATIONS", "BLOCK_DECLARATIONS", "BLOCK", "STATEMENT_BLOCK", 
							"ASSIGNMENT_STATEMENT", "WRITE_STATEMENT", "READ_STATEMENT", "IF_STATEMENT", 
							"IF_STATEMENT_ELSE", "DO_STATEMENT", "WHILE_STATEMENT", "NEWLINE_STATEMENT", 
							"FOR_STATEMENT", "FOR_BODY", "WRITE_BLOCK", "CONDITIONAL", "OUTPUT_BLOCK",
							"CONDITIONAL_NOT", "CONDITIONAL_AND", "CONDITIONAL_OR", "CONDITION", "EXPR", 
							"VAL_ID", "VAL_BRACKETS", "VAL_NEGATIVE", "VAL", "COMPARATOR_EQUAL_TO", 
							"COMPARATOR_NOT_EQUAL_TO", "COMPARATOR_LESS_THAN", "COMPARATOR_GREATER_THAN", 
							"COMPARATOR_LESS_THAN_EQUAL_TO", "COMPARATOR_GREATER_THAN_EQUAL_TO", 
							"OP_ADD", "OP_MINUS", "OP_MULTIPLY", "OP_DIVIDE", "TYPE_INT", "TYPE_REAL", 
							"TYPE_CHARACTER", "CONST_INT", "CONST_REAL", "CONST_CHARACTER", "CONST", "TYPE"
							,"STATEMENT", "IDENTIFIER_BLOCK"
						};

						//enum Types { CHARATER, int}		

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
    union{
		int item;
		char *cItem;
	};
	char unionType;
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;

  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE       *BINARY_TREE;

/* ------------- forward declarations --------------------------- */

BINARY_TREE create_node(int,int,BINARY_TREE,BINARY_TREE);
BINARY_TREE create_node_characterArray(char*,int,BINARY_TREE,BINARY_TREE);
void Print(BINARY_TREE t);
#ifdef DEBUG
	void PrintTree(BINARY_TREE t);
	int BufferSize(char *format, ...);
	#define NEWLINE "\n"
#endif	
void WriteCode(BINARY_TREE t);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
	char *nodeType;
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
    BINARY_TREE  tVal;
}

// These are lexical tokens

%token<iVal> ID_T BRA_T INTEGER_CONSTANT_T REAL_CONSTANT_T CHARACTER_CONSTANT_T 


    
/* These tokens don't return a value */
%token 		COLON_T FULL_STOP_T ENDP_T SEMI_COLON_T  ASSIGNMENT_T EQUAL_TO_T 
			
			NOT_EQUAL_T LESS_THAN_EQUAL_TO_T LESS_THAN_T GREATER_THAN_EQUAL_TO_T 
			GREATER_THAN_T ADD_T MINUS_T MULTIPLY_T DIVIDE_T KET_T
			DECLARATIONS_T CODE_T OF_T TYPE_T CHARACTER_T INTEGER_T REAL_T
			IF_T THEN_T ELSE_T END_IF_T DO_T END_DO_T WHILE_T END_WHILE_T 
			 FOR_T END_FOR_T WRITE_T READ_T NEWLINE_T 
			NOT_T COMMA_T APOSTROPHE_T BY_T IS_T TO_T  OR_T AND_T



    

/* These rules return a type of tVal    */ 
 %type<tVal>  	program block declarations statement statement_block
				write_block conditional condition for_block output_block
				expr val comp op type const declaration identifier_block



%%

program             	: ID_T COLON_T block ENDP_T ID_T FULL_STOP_T
						{
						
							BINARY_TREE parseTree = create_node($1, PROGRAM, $3, NULL);
							
#ifdef DEBUG							
						PrintTree(parseTree);
#endif							
						 
						WriteCode(parseTree);
						
							
						}
						;
						
						
block					: DECLARATIONS_T declarations CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2, $4);
						}
						| CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2,NULL);
						}
						;
						
						
						
declarations			: declaration
						{
							$$ = create_node(NOTHING, DECLARATIONS, $1, NULL);
						}
						| declaration declarations
						{
							$$ = create_node(NOTHING, DECLARATIONS, $1, $2);							
						}
						;

declaration				: identifier_block OF_T TYPE_T type SEMI_COLON_T
						{
							$$ = create_node_characterArray($4->cItem, DECLARATION, $1, $4);
						}
						;

identifier_block 		: identifier_block COMMA_T ID_T
						{
							$$ = create_node($3, IDENTIFIER_BLOCK, $1, NULL);
						}	
						| ID_T
						{
							$$ = create_node($1, IDENTIFIER_BLOCK, NULL, NULL);
						}			
						;
statement_block			: statement SEMI_COLON_T statement_block
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, $3);
						}
						| statement
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, NULL);
						}
						;
	
statement				: expr ASSIGNMENT_T ID_T
						{
							$$ = create_node($3, ASSIGNMENT_STATEMENT, $1, NULL);
						}
						|  write_block
						{
							$$ = create_node(NOTHING, WRITE_STATEMENT, $1, NULL);
						}
						| READ_T BRA_T ID_T KET_T
						{
							$$ = create_node($3, READ_STATEMENT, NULL, NULL);
						}
						| IF_T conditional THEN_T statement_block END_IF_T
						{
							$$ =  create_node(NOTHING, IF_STATEMENT, $2, $4);
						}
						| IF_T conditional THEN_T statement_block ELSE_T statement_block END_IF_T
						{
						   $$ = create_node(NOTHING, IF_STATEMENT_ELSE, $2, create_node(NOTHING, IF_STATEMENT_ELSE, $4, $6));
						}
						| DO_T statement_block WHILE_T conditional END_DO_T
						{
							$$ = create_node(NOTHING, DO_STATEMENT, $2, $4);
						}
						| WHILE_T conditional DO_T statement_block END_WHILE_T
						{
							$$ =  create_node(NOTHING, WHILE_STATEMENT, $2, $4);
						}
						| FOR_T for_block statement_block END_FOR_T
						{
							$$ = create_node(NOTHING, FOR_STATEMENT, $2, $3);
						}
						;

for_block				: ID_T IS_T expr BY_T expr TO_T expr DO_T
						{
							$$ = create_node($1, FOR_BODY, $3, create_node(NOTHING, FOR_BODY, $5, $7));
						}						
						;

					
write_block				: NEWLINE_T
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, NULL, NULL);
						}
						| WRITE_T BRA_T output_block KET_T
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, $3, NULL);
						}
						;

output_block			: val
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, NULL);
						}
						| val COMMA_T output_block
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, $3);
						}
						
conditional				: condition
						{
							$$ = create_node(NOTHING, CONDITIONAL, $1, NULL);
						}
						| NOT_T conditional
						{
							$$ = create_node_characterArray("!", CONDITIONAL_NOT, $2, NULL);
						}
						|  condition AND_T conditional
						{
							$$ = create_node_characterArray("&&", CONDITIONAL_AND, $1, $3);
						}
						| condition OR_T conditional
						{
							$$ = create_node_characterArray("||", CONDITIONAL_OR, $1, $3);
						}
						;

condition				: expr comp expr
						{
							$$ = create_node(NOTHING, CONDITION, $1, create_node(NOTHING, CONDITION, $2 ,$3));
						}
						;

expr					: val
						{
							$$ = create_node(NOTHING, EXPR, $1, NULL);
						}
						| val op expr
						{
					    	$$ = create_node(NOTHING, EXPR, $1, create_node(NOTHING, EXPR, $2, $3));
						}
						;

val						:  ID_T
						{
							$$ = create_node($1, VAL_ID, NULL, NULL);
						}
						| BRA_T expr KET_T
						{
							$$ = create_node(NOTHING, VAL_BRACKETS, $2, NULL);
						}
						| MINUS_T const
						{
							$$ = create_node(NOTHING, VAL_NEGATIVE, $2, NULL);
						}
						|  const
						{
							$$ = create_node(NOTHING, VAL, $1, NULL);
						}


comp					: EQUAL_TO_T
						{
							$$ = create_node_characterArray("==", COMPARATOR_EQUAL_TO, NULL, NULL);
						}
						| NOT_EQUAL_T
						{
							$$ = create_node_characterArray("!=", COMPARATOR_NOT_EQUAL_TO, NULL, NULL);
						}
						| LESS_THAN_T
						{
							$$ = create_node_characterArray("<", COMPARATOR_LESS_THAN, NULL, NULL);
						}
						|  GREATER_THAN_T
						{
							$$ = create_node_characterArray(">", COMPARATOR_GREATER_THAN, NULL, NULL);
						}
						|  LESS_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray("<=", COMPARATOR_LESS_THAN_EQUAL_TO, NULL, NULL);
						}
						|  GREATER_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray(">=", COMPARATOR_GREATER_THAN_EQUAL_TO, NULL, NULL);
						}
						;
						

op						: ADD_T
						{
							$$ = create_node_characterArray("+", OP_ADD, NULL, NULL);
						}
						| MINUS_T
						{
							$$ = create_node_characterArray("-", OP_MINUS, NULL, NULL);
						}
						| MULTIPLY_T
						{
							$$ = create_node_characterArray("*", OP_MULTIPLY, NULL, NULL);
						}
						| DIVIDE_T
						{
							$$ = create_node_characterArray("/", OP_DIVIDE, NULL, NULL);
						}
						;
					

type					: INTEGER_T
						{
							$$ = create_node_characterArray("int", TYPE, NULL, NULL);
						}
						| REAL_T
						{
							$$ = create_node_characterArray("float", TYPE, NULL, NULL);
						}
						| CHARACTER_T
						{
							$$ = create_node_characterArray("char", TYPE, NULL, NULL);
						}
						;

const					: INTEGER_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL);
						}
						| REAL_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL);
						}
						| CHARACTER_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL);
						}
						;
%%

/* Code for routines for managing the Parse Tree */


BINARY_TREE create_node(int iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->item = iVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	b->unionType = 'i';
	return (b);
}


BINARY_TREE create_node_characterArray(char* iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->cItem = iVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	b->unionType = 'c';
	return (b);
}




#define NodeType(t) (symTab[t->item]->nodeType)
#define Identifier(t)  (symTab[t->item]->identifier)
#define NodeIdentifier(t)  (NodeName[t->nodeIdentifier])

#ifdef DEBUG

/*  function found here - https://stackoverflow.com/questions/3919995/determining-sprintf-buffer-size-whats-the-standard*/
int BufferSize(char *format, ...)
{
	va_list args;
	va_start(args, format);
	int result = vsnprintf(NULL, 0, format, args);
    va_end(args);
    return result + 1;
}





void PrintTree(BINARY_TREE t)
{

	if(t == NULL) return;





		
		switch(t->nodeIdentifier)
		{
		
			case PROGRAM:
			{

				 printf("PROGRAM -> %s\n", Identifier(t));


				 break;
			}

			case BLOCK_DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier);*/
				break;
			}
			case DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier);*/
				break;
			}
			case STATEMENT_BLOCK:
			{
				/* printf("STATEMENT_BLOCK\n"); */
				break;
			}
			case OP_ADD:
			case OP_DIVIDE:
			case OP_MINUS:
			case OP_MULTIPLY:
			{
				break;
			}
			case CONDITIONAL_AND:
			case CONDITIONAL_NOT:
			case CONDITIONAL_OR:
			{
				printf("Conditional -> %s\n", NodeIdentifier(t));
				break;
			}
			case COMPARATOR_EQUAL_TO:
			case COMPARATOR_NOT_EQUAL_TO:
			case COMPARATOR_LESS_THAN:
			case COMPARATOR_GREATER_THAN:
			case COMPARATOR_LESS_THAN_EQUAL_TO:
			case COMPARATOR_GREATER_THAN_EQUAL_TO:
			{
					printf("Comparator -> [%s] %s\n",t->cItem, NodeIdentifier(t));
					break;
			}
			case CONST:
			{
				
				printf(" Constant [%s] -> %s\n", NodeType(t), Identifier(t));
				break;
			}
			case VAL_ID:
			{
			  /*	printf(" Val Identifier %s of type %s\n",  symTab[t->item]->identifier, symTab[t->item]->nodeType); */
			 	break;
			 }
			case TYPE:
			{
				printf("Type -> %s\n ", t->cItem);
				break;
			}

			default:
			{
				if(t->nodeIdentifier >= 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf(" Node identifier -> %s\n", NodeIdentifier(t));
					
				}
				else
				{
					printf(" Unkown node identifier -> %d\n", t->nodeIdentifier);
					
				}


				if(t->item > 0  && t->item < SYMTABSIZE)

				{
				
					
					printf("Identifier -> %s\n", Identifier(t));
				}
			}
		}
	
		
			PrintTree(t->first);
			PrintTree(t->second);
		
			
}			
#endif



void Print(BINARY_TREE t)
{
 
	if(t == NULL) return;

	
	
	
	switch(t->nodeIdentifier)
		{
		
			case PROGRAM:
			{

				 printf("PROGRAM -> %s\n", Identifier(t));


				 break;
			}

			case BLOCK_DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier); */
				break;
			}
			case DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier); */
				break;
			}
			case STATEMENT_BLOCK:
			{
				/* printf("STATEMENT_BLOCK\n"); */
				break;
			}
			case OP_ADD:
			case OP_DIVIDE:
			case OP_MINUS:
			case OP_MULTIPLY:
			{
				break;
			}
			case CONDITIONAL_AND:
			case CONDITIONAL_NOT:
			case CONDITIONAL_OR:
			{
				printf("Conditional -> %s\n", NodeIdentifier(t));
				break;
			}
			case COMPARATOR_EQUAL_TO:
			case COMPARATOR_NOT_EQUAL_TO:
			case COMPARATOR_LESS_THAN:
			case COMPARATOR_GREATER_THAN:
			case COMPARATOR_LESS_THAN_EQUAL_TO:
			case COMPARATOR_GREATER_THAN_EQUAL_TO:
			{
					printf("Comparator -> [%s] %s\n",t->cItem, NodeIdentifier(t));
					break;
			}
			case CONST:
			{
				
				printf(" Constant [%s] -> %s\n", NodeType(t), Identifier(t));
				break;
			}
			/* case VAL_ID: */
			/* { */
			/* 	printf(" Val Identifier %s of type %s\n",  symTab[t->item]->identifier, symTab[t->item]->nodeType);*/
			/* 	break;*/
			/* }*/
			case TYPE:
			{
				printf("Type -> %s\n ", t->cItem);
				break;
			}

			default:
			{
				if(t->nodeIdentifier >= 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf(" Node identifier -> %s\n", NodeIdentifier(t));
					
				}
				else
				{
					printf(" Unkown node identifier -> %d\n", t->nodeIdentifier);
					
				}


				if(t->item > 0  && t->item < SYMTABSIZE)

				{
						printf("Identifier -> %s\n", Identifier(t));
				}
			}
		}
		Print(t->first);
		Print(t->second);
}


void PrintComment(char *comment)  
{ 
	printf("/* %s */\n",comment);
}

int CheckItem(BINARY_TREE t)
{
	if(t->item > currentSymTabSize || t->item < 0)
	{
		yyerror("Unkown item %s");
		return FALSE;
	}
	
	return TRUE;
}

const char *GetCTypeFlag(char *typeToken)
{
				if(strcmp(typeToken, "CHARACTER_CONSTANT") == 0  || strcmp(typeToken, "char") == 0)
				{
					return "%%c\", ";
				}
				else if(strcmp(typeToken, "INTEGER_CONSTANT") == 0  || strcmp(typeToken, "int") == 0)
				{
					return "%%d\", ";
				}
				else if(strcmp(typeToken, "REAL_CONSTANT") == 0  || strcmp(typeToken, "float") == 0)
				{
					return "%%f\", ";
					
				}
				else
				{
					yyerror("Unexpected type");
				}
}

#define debug_print(a, args...) printf("\t\t%s(%s:%d) " a,  __func__,__FILE__, __LINE__, ##args)
#define debug_println(a, args...) debug_print(a "\n", ##args)


//#define CODEGENDEBUG
char *currentType;
int declarationWritten;
void WriteCode(BINARY_TREE t)
{
	
	if(t == NULL)
	{
		return;
	}

	switch(t->nodeIdentifier)
	{
		case PROGRAM:
		{
			#ifdef CODEGENDEBUG
				debug_println("in Program");
			#endif
			declarationWritten = 0;
			printf("/* Spl program name -> %s */\n", symTab[t->item]->identifier);
			printf("#include <stdio.h>\n");
			printf("int main(void) {\n\n");
			WriteCode(t->first);
			printf("\nreturn 0;\n}\n /* End program -> %s */\n", symTab[t->item]);
			return;
		}

		case BLOCK:
		{
			#ifdef CODEGENDEBUG
			 debug_println("Block first");
			#endif
			WriteCode(t->first);
			#ifdef CODEGENDEBUG
			 debug_println("Block second");
			#endif
			WriteCode(t->second);
			break;
		}
		case DECLARATIONS:
		{
			if(declarationWritten == 0)
			{
				PrintComment("declarations");
				declarationWritten = 1;
			}
			#ifdef CODEGENDEBUG
			 debug_println("Declarations first");
			#endif
			WriteCode(t->first);
			
			printf("\n");
			#ifdef CODEGENDEBUG
			 debug_println("Declarations second");
			#endif
			WriteCode(t->second);
			break;
		}
		case DECLARATION:
		{
			//printf("testItem %s", t->cItem);

			if(t->second != NULL){
				if(t->second->item != 0)
				{

				}
					
			}
			WriteCode(t->second);

			printf(" ");
			
			WriteCode(t->first);
		
			printf(";");
			break;
		}
		case STATEMENT_BLOCK:
		{
			
			WriteCode(t->first);
			#ifdef CODEGENDEBUG
			 debug_println("STATEMENT_BLOCK first");
			#endif
			WriteCode(t->second);
				#ifdef CODEGENDEBUG
			 debug_println("STATEMENT_BLOCK second");
			#endif
			break;
		}
		case READ_STATEMENT:
		{
			printf("scanf(\" %s\", &%s);\n", GetCTypeFlag(symTab[t->item]->nodeType), symTab[t->item]->identifier);
		}
		case WRITE_STATEMENT:
		{
			#ifdef CODEGENDEBUG
				debug_println("Write Statement");
			#endif
			if(t->first == NULL) /* n*/
			{
				printf("printf(\"\\n\");\n");
			}
			else
			{
				WriteCode(t->first);
			}
			break;
		}
		
		case OUTPUT_BLOCK:
		{
			printf("printf(\"");
		
		
			
			if(t->first->first->item)
			{		
				
				const char *nType = symTab[t->first->first->item]->nodeType;
				printf(GetCTypeFlag(symTab[t->first->first->item]->nodeType));
				
				// if(strcmp(nType, "CHARACTER_CONSTANT") == 0)
				// {
				// 	printf("%%c\", ");
				// }
				// else if(strcmp(nType, "INTEGER_CONSTANT") == 0)
				// {
				// 	printf("%%d\", ");
				// }
				// else if(strcmp(nType, "REAL_CONSTANT") == 0)
				// {
				// 	printf("%%f\", ");
				// }
				// else
				// {
				// 	yyerror("Unexpected type");
				// }
					WriteCode(t->first);
					
			}				
					printf(");\n");
				
				WriteCode(t->second);
				break;
		}
		case WRITE_BLOCK:
		{
			if(t->first != NULL) /* val COMMA_T write_block */
			{

				WriteCode(t->first);
			}
			else /* NEWLINE_T */
			{
				printf("printf(\"\\n\");\n");
			}
			break;
			
		}
		case IDENTIFIER_BLOCK:
		{

			

			if(t->unionType == 'i')
			{
					if(symTab[t->item]->nodeType == "NOTHING")
					{
						if(strcmp(currentType, "r") == 0)
						{
							*currentType = 'f';
						}
						

						// symTab[t->item]->nodeType = currentType;
						symTab[t->item]->nodeType = strcmp(currentType, "r") == 0  ?  "f" : currentType ;
					}
					printf("%s", symTab[t->item]->identifier);
					if(t->first != NULL)
					{
						
						printf(", ");
						WriteCode(t->first);
					}
			}
				break;
		}
		case VAL_ID:
		{
			break;
		}
		case VAL_BRACKETS:
		{
			break;
		}
		case VAL_NEGATIVE:
		{
			break;
		}
		case VAL:
		{

	

			if(t->item == NOTHING)
			{
				WriteCode(t->first);
				break;
			}
			else
			{
#ifdef CODEGENDEBUG
	printf("t->item %f at line", t->item, __LINE__);
#endif	
			}
			//printf("%s",symTab[t->item]->identifier);
			// if(t->item != CONST && t->item != EXPR)
			// {
				// if(t->item < 0 || t->item > currentSymTabSize)
				// {
					// printf("unknown identifier");
				// }
				// //printf("HERE %s", t->item);
				// printf("WriteCode t ");
			// }
			// else
			// {
				// printf("WriteCode h ");
				// WriteCode(t->first);
			// }
			break;
		}
		case TYPE:
		{
			printf("%s ", t->cItem);
			currentType = &(t->cItem[0]);
			//currentType = t->cItem[0];
			break;
		}
		case CONST:
		{
			printf("%s", symTab[t->item]->identifier);
		}
	}

	/* WriteCode(t->third); */
}

/* Put other auxiliary functions here */

#include "lex.yy.c"