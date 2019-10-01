/*****************************************************************************/
/**  Ejemplo de BISON-I: S E M - 2          2019-2020 <jbenedi@dsic.upv.es> **/
/**  V. 19                                                                  **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token PARA_ PARC_ MAS_ MENOS_ POR_ DIV_
%token CTE_ 

%%

expMat : exp
       ;
exp    : exp MAS_   term
       | exp MENOS_ term
       | term         
       ;
term   : term POR_ fac
       | term DIV_ fac   
       | fac             
       ;
fac    : PARA_ exp PARC_ 
       | CTE_            
       ;
%%

int verbosidad = FALSE; 

/*****************************************************************************/
void yyerror(const char *msg){
/*  Tratamiento de errores.                                                  */
  fprintf(stderr, "\nError en la linea %d: %s\n", yylineno, msg);
}

/*****************************************************************************/
int main(int argc, char **argv) {
  int i, n=1 ;

  for (i=1; i<argc; ++i)
      if (strcmp(argv[i], "-v")==0) { verbosidad = TRUE; n++; }
  if (argc == n+1)
      if ((yyin = fopen (argv[n], "r")) == NULL)
        fprintf (stderr, "El fichero '%s' no es valido\n", argv[n]) ;     
      else yylex ();
  else fprintf (stderr, "Uso: cmc [-v] fichero\n");

  return (0);
} 

/*****************************************************************************/
