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

//TODO: preguntar que han de devolver las funciones

// TODO: preguntar por definicion constante
// TODO: a | as equiv as+
// TODO: preguntar punto en expresion

letraMinus      			[a-z]
letraMayus      			[A-Z] 
digito          			[0-9]
delimitador     			[ \t\n]+
entero          			{digito}+

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
"--"	{ retornar (DIV_);   }
"--"	{ retornar (DIV_);   }
"--"	{ retornar (DIV_);   }
"--"	{ retornar (DIV_);   }
{entero}       { retornar (CTE_);   }

.	       { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/