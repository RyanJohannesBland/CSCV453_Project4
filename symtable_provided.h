/* symbol table definitions */

#include <strings.h>
#include <stdio.h>

#ifndef SYMTABLE_H

#define SYMTABLE_H

#define HASHSIZE  233

#define GLOTAB    1

#define LOCALTAB  2

#define LI_DEBUG 0

typedef struct idstruct {
    char *lexeme;
    int   token;
    int   type;       /* INT, CHAR, FUNC, UNDECLARED */
    int   is_array;   /* 1 = an array */
    int   function;
    int   is_extern;  /* 1 = declared as EXTERN */
    int   upper;      /* array upper bound, 0 = not an array */
    int   argnum;     /* # of arguments for function, 0 = not a function */
    int   is_prototyped_function;
    int   is_defined_function;
    struct idstruct *arg_list;  /* argument list for functions */
    struct idstruct *next;      /* for linked list in the hash table */
    struct idstruct *right_arg; /* for linked arg right next to the current one */

} idstruct;

idstruct *glotab[HASHSIZE],

         *localtab[HASHSIZE];

/* void initsymtab(); */

idstruct *install(idstruct *new, int table);

idstruct *lookup(char *word, int table);

idstruct *mk_id_node(char *word);

void wipe_local_table();

static int hashword(char *word);

static char *newstr(char *str);

void print_id_node(idstruct *node, FILE *stream);

#endif
