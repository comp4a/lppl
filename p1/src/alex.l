/*Subseccion preambulo*/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "asin.h"

#define  retornar(x) {if (verbosidad) ECHO; return(x);}
%}
/*Subseccion de definiciones*/
/*-----------------------------------------------------------------------------
  Estas opciones evitan "warnings" innecesarios y permiten obtener el
  numero de linea actual en la variable global "yylineno".
-----------------------------------------------------------------------------*/
%option noinput       
%option nounput       
%option yylineno  

letra		     			[a-zA-Z_]
digito          			[0-9]

id          				{letra}({letra}|{digito})*
cte          				({digito}+"."{digito}*)|({digito}*"."{digito}+)|({digito}+)

comentario					"//".*\n
delimitador     			[ \t]+
nueva_linea					\n

%%
{nueva_linea} 	{ if (verbosidad) {ECHO; printf("%3d.- ", yylineno);} } 
{delimitador}   { if (verbosidad) ECHO; }
{comentario}	{ if (verbosidad) {ECHO; printf("%3d.- ", yylineno);} }

"+"		{ retornar (MAS_);   }
"-"     { retornar (MENOS_); }
"*"     { retornar (POR_);   }
"/"     { retornar (DIV_);   }
"%"		{ retornar (MOD_);   }

"+="	{ retornar (MASASIG_);   }
"-="	{ retornar (MENOSASIG_);   }
"*="	{ retornar (PORASIG_);   }
"/="	{ retornar (DIVASIG_);   }
"++"	{ retornar (INC_);   }
"--"	{ retornar (DEC_);   }
"="		{ retornar (ASIG_);   }

"{"		{ retornar (ALLA_);   }
"}"		{ retornar (CLLA_);   }
"("     { retornar (APAR_);  }
")"     { retornar (CPAR_);   }
"["		{ retornar (ACOR_);   }
"]"		{ retornar (CCOR_);   }

"=="	{ retornar (IGU_);   }
"!="	{ retornar (DIST_);   }
">"		{ retornar (MAY_);   }
"<"		{ retornar (MEN_);   }
">="	{ retornar (MAYIGU_);   }
"<="	{ retornar (MENIGU_);   }

"&&"	{ retornar (AND_);   }
"||"	{ retornar (OR_);   }
"!"		{ retornar (NOT_);   }

"struct" { retornar (STRUCT_);   }
"int"	{ retornar (INT_);   }
"bool"	{ retornar (BOOL_);   }
"read"	{ retornar (READ_);   }
"print"	{ retornar (PRINT_);   }
"if"	{ retornar (IF_);   }
"else"	{ retornar (ELSE_);   }
"while"	{ retornar (WHILE_);   }
"true"	{ retornar (TRUE_);   }
"false"	{ retornar (FALSE_);   }

";"		{ retornar (DELI_);   }
"."		{ retornar (PUNTO_);   }

{id}	{ retornar (ID_);   }
{cte}	{ retornar (CTE_);   }
.	    { yyerror("Caracter desconocido"); }
%%
/*****************************************************************************/