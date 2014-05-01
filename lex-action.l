%{

#include "ff.h"
#include "parse.h"
  
/* default yywrap function - always treat EOF as an EOF  */
int yywrap(void){ return 1; }

%}

%%

"("  { return(OPEN_PAREN); }

")"  {  return(CLOSE_PAREN); }

[a-zA-Z][a-zA-Z0-9\-_]* {
  strupcase( yytext );  
  yylval.string = yytext;

  return(NAME);
}

\n    {  lineno++; } 

. {}
%%
