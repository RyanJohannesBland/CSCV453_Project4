
/*The below code is given for reference only.
 *Some functions/data structures are used and not defined */

idstruct *
generate_temp_scope(int scope, int type){
    char *newstr;
    static int gentemp;
    idstruct *new_id_struct;
    newstr = malloc(10);
    strcpy(newstr, "__3A");
    strcat(newstr, itoa(gentemp));
    gentemp ++;
    new_id_struct = mk_id_node(newstr);
    new_id_struct->type = type;
    new_id_struct = install(new_id_struct, scope);
    return new_id_struct;
}
/* generate_label
 * generates a label for bool expressions and control structures
 */

char *
generate_label(void){
    char *newptr;
    static int labeltemp;
    newptr = malloc(10);
    strcpy(newptr, "__3L");
    strcat(newptr, itoa(labeltemp));
    
    labeltemp ++;
    return newptr;
}

void generate_ir_controlexprcode(expr_node *node, char *truelabel, char *falselabel){
    expr_node *e1, *e2;
    char *l1, *l2;
    switch(node->operator){
        case ANDCOM:   //logical and
            e1 = node->left;
            e2 = node->right;
            l1 = generate_label();
            generate_ir_controlexprcode(e1, l1, falselabel);
            generate_ir_controlexprcode(e2,truelabel, falselabel);
            node->code = appendcode(e1->code, newlabelcode(l1));
            node->code = appendcode(node->code, e2->code);
            break;
            
            break;
            
        case ORCOMP:   //logical or
           //code
            break;
            
        case ABANG:    //logical not
            //code
            break;
        default: //should have some code generated when generate_ir_exprnode
            //code
    }
    
}

void generate_ir_stmtcode(statement_node *node){
    char *l1, *l2, *l3;
    idstruct *temp = NULL;
    address3code *code = NULL;
    statement_node *s1, *s2;
    expr_node *control, *e1, *e2;
    if_node *ifnode;
    while_node *whilenode;
    for_node *fornode;
    assign_node *assignnode;
    
    return_node *returnnode;
    
    if (node == NULL || node->code != NULL) return ;
    
    switch(node->operator){
        case IF:
            ifnode = (if_node *)node->this_statement;
            
            control = ifnode->control;
            
            l1 = generate_label();
            l2 = generate_label();
            generate_ir_controlexprcode(control, l1, l2);
            
            s1 = ifnode->then_branch;
            s2 = ifnode->else_branch;
            
            node->code = appendcode(control->code,newlabelcode(l1));
            node->code = appendcode(node->code, s1->code);
            if (s2 != NULL){
                l1 = generate_label();
                node->code = appendcode(node->code, newgotocode(l1));
            }
            node->code = appendcode(node->code, newlabelcode(l2));
            if (s2 != NULL){
                node->code = appendcode(node->code, s2->code);
                node->code = appendcode(node->code, newlabelcode(l1));
            }
            break;
            
            
        case WHILE:
            whilenode = (while_node *)node->this_statement;
            control = whilenode->control;
            s1 = whilenode->body;
            l1 = generate_label(); //control expr begins
            l2 = generate_label(); //body begins
            l3 = generate_label(); //out of the loop
            node->code = newlabelcode(l1);
            generate_ir_controlexprcode(control, l2, l3);
            node->code = appendcode(node->code, control->code);
            node->code = appendcode(node->code, newlabelcode(l2));
            generate_ir_stmtcode(s1);
            node->code = appendcode(node->code, s1->code);
            node->code = appendcode(node->code, newgotocode(l1));
            node->code = appendcode(node->code,newlabelcode(l3));
            break;
        //more case handling
            
    } 
}

