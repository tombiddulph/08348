# SPL Compiler manual


# Table of Contents
1. Coursework overview
2.  Lexer operation
3. Parser operation
4. Extended test results


# Coursework overview
This document explains the coursework produced for the module Languages and their compilers (08348).

The aim of this project is to produce a compiler for the programming language SPL (Simple programming language) that produces ANSI C code with the  tools flex/lex & yacc/bison.

The grammar for the language is defined in the file spl.bnf, the grammar has been converted to rules within a bison file so as they can be used to generate a parser for the language.

The following tables list the features of the compiler and their current state.

| Deliverable | Status | File  |
| ------ | ------ | ------ |
| BNF | Completed | spl.bnf | 
| Lexer | Completed  | spl.l |
| Printing Lexer| Completed  | spl.l |
| Parser | Completed | spl.y  |
| Printing parser | Completed  | spl.y | 
| Code Generator | Completed  | spl.y| 
| Code Optimisation | Unstarted  | spl.y| 




# Lexer operation
The lexer supports two modes of operation:
  - Printing lexical analyser
  - Lexical analyser for bison parser


To build printing lexer the ```PRINT``` macro must be passed be passed to gcc:
```sh
$ flex spl.l
$ gcc -o lexer.exe lex.yy.c -lfl -DPRINT
```

To run the printing lexer you must pass a valid spl file to it eg
```sh
$ parser.exe < a.spl
```

If the lexer succesfully reads the input file it will ouput in the following format

```
 [Token\Symbol]: [NodeIdentifier] -> [Value]
```

# Compile time errors
If an error is detected during code generation a message will be written to ```stderr``` and the execution of the code generator will be terminated


# Parser operation
The parser supports the following two* modes of operation:
  - Parse tree printer
  - Code generator.
  
N.B The command line options for bison such as -t or -v are not considered modes of operation.

To build the compiler in code generation code the following commands must be executed;
```sh
$ flex spl.l
$ bison spl.y
$ gcc -o spl.exe spl.c spl.tab.c -lfl
```



For debug mode the ```DEBUG``` flag must be passed to gcc when compiling :

```sh
$ flex spl.l
$ bison spl.y
$ gcc -o spl.exe spl.c spl.tab.c -lfl -DDEBUG
```
Passing a file to the parser when it is compiled in debug mode will output in the following format:
```
Line: 0   |-\ PROGRAM -> ProgA
Line: 1   |--\ Node identifier -> BLOCK
Line: 2   |---\ Node identifier -> STATEMENT_BLOCK
Line: 3   |----\ Node identifier -> WRITE_STATEMENT
Line: 4   |-----\ Node identifier -> WRITE_BLOCK
Line: 5   |------\ Node identifier -> OUTPUT_BLOCK
Line: 6   |-------\ Node identifier -> VAL
Line: 7   |--------\ Constant [char] -> 'h'
Line: 8   |-----\ Node identifier -> STATEMENT_BLOCK
Line: 9   |------\ Node identifier -> WRITE_STATEMENT
Line: 10  |-------\ Node identifier -> WRITE_BLOCK
...
```
# Extended test results

The compiler has been tested against the extra 160 test programs, the following table details the test number, description of how the compiler handles the test and the status of the test.

The tests that haven't been included have been executed as [ANSI compliant]  with no extra warnings.

| Test # | Description | Status  |
| ------ | ------ | ------ |
| 002 |fails to compile because the program is invalid. | Pass |
| 004 |fails to compile as there is a semi colon after the newline statement.| Pass |
| 005 |fails to compile as there is a semicolon after the program identifier at the beggining of the program, it should be a colon.| Pass |
| 006 |fails to compile as there is a comma at the end of the program rather than a full stop. |Pass |
| 007 |fails to compile as there is no full stop at the end of the program. |Pass |
| 011 |fails to compile as the word 'CHAR' is used in the declarations. |Pass |
| 012 |fails to compile as there is no semi colon after the CHARACTER declaration line. |Pass |
| 014 |fails to compile as there is no semi colon after the REAL declaration line. |Pass |Pass |
| 023 |should fail due to a float value being assigned to an integer. |**Fail** |
| 024 |should fail due to a float value being assigned to an integer. | **Fail** |
| 025 |should fail due to a character value being assigned to an integer. | **Fail** |
| 029 |should warn that an integer value is being assigned to a float vaiable.  | **Fail** |
| 030 |fails to compile as a string of characters are assigned to a single char variable. |Pass |
| 031 |fails to compile as an integer is assigned to a char. |Pass |
| 032 |fails to compile as an integer is assigned to a char. |Pass |
| 033 |fails to compile as an integer is assigned to a char. |Pass |
| 034 |fails as an undeclared variable is assigned to. |Pass |
| 035 |should fail due to the identiefer a being declared twice. |Pass |
| 036 |fails to compile as an identifier with the same value as the program name is declared. |Pass |
| 037 |fails as a value is assigned to an undeclared variable.|Pass |
| 038 |fails to compile as there is no semi colon after the assignment satement.  |Pass |
| 044 |should warn of data loss as a float is assigned to an int. | **Fail** |
| 046 |should warn as an integer value is assigned to a float. | **Fail** |
| 047 |should warn as a char value is assigned to a float. |**Fail** |
| 048 |should warn as a float value is assigned to a char  | **Fail** |
| 049 |should war as a float is assigned to a char.| **Fail** |
| 050 |fails to compile as an undeclared variables value is assigned to a. |Pass |
| 053 |should warn that a value larger than INT_MAX is assigned to an int variable.|**Fail** | 
| 054 |should warn that a value less than INT_MIN is assigned to an int variable.| **Fail** | 
| 063 |fails to compile as there is a syntax error in the write statement. |Pass |
| 070 |fails to compile as the compiler cannot handle double bracketed expressions . | **Fail** |
| 071 |fails to compile as the value of an un initalized varaiable is printed. |Pass |
| 080 |fails to complile as there is a syntax error in the write statement. |Pass |
| 099 |fails to compile as there is a syntax error in the expression of the assignement statement. |Pass |
| 110 |fails to compile as the value of an integer is assigned to a character.|Pass |
| 111 |fails to compile as the value of an integer is assigned to a character.|Pass |
| 112 |fails to compile as the value of an integer is assigned to a character.|Pass |
| 113 |fails to compile as the value of an integer is assigned to a character.|Pass |
| 114 |fails to compile as the value of an integer is assigned to a character.|Pass |
| 123 |fails to compile as there are a semi colons after the newline statements. |Pass |
| 156 |fails to compile as a float is used as a for loop counter. |Pass |
