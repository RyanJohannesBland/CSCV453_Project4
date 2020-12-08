#include <stdlib.h>
#include "syntax_tree.h"


statement_node *make_statement_node(int type, expr_node *expr_node, assignment_node *assignment_node, function_node *function_node){
    statement_node *new;
    new = (struct statement_node *) malloc((unsigned) sizeof(statement_node));
    new->type = type;
    new->expr_node = expr_node;
    new->assignment_node = assignment_node;
    new->function_node = function_node;
    new->next = NULL;
    return new;
}


assignment_node *make_assignment_node(idstruct *id, expr_node *expr_node){
    assignment_node *new;
    new = (struct assignment_node *) malloc((unsigned) sizeof(assignment_node));
    new->id = id;
    new->expr_node = expr_node;
    return new;
}


function_node *make_function_node(idstruct *id, parameter_node *params){
    function_node *new;
    new = (struct function_node *) malloc((unsigned) sizeof(function_node));
    new->id = id;
    new->params = params;
    return new;
}


parameter_node *make_parameter_node(idstruct *id){
    parameter_node *new;
    new = (struct parameter_node *) malloc((unsigned) sizeof(parameter_node));
    new->id = id;
    new->next = NULL;
    return new;
}


statement_node *append_statement(statement_node *root, statement_node *new){
    statement_node *pointer = root;
    if(pointer == NULL){
        return new;
    }
    else{
        while(pointer->next){
            pointer = pointer->next;
        }
        pointer->next = new;
        return root;
    }
}


parameter_node *append_parameter(parameter_node *root, parameter_node *new){
    parameter_node *pointer = root;
    if(pointer == NULL){
        return new;
    }
    else{
        while(pointer->next){
            pointer = pointer->next;
        }
        pointer->next = new;
        return root;
    }
}
