%{
#include <math.h>
#include <stdio.h>
#include "y.tab.h"
int comment;
int skip;
%}


WHITESPACE  [ \t]
DIGIT       [0-9]
LETTER      [A-Za-z]
ALPHANUM    [A-Za-z0-9_]
INTCON      {DIGIT}+
PRINTABLE   [\x20-\x7E]
STRINGCON   \"[^"]*\"
CHARCON     \'({PRINTABLE}|\\n|\\0)?\'
ID          {LETTER}{ALPHANUM}*


%option noyywrap
%%

"/*" {
    skip = 1;
}

"*\/" {
    skip = 0;
}

"extern" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(EXTERN);
    }
}

"void" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(VOID);
    }
}

"char" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(CHAR);
    }
}

"int" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(INT);
    }
}

"if" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(IF);
    }
}

"else" {
    yylval.intVal = yytext[0];
    if(comment){printf("%s", yytext);}
    return(ELSE);
}

"while" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(WHILE);
    }
}

"for" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(FOR);
    }
}

"return" {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(RETURN);
    }
}

{INTCON} {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(INTCON);
    }
}

{LETTER}{ALPHANUM}* {
    if(!skip){
        yylval.charVal = strdup(yytext);
        if(comment){printf("%s", yytext);}
        return(ID);
    }
}

{CHARCON} {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(CHARCON);
    }
}

{STRINGCON} {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(STRINGCON);
    }
}

{WHITESPACE}+ ;

. {
    if(!skip){
        yylval.intVal = yytext[0];
        if(comment){printf("%s", yytext);}
        return(yylval.intVal);
    }
}

"\n" {
    if(comment){printf("%s", yytext);}
}


%%
// Code for running tests in lexer.
// int main(int argc, char **argv) {
//     printf("Began running\n");
//     int result;
//     while ((result=yylex())!=0) {
//         if(result == 8){
//             printf("8\n");
//         }
//         else{
//             printf("%d\t%s\n", result, yytext);
//         }
//     }
//     printf("Line count = %d\n", line_count);
//     return 0;
// }



