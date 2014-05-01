%{

#include <stdio.h>
#include <string.h> 
#include "ff.h"
#include "memory.h"
#include "parse.h"

extern FactList* g_factList;

%}

%union{
    FactList* pFactList;
    TokenList* pTokenList;
    char* string;
}

%start g_action

%token NAME
%token OPEN_PAREN CLOSE_PAREN

%type<string> NAME
%type<pFactList> action_list
%type<pFactList> g_action
%type<pTokenList> action
%type<pTokenList> name_star
%type<pTokenList> name

%%

g_action: action_list
{
    g_factList = $$ = $1;
};

action_list: action
{
    $$ = new_FactList();
    $$->item = $1;
}|
action action_list
{
    $$ = new_FactList();
    $$->item = $1;
    $$->next = $2;
};

action: OPEN_PAREN name_star CLOSE_PAREN
{
    $$ = $2;
};

name_star: name 
{
    $$ = $1;
}|
name name_star
{
    $$ = $1;
    $$->next = $2;
};

name: NAME
{
    $$ = new_TokenList();
    int n = strlen(yylval.string);
    $$->item = new_Token(n+1);
    strncpy($$->item,yylval.string,n);
}

%%

#include "lex.action.c"

int yyerror( char *msg )

{

  fflush(stdout);
  fprintf(stderr, "syntax error:'%s'\n",msg);

  exit( 1 );

}

void load_action_file(char* filename){
  FILE *fp;/* pointer to input files */
  char tmp[MAX_LENGTH] = "";

  /* open fact file 
   */
  if( ( fp = fopen( filename, "r" ) ) == NULL ) {
    sprintf(tmp, "\nff: can't find actions file: %s\n\n", filename );
    perror(tmp);
    exit ( 1 );
  }

  /*gact_filename = filename;*/
  lineno = 1; 
  yyin = fp;

  yyparse();

  fclose( fp );/* and close file again */
}

