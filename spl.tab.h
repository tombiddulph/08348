
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IDENTIFIER = 258,
     BRA = 259,
     KET = 260,
     CHARACTER_CONSTANT = 261,
     NUMBER_CONSTANT = 262,
     DECLARATIONS = 263,
     CODE = 264,
     IF = 265,
     THEN = 266,
     ELSE = 267,
     ENDIF = 268,
     FOR = 269,
     IS = 270,
     BY = 271,
     TO = 272,
     END_FOR = 273,
     WRITE = 274,
     READ = 275,
     NOT = 276,
     AND = 277,
     OR = 278,
     DO = 279,
     END_DO = 280,
     WHILE = 281,
     END_WHILE = 282,
     NEWLINE = 283,
     OF = 284,
     TYPE = 285,
     word = 286,
     CHAR = 287,
     REAL = 288,
     INTEGER = 289,
     ASSIGNMENT = 290,
     EQUAL_TO = 291,
     NOT_EQUAL = 292,
     LESS_THAN = 293,
     GREATER_THAN = 294,
     LESS_THAN_EQUAL_TO = 295,
     GREATER_THAN_EQUAL_TO = 296,
     MULTIPLY = 297,
     ADD = 298,
     MINUS = 299,
     DIVIDE = 300,
     COLON = 301,
     FULL_STOP = 302,
     ENDP = 303,
     SEMI_COLON = 304,
     COMMA = 305
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 85 "spl.y"

    int iVal;
    TERNARY_TREE  tVal;



/* Line 1676 of yacc.c  */
#line 109 "spl.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


