#include "symtable_provided.h"


typedef struct expr_node {
    struct expr_node *right;
    struct expr_node *left;
} expr_node;


typedef struct assignment_node {
    struct idstruct *id;
    struct expr_node *expr_node;
} assignment_node;


typedef struct parameter_node {
    struct idstruct *id;
    struct parameter_node *next;
} parameter_node;


typedef struct function_node {
    struct idstruct *id;
    struct parameter_node *params;
} function_node;


typedef struct statement_node {
    // 1 is return, 2 is assignment, 3 is functioncall, 4 is expression, 5 is forloop, 6 if-then.
    int type;
    struct expr_node *expr_node;
    struct assignment_node *assignment_node;
    struct function_node *function_node;
    struct statement_node *next;
    struct statement_node *if_statement;
    struct statement_node *else_statement;
} statement_node;


parameter_node *make_parameter_node(idstruct *id);
statement_node *make_statement_node(int type, expr_node *exp_node, assignment_node *assignment_node, function_node *function_node, statement_node *if_statement, statement_node *else_statement);
assignment_node *make_assignment_node(idstruct *exp_node, expr_node *expr_node);
function_node *make_function_node(idstruct *id, parameter_node *params);
statement_node *append_statement(statement_node *root, statement_node *new);
parameter_node *append_parameter(parameter_node *root, parameter_node *new);