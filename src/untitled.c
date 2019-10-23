boolean         			true | false
simbolo         			letraMinus
							| letraMayus
							| _
							| digito

cte 						digito+
id         					(letraMinus| _)simbolo*

tipoSimple      			entero
							| boolean

declaracion     			tipoSimple id ;
			                | tipoSimple id = constante ;
			                | tipoSimple id [ cte ] ;
			                | "struct" { listaCampos } id ;

instruccion     			{ }
			                | { listaInstrucciones }
			                | instruccionEntradaSalida
			                | instruccionSeleccion
			                | instruccionIteracion
			                | instruccionExpresion

listaInstrucciones           instruccion+

instruccionEntradaSalida     read ( id ) ; 
                             | print ( expresion ) ;

instruccionSeleccion         if ( expresion ) instruccion else instruccion

instruccionIteracion         while ( expresion ) instruccion

instruccionExpresion        expresion ; 
							| ;

expresion                   expresionLogica
                            | id operadorAsignacion expresion 
                            | id [ expresion ] operadorAsignacion expresion
                            | id . id operadorAsignacion expresion

expresionLogica 			expresionIgualdad
                			| expresionLogica operadorLogico expresionIgualdad     

expresionIgualdad 			expresionRelacional
                			| expresionIgualdad operadorIgualdad expresionRelacional

expresionRelacional 		expresionAditiva
    						| expresionRelacional operadorRelacional expresionAditiva

expresionAditiva 			expresionMultiplicativa
    						| expresionAditiva operadorAditivo expresionMultiplicativa

expresionMultiplicativa 	expresionUnaria
    						| expresionMultiplicativa operadorMultiplicativo expresionUnaria

expresionUnaria 			expresionSufija
						    | operadorUnario expresionUnaria
						    | operadorIncremento id

expresionSufija 			( expresion )
						    | id operadorIncremento
						    | id [ expresion ]
						    | id
						    | id . id
						    | constante

constante 					cte
    						| boolean    

sentencia       			declaracion 
							| instruccion

secuenciaSentencias  sentencia+
programa       { secuenciaSentencias }
listaCampos     tipoSimple id ;
				| listaCampos tipoSimple id ;
