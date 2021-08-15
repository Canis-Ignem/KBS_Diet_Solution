(deftemplate Objetivo

    (slot meta)

)

(deftemplate Deporte

    (slot intensidad)
    (slot tipodeejercicio)

)

(deftemplate Frecuencia

    (slot dias)

)

(deftemplate Dieta

    (multislot alimentos)
    (slot terminada)

)

(deftemplate Pregunta 

	(slot ident)
	(slot texto)
	(slot respuesta)
	(multislot alternativas)
)

(deftemplate Usuario

    (slot proteinas)
    (slot fibra)
    (slot carbohidratos)
    (slot calorias)
    (slot grasa)
    
    (slot sexo)
    (slot edad)
    (slot altura)
    (slot peso)
    (slot calorias)

)

(deftemplate Plato

    (slot proteinas)
    (slot fibra)
    (slot carbohidratos)
    (slot grasa)
    (slot calorias)
    (multislot alimentos)

)

(deftemplate Alimento 

    (slot nombre)
    

)

;;;;;;;;;;;;;;; MARTIN ESCRIBE AQUI LOS PLATOS TE DEJO LA PLANTILLA HECHA PROTEINAS FIBRA Y LOS DEMASES
;;;;;;;;;;;;;;; VAN DE 0-4 NADA < BAJO < MEDIO < ALTO < MUY ALTO Y LOS ALIMENTOS SEPARADOS POR ESPACIOS

(deffacts Platos

    (Plato
        (nombre "xxxx")
        (proteinas 0-4)
        (fibra 0-4)
        (grasa 0-4)
        (calorias xxxx)+
        (alimentos xxxx yyyy zzzz)

    )



)


(deffacts Datos

    (Objetivo (meta nil) ) 

    (Deporte (intensidad nil ) (tipodeejercicio nil) ) 

    (Frecuencia (dias nil) ) 

    (Dieta (alimentos ) (terminada no) ) 

    (Usuario (proteinas nil ) (fibra nil) (carbohidratos nil) )
)

(deffacts Alimentos
    (  Alimento

        (nombre "Boniato")
        
    (  Alimento

        (nombre "Cebolla")

    (  Alimento

        (nombre "Berenjena")

    (  Alimento

        (nombre "Brocoli")

    (  Alimento

        (nombre "Pimiento Verde")

    (  Alimento

        (nombre "lechuga sola")

    (  Alimento

        (nombre "pipas")

    (  Alimento

        (nombre "Pimiento Rojo")
    
    )

    (  Alimento

        (nombre "Patata")

    (  Alimento

        (nombre "Conejo")

    (  Alimento

        (nombre "Pavo")
    
    )
    (  Alimento

        (nombre "Cerdo")

    )

    (  Alimento

        (nombre "Ternera")

    )

    (  Alimento

        (nombre "Macarrones")

     )

    (  Alimento

        (nombre "Pollo")

     )

    (  Alimento

        (nombre "Espaguetis de Huevo")

    )

    (  Alimento

        (nombre "Huevo")

     )


    (  Alimento

        (nombre "Alubias rojas")

    )

    ( Alimento

        (nombre "Alubias blancas")

    )

    (  Alimento

        (nombre "Lentejas")

    )
    
    (  Alimento


        (nombre "Pizza")

    )
    
    (  Alimento

        (nombre "Bacalao")

    )

    (  Alimento

        (nombre "Merluza")

    )

    (  Alimento

        (nombre "Vainas")

    )

    (Alimento

        (nombre "Garbanzos")

    )

    (  Alimento

        (nombre "Solomo gorria")

    )

    
    (  Alimento

        (nombre "Nueces")
    )

    (  Alimento

        (nombre "Cortezas de cerdo")
    )

    (  Alimento

        (nombre "Fideos")

    )

    (  Alimento

        (nombre "Pistachos")

    )


    (  Alimento

        (nombre "Puerro")

    )

    (  Alimento

        (nombre "Salchicas")

    )

    (  Alimento

        (nombre "Tortilla")

    )

    
)



(deffacts Preguntas

    (Pregunta (ident sexo) (texto "¿Eres hombre o mujer?") (alternativas H M) )

    (Pregunta (ident peso) (texto "¿Cuanto pesas? (kg)") (alternativas a mirar) )

    (Pregunta (ident altura) (texto "¿Cuanto mides? (cm)") (alternativas a mirar) )

    (Pregunta (ident edad) (texto "¿Cuantos años tienes? ") (alternativas a mirar) )

    (  Pregunta ( ident objetivo)( texto "¿Cual seria tu objetivo? " )(alternativas ganar_musculo perder_peso) )

    (  Pregunta ( ident tipoDeporte)( texto "¿Que tipo de deporte haces? " )(alternativas levantamiento_de_peso cardiovascular) ) 

    (  Pregunta ( ident intensidad )( texto "¿A que grupo se parece mas tu deporte? 
    Intensadidad alta: Futbol, Baloncesto...  
    Intensadidad baja: aerobic, yoga... 
    " )(alternativas alta baja) )

    (  Pregunta ( ident frecuencia)( texto "¿Cuantos dias a la semana lo practicas? " )(alternativas 1-2 3-5 5+) )


    (  Pregunta ( ident fin)( texto "y ahora que? " )(alternativas reset terminar) )

)
