%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable_provided.h"
#include "syntax_tree.h"

int yydebug = 1;
extern int skip;
int yylex();
int yyerror(char *s);
idstruct *insert(char *word);
void print_function(function_node *function, statement_node *statements);
%}

%union {
    int intVal;
    char *charVal;
    struct idstruct *idVal;
    struct statement_node *statementNode;
    struct expr_node *expressionNode;
    struct assignment_node *assignmentNode;
    struct function_node *functionNode;
    struct parameter_node *parameterNode;
}

%type <idVal> Identifier
%type <statementNode> Stmtlist Statement Functionbody
%type <expressionNode> Expression
%type <assignmentNode> Assignment
%type <functionNode> Functioncall Functionhead
%type <parameterNode> Param_types Param_type

%token <charVal> ID
%token CHARCON STRINGCON
%token IF ELSE RETURN WHILE FOR
%token VOID EXTERN CHAR INT INTCON STRING

%left  AND OR
%left  LT GT GTEQ LTEQ
%left  PLUS EQ NOTEQ
%left  MUL DIV
%left '(' ')' '[' ']' '{' '}' ';'
%right NOT MINUS

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

Functionhead: ID '(' Param_types ')' {idstruct *id = insert($1);$$ = make_function_node(id, $3);}

Function :
    Functionhead '{' Functionbody '}'
    | VOID Functionhead '{' Functionbody '}'    {print_function($2, $4);}
    | Type Functionhead '{' Functionbody '}'

Functionbody : Varlist Stmtlist {$$ = $2;}

Varlist: /* empty */
    | Varlist Variable_declaration

Variable_declaration: Type IDlist ';' 

Stmtlist: /* empty */   {$$ = NULL;}
    | Stmtlist Statement    {$$ = append_statement($1, $2);}

Param_types: Param_type             {$$ = $1;}     
    | Param_types ',' Param_type    {$$ = append_parameter($1, $3);}

Param_type: Type Identifier     {$$ = make_parameter_node($2);}
    | Type Identifier '{' '}'   {$$ = make_parameter_node($2);}
    | VOID                      {$$ = NULL;}

Type: CHAR
    | INT  

Statement:
    ';'                                         {$$ = NULL;}
    | IF Expression Statement                   {$$ = NULL;}
    | IF Expression Statement ELSE Statement    {$$ = NULL;}
    | WHILE Expression Statement                {$$ = NULL;}
    | Forloop                                   {$$ = NULL;}
    | RETURN Expression ';'                     {$$ = make_statement_node(1, $2, NULL, NULL);}
    | RETURN ';'                                {$$ = make_statement_node(1, NULL, NULL, NULL);}
    | Assignment ';'                            {$$ = make_statement_node(2, NULL, $1, NULL);}
    | Functioncall ';'                          {$$ = make_statement_node(3, NULL, NULL, $1);}
    | '{' Stmtlist '}'                          {$$ = $2;}

Assignment: Identifier '=' Expression           {$$ = make_assignment_node($1, $3);}

Expression:
    NOT Expression                      {$$ = NULL;}
    | MINUS Expression                  {$$ = NULL;}
    | Expression PLUS Expression        {$$ = NULL;}
    | Expression MINUS Expression       {$$ = NULL;}
    | Expression MUL Expression         {$$ = NULL;}
    | Expression DIV Expression         {$$ = NULL;}
    | Expression EQ Expression          {$$ = NULL;}
    | Expression NOTEQ  Expression      {$$ = NULL;}
    | Expression LTEQ Expression        {$$ = NULL;}
    | Expression LT Expression          {$$ = NULL;}
    | Expression GTEQ Expression        {$$ = NULL;}
    | Expression GT Expression          {$$ = NULL;}
    | Expression AND Expression         {$$ = NULL;}
    | Expression OR Expression          {$$ = NULL;}
    | Functioncall                      {$$ = NULL;}
    | Identifier                        {$$ = NULL;}
    | '(' Expression ')'                {$$ = NULL;}
    | INTCON                            {$$ = NULL;}
    | CHARCON                           {$$ = NULL;}
    | STRINGCON                         {$$ = NULL;}

Functioncall:
    ID '(' ')'                          {idstruct *id = insert($1);$$ = make_function_node(id, NULL);}
    | ID '(' Parameterlist ')'          {idstruct *id = insert($1);$$ = make_function_node(id, NULL);}

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


void print_function(function_node *function, statement_node *statements){
    printf("Successfully built a function tree\n");
}




int main(){return yyparse();}
int yywrap(){return 1;}
int yyerror(char *s){return 0;}
