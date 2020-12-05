/* CSCV 453
 * Symbol Table Routines
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symtable_provided.h"
#include "y.tab.h"     /* to get the token definitions */


/* install
 * This function places identifiers in the symbol table.
 * It places the structure in the correct linked list according to
 * the identifier's hash value.  It then returns a pointer to the
 * identifier's structure.
 */
idstruct *install(idstruct *new, int table){
    int index;
    idstruct *idptr, **back;
    index = hashword(new->lexeme);
    /* set idptr and back for the beginning of the correct (global or local)
     * symbol table
     */
    if (table == GLOTAB) {
        idptr = glotab[index];
        back = &glotab[index];
    }
    else {
        idptr = localtab[index];
        back = &localtab[index];
    }
    /* walk down the linked list until the end */
    while (idptr != NULL) {
        back = &idptr->next;
        idptr = idptr->next;
    }
    *back = new;
    if (LI_DEBUG){
        printf("Install new lexeme %s type is %d", new->lexeme, new->type);
    }
    return new;
} 


/* install */
/* lookup
 * This function checks for the presence or absence of a word in the
 * symbol table. If the word is present, its token value is returned.
 * If the word is not present, NULL is returned.
 */
idstruct *lookup(char *word, int table){

    int index;
    struct idstruct *idptr;
    index = hashword(word);

    if (table == GLOTAB)
        idptr = glotab[index];
    else
        idptr = localtab[index];
    while ( idptr != NULL && (strcmp(word, idptr->lexeme) != 0) ){
        idptr = idptr->next;
    }
    if (LI_DEBUG && idptr!=NULL){
        printf("Lookup word %s, and type is %d", word, idptr->type);
    }
    return idptr;
}


idstruct * mk_id_node(char *word){
    idstruct *new;
    /* create new node and put it at the end of the linked list */
    new = (struct idstruct *) malloc( (unsigned) sizeof(idstruct) );
    new->lexeme = newstr(word);
    new->token = ID;
    new->type = 0;
    new->is_array = 0;    /* assume not an array */
    new->function = 0;    /* assume not a function */
    new->is_extern = 0;   /* assume not an EXTERN */
    new->upper = 0;       /* assume 0 for non-array type */
    new->argnum = 0;      /* no function parameters as yet */
    new->arg_list = NULL; /* function parameter list is empty */
    new->next = NULL;
    new->right_arg = NULL;
    new->is_defined_function = 0; //0 undefined
    return new;
}


void print_id_node(idstruct *new, FILE *stream){
    idstruct *p;
    fprintf(stream, "new->lexeme = %s\n", new->lexeme);
    fprintf(stream, "new->token = %d\n", ID);
    fprintf(stream, "new->type = %d\n", new->type);
    fprintf(stream, "new->is_array = %d\n", new->is_array);   /* assume not an array */
    fprintf(stream, "new->function = %d\n", new->function);    /* assume not a function */
    fprintf(stream, "new->is_extern = %d\n", new->is_extern);   /* assume not an EXTERN */
    fprintf(stream, "new->upper = %d\n", new->upper);       /* assume 0 for non-array type */
    fprintf(stream, "new->argnum = %d\n", new->argnum);      /* no function parameters as yet */
    fprintf(stream, "is_defined_function = %d\n", new->is_defined_function);
    fprintf(stream, "arguments are as follows:\n ");
    p = new->arg_list;
    while (p){
    print_id_node(p, stream);
    p = p->right_arg;
    }
}


 /* print_id_node */
/* hashword
 * Using the routine on p. 436 of the Dragon Compiler Book, a word
 * is hashed and the hash value is returned.
 */
static int hashword(char *word){
    char *ptr;
    unsigned h = 0, g;
    for (ptr = word; *ptr != '\0'; ptr++) {
        h = (h << 4) + (*ptr);
        if ((g = h) & 0xf0000000) {
            h = h ^ (g >> 24);
            h = h ^ g;
        }
    }
    return h % HASHSIZE;
}


/* newstr
 * Returns a copy of the string argument; needs to allocate
 * storage for this copy.
 */
static char *newstr(char *str){
    char *ptr;
    if ( (ptr = malloc( (unsigned) strlen(str) + 1)) == NULL ) {
        fprintf(stderr, "cannot allocate %d bytes in newstr\n",
                (int)strlen(str) + 1);
        exit(2);
    }
    return strcpy(ptr, str);
}


/* wipe_local_table
 * Zeroes out the local table (will free if I have time)
 */
int freeentry(idstruct *entry){
    if (entry == NULL) return 1;
    idstruct *p = NULL;
    if (entry->lexeme !=NULL) free(entry->lexeme);
    p = entry->next;
    if (p != NULL){
        freeentry(p);
    }
    free(entry);
    return 0;
}


void wipe_local_table() {
   int i;
   for (i=0;i<HASHSIZE;i++) {
      if (localtab[i]!=NULL){
          freeentry(localtab[i]);
      }
      localtab[i] = NULL;
   }
}

