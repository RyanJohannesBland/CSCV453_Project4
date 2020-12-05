%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable_provided.h"

int yydebug = 1;
extern int skip;
int yylex();
int yyerror(char *s);
idstruct *insert(char *word);
%}

%union {
    int intVal;
    char *charVal;
    struct idstruct *idVal;
}

%type <idVal> Functionhead Identifier

%token <charVal> ID
%token CHARCON STRINGCON
%token IF ELSE RETURN WHILE FOR
%token VOID EXTERN CHAR INT INTCON STRING

%left  '&' '|'
%left  '<' '>'
%left  '=' '+'
%left  '*' '/'
%left '(' ')' '[' ']' '{' '}' ';'
%right '!' '-'

%%

Program: /* empty */
    | Program Program_piece

Program_piece: function_declaration ';'
    | Function
    | Variable_declaration

function_declaration: EXTERN Type Functionhead_list
    | Type Functionhead_list        
    | EXTERN VOID Functionhead_list 
    | VOID Functionhead_list        
    | EXTERN Functionhead_list      


Functionhead_list: Functionhead | Functionhead_list ',' Functionhead

Functionhead: ID '(' Param_types ')' {$$ = insert($1);}

Function :
    Functionhead '{' Functionbody '}'
    | VOID Functionhead '{' Functionbody '}'    {printf("LABEL %s:\n", $2->lexeme);}
    | Type Functionhead '{' Functionbody '}'

Functionbody : Varlist Stmtlist

Varlist: /* empty */
    | Varlist Variable_declaration

Variable_declaration: Type IDlist ';' 

Stmtlist: /* empty */
    | Stmtlist Statement

Param_types: Param_type             
    | Param_types ',' Param_type    

Param_type: Type Identifier     
    | Type Identifier '{' '}'   
    | VOID

Type: CHAR
    | INT  

Statement:
    ';'
    | IF Expression Statement
    | IF Expression Statement ELSE Statement
    | WHILE Expression Statement
    | Forloop
    | RETURN Expression ';'
    | RETURN ';'            
    | Assignment ';'
    | Functioncall ';'
    | '{' MultipleStatements '}'
    | '{' '}'

MultipleStatements: Statement | MultipleStatements Statement

Assignment: Identifier '=' Expression 

Expression:
    '-' Expression                  
    | '!' Expression                
    | Expression '+' Expression     
    | Expression '-' Expression     
    | Expression '*' Expression     
    | Expression '/' Expression     
    | Expression '=' '=' Expression
    | Expression '!' '=' Expression 
    | Expression '<' '=' Expression 
    | Expression '<' Expression     
    | Expression '>' '=' Expression 
    | Expression '>' Expression     
    | Expression '&' '&' Expression 
    | Expression '|' '|' Expression 
    | Functioncall                 
    | Identifier                    
    | '(' Expression ')'            
    | INTCON                        
    | CHARCON                       
    | STRINGCON                     

Functioncall:
    ID '(' ')'                  
    | ID '(' Parameterlist ')'  

IDlist: Identifier          
    | IDlist ',' Identifier 

Identifier: ID              {$$ = insert($1);}
    | ID '[' Expression ']' {$$ = insert($1);}
    | ID '[' ']'            {$$ = insert($1);}

Parameterlist:  Expression | Parameterlist ',' Expression

Forloop:
    FOR '(' Assignment ';' Expression ';' Assignment ')' Statement
    | FOR '(' Assignment ';' Expression ';' ')' Statement
    | FOR '(' Assignment ';' ';' Assignment ')' Statement
    | FOR '(' ';' Expression ';' Assignment ')' Statement
    | FOR '(' Assignment ';' ';' ')' Statement
    | FOR '(' ';' Expression ';' ')' Statement
    | FOR '(' ';' ';' Assignment ')' Statement
    | FOR '(' ';' ';' ')' Statement

%%


idstruct *insert(char* word){
    idstruct *node = lookup(word, 1);
    if(node == NULL){
        node = mk_id_node(word);
        node = install(node, 1);
    }
    return node;
}


int main(){return yyparse();}
int yywrap(){return 1;}
int yyerror(char *s){return 0;}
