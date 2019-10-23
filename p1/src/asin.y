%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token MAS_ MENOS_ POR_ DIV_ MOD_
MASASIG_ MENOSASIG_ PORASIG_ DIVASIG_ INC_ DEC_ ASIG_
ALLA_ CLLA_ APAR_ CPAR_ ACOR_ CCOR_
IGU_ DIST_ MAY_ MEN_ MAYIGU_ MENIGU_
AND_ OR_ NOT_
STRUCT_ INT_ BOOL_
READ_ PRINT_
IF_ ELSE_ WHILE_
TRUE_ FALSE_
DELI_ PUNTO_

%token ID_ CTE_ 

%%
programa
  : ALLA_ secuenciaSentencias CLLA_
  ;

secuenciaSentencias
  : sentencia
  | secuenciaSentencias sentencia
  ;

sentencia
  : declaracion 
  | instruccion
  ;

declaracion
  : tipoSimple ID_ DELI_
  | tipoSimple ID_ ASIG_ constante DELI_ 
  | tipoSimple ID_ ACOR_ CTE_ CCOR_ DELI_
  | STRUCT_ ALLA_ listaCampos CLLA_ ID_ DELI_
  ;

/*TODO*/
tipoSimple
  : INT_
  | BOOL_
  ;

listaCampos
  : tipoSimple ID_ DELI_
  | listaCampos tipoSimple ID_ DELI_
  ;

instruccion
  : ALLA_ CLLA_ 
  | ALLA_ listaInstrucciones CLLA_
  | instruccionEntradaSalida
  | instruccionSeleccion
  | instruccionIteracion
  | instruccionExpresion
  ;

listaInstrucciones
  : instruccion
  | listaInstrucciones instruccion
  ;

instruccionEntradaSalida
  : READ_ APAR_ ID_ CPAR_ DELI_
  | PRINT_ APAR_ expresion CPAR_ DELI_
  ;

instruccionSeleccion
  : IF_ APAR_ expresion CPAR_ instruccion ELSE_ instruccion
  ;

instruccionIteracion
  : WHILE_ APAR_ expresion CPAR_ instruccion
  ;

instruccionExpresion
  : expresion DELI_
  | DELI_
  ;

expresion
  : expresionLogica
  | ID_ operadorAsignacion expresion
  | ID_ ACOR_ expresion CCOR_ operadorAsignacion expresion
  | ID_ PUNTO_ ID_ operadorAsignacion expresion
  ;

expresionLogica
  : expresionIgualdad
  | expresionLogica operadorLogico expresionIgualdad
  ;

expresionIgualdad
  : expresionRelacional
  | expresionIgualdad operadorIgualdad expresionRelacional
  ;

expresionRelacional
  : expresionAditiva
  | expresionRelacional operadorRelacional expresionAditiva
  ;

expresionAditiva
  : expresionMultiplicativa
  | expresionAditiva operadorAditivo expresionMultiplicativa
  ;

expresionMultiplicativa
  : expresionUnaria
  | expresionMultiplicativa operadorMultiplicativo expresionUnaria
  ;

expresionUnaria
  : expresionSufija
  | operadorUnario expresionUnaria
  | operadorIncremento ID_
  ;

expresionSufija
  : APAR_ expresion CPAR_
  | ID_ operadorIncremento
  | ID_ ACOR_ expresion CCOR_
  | ID_
  | ID_ PUNTO_ ID_
  | constante
  ;

constante
  : CTE_
  | TRUE_
  | FALSE_
  ;

operadorAsignacion
  : ASIG_
  | MASASIG_
  | MENOSASIG_
  | PORASIG_
  | DIVASIG_
  ;

operadorLogico
  : AND_
  | OR_
  ;

operadorIgualdad
  : IGU_
  | DIST_
  ;

operadorRelacional
  : MAY_
  | MEN_
  | MAYIGU_
  | MENIGU_
  ;

operadorAditivo
  : MAS_
  | MENOS_
  ;

operadorMultiplicativo
  : POR_
  | DIV_
  | MOD_
  ;

operadorUnario
  : MAS_
  | MEN_
  | NOT_
  ;

operadorIncremento
  : INC_
  | DEC_
  ;

%%
/*****************************************************************************/


