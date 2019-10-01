/*****************************************************************************/
/**  Ejemplo de FLEX: S E M - 1             2019-2020 <jbenedi@dsic.upv.es> **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"

#define  retornar(x) {if (verbosidad) ECHO;}
%}
/*-----------------------------------------------------------------------------
  Estas opciones evitan "warnings" innecesarios y permiten obtener el
  numero de linea actual en la variable global "yylineno".
-----------------------------------------------------------------------------*/
%option noinput       
%option nounput       
%option yylineno  

//TODO: definir cte
//TODO: preguntar que parte de la gramatica tenemos que definir
//TODO: preguntar que han de devolver las funciones

letraMinus      			[a-z]
letraMayus      			[A-Z] 
digito          			[0-9]
delimitador     			[ \t\n]+
entero          			{digito}+
boolean         			"true" | "false"
simbolo         			{letraMinus} 
							| {letraMayus} 
							| "_" 
							| {digito}

id         					({letraMinus}| "_"){simbolo}*

tipoSimple      			{entero} 
							| {boolean}

declaracion     			{tipoSimple} {id} ";"
			                | {tipoSimple} {id} "=" {constante} ";"
			                | {tipoSimple} {id} "[" {cte} "]" ";"
			                | "struct" "{" {listaCampos} "}" {id} ";"

instruccion     			"{" "}"
			                | "{" {listaInstrucciones} "}"
			                | {instruccionEntradaSalida}
			                | {instruccionSeleccion}
			                | {instruccionIteracion} 
			                | {instruccionExpresion}

listaInstrucciones           {instruccion}+

instruccionEntradaSalida     "read" "(" {id} ")" ";" 
                             | "print" "(" {expresion} ")" ";"

instruccionSeleccion         "if" "(" {expresion} ")" {instruccion} "else" {instruccion}

instruccionIteracion         "while" "(" {expresion} ")" {instruccion}

instruccionExpresion        {expresion} ";" 
							| ";"

expresion                   {expresionLogica} 
                            | {id} {operadorAsignacion} {expresion} 
                            | {id} "[" {expresion} "]" {operadorAsignacion} {expresion}
                            | {id} . {id} {operadorAsignacion} {expresion}

expresionLogica 			{expresionIgualdad}
                			| {expresionLogica} {operadorLogico} {expresionIgualdad}        

expresionIgualdad 			{expresionRelacional}
                			| {expresionIgualdad} {operadorIgualdad} {expresionRelacional}

expresionRelacional 		{expresionAditiva}
    						| {expresionRelacional} {operadorRelacional} {expresionAditiva}

 expresionAditiva 			{expresionMultiplicativa}
    						| {expresionAditiva} {operadorAditivo} {expresionMultiplicativa}

expresionMultiplicativa 	{expresionUnaria}
    						| {expresionMultiplicativa} {operadorMultiplicativo} {expresionUnaria}

expresionUnaria 			{expresionSufija}
						    | {operadorUnario} {expresionUnaria}
						    | {operadorIncremento} {id}

expresionSufija 			"(" {expresion} ")"
						    | {id} {operadorIncremento}
						    | {id} "[" {expresion} "]"
						    | {id}
						    | {id} . {id}
						    | {constante}

constante 					{cte}
    						| {boolean}    

sentencia       			{declaracion} 
							| {instruccion}

secuenciaSentencias  {sentencia}+
programa       "{" {secuenciaSentencias} "}"
listaCampos     {tipoSimple} {id} ";" 
				| {listaCampos} {tipoSimple} {id} ";"

%%
{delimitador}  { if (verbosidad) ECHO; }
"+"		{ retornar (MAS_);   }
"-"     { retornar (MENOS_); }
"*"     { retornar (POR_);   }
"/"     { retornar (DIV_);   }
"%"		{ retornar (DIV_);   }
"("     { retornar (OPAR_);  }
")"     { retornar (DIV_);   }
"="		{ retornar (DIV_);   }
"+="	{ retornar (DIV_);   }
"-="	{ retornar (DIV_);   }
"*="	{ retornar (DIV_);   }
"/="	{ retornar (DIV_);   }
"&&"	{ retornar (DIV_);   }
"||"	{ retornar (DIV_);   }
"=="	{ retornar (DIV_);   }
"!="	{ retornar (DIV_);   }
">"		{ retornar (DIV_);   }
"<"		{ retornar (DIV_);   }
">="	{ retornar (DIV_);   }
"<="	{ retornar (DIV_);   }
"!"		{ retornar (DIV_);   }
"++"	{ retornar (DIV_);   }
"--"	{ retornar (DIV_);   }
{entero}       { retornar (CTE_);   }

.	       { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/
int verbosidad = FALSE;                  /* Flag si se desea una traza       */

/*****************************************************************************/
void yyerror(const char *msg)
/*  Tratamiento de errores.                                                  */
{ fprintf(stderr, "\nError en la linea %d: %s\n", yylineno, msg); }

/*****************************************************************************/
int main(int argc, char **argv) 
/* Gestiona la linea de comandos e invoca al analizador sintactico-semantico.*/
{ int i, n=1 ;

  for (i=1; i<argc; ++i)
    if (strcmp(argv[i], "-v")==0) { verbosidad = TRUE; n++; }
  if (argc == n+1)
    if ((yyin = fopen (argv[n], "r")) == NULL) {
      fprintf (stderr, "El fichero '%s' no es valido\n", argv[n]) ;     
      fprintf (stderr, "Uso: cmc [-v] fichero\n");
    } 
    else yylex ();
  else fprintf (stderr, "Uso: cmc [-v] fichero\n");

  return (0);
} 
/*****************************************************************************/

