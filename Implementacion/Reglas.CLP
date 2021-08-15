
;;;; MODULO MAIN
(defmodule MAIN  (export ?ALL))

(defrule R0-PRESENTACION-DEL-SISTEMA ""

 
  =>
  (printout t crlf crlf)
  (printout t "Prototipo 1: Asistente de Alimentacion")
  (printout t crlf crlf)
  (focus OBTENER-INFO REQUISITOS CHEFF TERMINAR )
  
  )




;;;; MODULO PREGUNTAS
(defmodule PREGUNTAS (export ?ALL)( import MAIN ?ALL) )


(deffunction preguntar2 (?pregunta $?valores-permitidos)
   (printout t ?pregunta)
   (bind ?respuesta (read))
   (if (lexemep ?respuesta) 
       then (bind ?respuesta (lowcase ?respuesta)))
   (while (not (member ?respuesta ?valores-permitidos)) do
      (printout t ?pregunta)
      (bind ?respuesta (read))
      (if (lexemep ?respuesta) 
          then (bind ?respuesta (lowcase ?respuesta))))
   ?respuesta)

    (deffunction preguntar (?pregunta $?valores-permitidos)
    (preguntar2 (sym-cat ?pregunta "(" (implode$ $?valores-permitidos) ")? ") $?valores-permitidos))


;Pregunta sin alternativas
(deffunction pregunta_abierta ( ?pregunta )

    (printout t ?pregunta)
    (bind ?respuesta (read) )
    ( while (not (numberp ?respuesta)) do
        (printout t ?pregunta)
        (bind ?respuesta (read) )

    )
    ?respuesta
)




;;;; MODULO OBTENER-INFO
(defmodule OBTENER-INFO (import MAIN ?ALL)  (import PREGUNTAS ?ALL) (export ?ALL))

(defrule presentar
    (declare (salience 60) )
    =>
    (printout t crlf crlf)
    (printout t "Vamos a hacerte varias preguntas para determinar tus necesidades alimenticias")
    (printout t crlf crlf)


)


;;INICIALIZAR LOS VALORES DEFFACTS

(defrule P1-Averiguar-Objetivo

    (declare (salience 50 ))

    ?f <- (Frecuencia (dias nil))

    ?d <- (Deporte (tipodeejercicio nil) (intensidad nil) )

    ?o <- (Objetivo (meta nil) )

    ?p1 <- (Pregunta (ident objetivo) (texto ?t) (alternativas $?al) (respuesta nil) )
    
    =>

    (bind  ?respuesta ( preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?o  (meta ?respuesta)  )


)

(defrule P2-Averiguar-Tipo-Deporte

    (declare (salience 40 ))

    ?f <- (Frecuencia (dias nil))

    ?d1 <-(Deporte (tipodeejercicio nil) (intensidad nil) )

    ?p1 <- (Pregunta (ident tipoDeporte) (texto ?t) (alternativas $?al) (respuesta nil) )

    =>

    (bind  ?respuesta ( preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?d1 (tipodeejercicio ?respuesta) )
    


)

(defrule p2.1-intensidad-Irrelevante

    (declare (salience 30 ))

    ?f <- (Frecuencia (dias nil))

    ?d1 <- (Deporte (tipodeejercicio levantamiento_de_peso) (intensidad nil) )

    =>

    (modify ?d1 (intensidad Irrelevante) )

)

(defrule P3-Averiguar-intensidad

    (declare (salience 20 ))

    ?d1 <- (Deporte (tipodeejercicio cardiovascular) (intensidad nil) )

    (Frecuencia (dias nil) )

    ?p1 <- (Pregunta (ident intensidad) (texto ?t) (alternativas $?al) (respuesta nil) )

    =>

    (bind  ?respuesta ( preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?d1 (intensidad ?respuesta) )


)

(defrule P4-Averiguar-Frecuencia

    (declare (salience 10 ))

    ?p1 <- (Pregunta (ident frecuencia) (texto ?t) (alternativas $?al) (respuesta nil) )

    ?f1 <- (Frecuencia (dias nil) )
    =>

    (bind  ?respuesta ( preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?f1 (dias ?respuesta)  )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(focus REQUISITOS)


)

(defrule P5-Averiguar-Sexo

    ?p1 <- (Pregunta (ident sexo) (text ?t) (alternativas $?al) (respuesta nil) )

    ?u1 <- (Usuario (sexo nil))

    =>

    (bind ?respuesta (preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?u1 (sexo ?respuesta) )

)

(defrule P6-Averiguar-Peso

    ?p1 <- (Pregunta (ident peso) (text ?t) (respuesta nil) )

    ?u1 <- (Usuario (peso nil))

    =>

    (bind ?respuesta (pregunta_abierta ?t ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?u1 (peso ?respuesta) )

)

(defrule P7-Averiguar-Altura

    ?p1 <- (Pregunta (ident peso) (text ?t) (respuesta nil) )

    ?u1 <- (Usuario (altura nil))

    =>

    (bind ?respuesta (pregunta_abierta ?t ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?u1 (altura ?respuesta) )

)

(defrule P8-Averiguar-edad

    ?p1 <- (Pregunta (ident peso) (text ?t) (respuesta nil) )

    ?u1 <- (Usuario (edad nil))

    =>

    (bind ?respuesta (pregunta_abierta ?t ) )
    (modify ?p1 (respuesta ?respuesta) )
    (modify ?u1 (edad ?respuesta) )

)

(defrule calculo-calorias-hombre

    ?u <- (Usuario (sexo H) (peso ?p) (altura ?a) (edad ?e) (calorias ?cal))

    =>
    (bind ?p1 (* 12.7516 ?p) )
    (bind ?a1 (* 5.0033 ?a) )
    (bind ?e1 (* 6.7550 ?e) )
    (bind ?c1  (  (- (+ (+ 66.4730 ?p1) ?a1 ) ?e1) ) )
    (modify ?u (calorias ?c1)
)

(defrule calculo-calorias-mujer

    ?u <- (Usuario (sexo M) (peso ?p) (altura ?a) (edad ?e) (calorias ?cal))

    =>
    (bind ?p1 (* 9.5634 ?p) )
    (bind ?a1 (* 1.8496 ?a) )
    (bind ?e1 (* 4.6756 ?e) )
    (bind ?c1  (  (- (+ (+ 655.0955 ?p1) ?a1 ) ?e1) ) )
    (modify ?u (calorias ?c1)
)

;;; MODULO REQUISITOS
(defmodule REQUISITOS (import MAIN ?ALL) (import PREGUNTAS ?ALL) (import OBTENER-INFO ?ALL) (export ?ALL) ) 

(defrule R1_GM_LP_1-2
    (declare (salience 10 ) )
    

    =>

    (printout t crlf crlf)
    (printout t "Gracias por responder a nuestras preguntas! ")
    (printout t crlf crlf)
    (printout t "Solo tardaremos un momento...")
    (printout t crlf crlf)

)

;;;LEVANTAMIENTO DE PESO PARA GANAR MUSCULO
(defrule R1_GM_LP_1-2

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 1-2) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 3) (fibra 0) ( carbohidratos 2 ) )
    (focus CHEFF)

)


(defrule R2_GM_LP_3-5

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 3-5) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 3) (fibra 0) ( carbohidratos 3 ) )
    (focus CHEFF)
)

(defrule R3_GM_LP_5+

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 5+) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 4) (fibra 0) ( carbohidratos 4 ) )
    (focus CHEFF)
)


;;;;CARVIOVASCULARES DE ALTA intensidad PARA GANAR MUSCULO
(defrule R4_GM_CA_1-2

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 1-2) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 2) (fibra 0) ( carbohidratos 2 ) )
    (focus CHEFF)
)

(defrule R5_GM_CA_3-5

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 3-5) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 2) (fibra 0) ( carbohidratos 3 ) )
    (focus CHEFF)
)

(defrule R6_GM_CA_5+

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 5+) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 3) (fibra 0) ( carbohidratos 4 ) )
    (focus CHEFF)
)


;;; ;;;;CARVIOVASCULARES DE BAJA intensidad PARA GANAR MUSCULO

(defrule R7_GM_CB

    (Objetivo (meta ganar_musculo))
    (Deporte (tipodeejercicio cardiovascular) (intensidad baja) ) 
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )
    ?d <- (Dieta (terminada no))

    =>
    (printout t crlf crlf)
    (printout t "Deberias buscar otro deporte de mayor intensidad")
    (printout t crlf crlf)
    (modify ?d (terminada si))
    (focus TERMINAR)

)











;;;;;;;;;;;;PERDER PESO





;;;; LEVANTAMIENTO DE PESO PARA PERDER PESO
(defrule R8_PP_LP_1-2

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 1-2) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 0) (fibra 3) ( carbohidratos 1 ) )
    (focus CHEFF)
)

(defrule R9_PP_LP_3-5

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 3-5) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 1) (fibra 3) ( carbohidratos 2 ) )
    (focus CHEFF)
)

(defrule R10_PP_LP_5+

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio levantamiento_de_peso) )
    (Frecuencia (dias 5+) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 2) (fibra 3) ( carbohidratos 2 ) )
    (focus CHEFF)
)



;;;;CARVIOVASCULARES DE ALTA intensidad PARA PERDER PESO
(defrule R11_PP_CA_1-2

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 1-2) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 0) (fibra 3) ( carbohidratos 1 ) )
    (focus CHEFF)
)

(defrule R12_PP_CA_3-5

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 3-5) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 0) (fibra 3) ( carbohidratos 2 ) )
    (focus CHEFF)
)

(defrule R13_PP_CA_5+

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio cardiovascular) (intensidad alta) )
    (Frecuencia (dias 5+) )
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (modify ?u (proteinas 0) (fibra 3) ( carbohidratos 4 ) )
    (focus CHEFF)
)


;;; ;;;;CARVIOVASCULARES DE BAJA intensidad PARA PERDER PESO
 
(defrule R14_PP_CB

    (Objetivo (meta perder_peso))
    (Deporte (tipodeejercicio cardiovascular) (intensidad baja) ) 
    ?u <- (Usuario (proteinas nil) (fibra nil) (carbohidratos nil) )

    =>

    (printout t crlf crlf)
    (printout t "Deberias practicar mas deporte")
    (printout t crlf crlf)
    (modify ?u (proteinas 0) (fibra 1) ( carbohidratos 1 ) )
    (focus CHEFF)
)


;;;;;;;;;MODULO CHEF TE DICE QUE COMER
(defmodule CHEFF (import OBTENER-INFO ?ALL) (import PREGUNTAS ?ALL) (import MAIN ?ALL) (export ?ALL))


;;;CASO IDEAL
(defrule R15-CASO-IDEAL " Hemos encontrado un alimento que coincide a la perfeccion "

    ?u <- (Usuario (proteinas ?p) (fibra ?f) (carbohidratos ?c) )

    ?a <- (Alimento (proteinas ?p) (fibra ?f) (carbohidratos ?c) (recomendado FALSE) (nombre ?n) )

    ?d <- (Dieta (alimentos $?al ))

    =>

    (modify ?d (alimentos ?n ?al ) )
    (modify ?u (proteinas 0) (fibra 0) (carbohidratos 0) )
    (focus TERMINAR)
    
)


(defrule R16-PARECIDO-PARCIAL-PROTEINAS "Hemos encontrado un alimento que encaja perfectamente con la cantidad de proteinas "

    ?u <- (Usuario (proteinas ?p1 ) (fibra ?f1) (carbohidratos ?c1) )

    ?a <- (Alimento (proteinas ?p1)
            (fibra ?f2 &: ( <= ?f2 ?f1 ) )
            (carbohidratos ?c2 &: (<= ?c2 ?c1) )
            (recomendado FALSE)
            (nombre ?n) 
            )
    ?d <- ( Dieta (alimentos $?al ) )

    =>
    (modify ?d (alimentos ?n ?al ) )
    (bind ?c3 (- ?c1 ?c2) )
    (bind ?f3 (- ?f1 ?f2) )  
    (modify ?u (proteinas 0) (fibra ?f3 ) ( carbohidratos ?c3 ) )
    (modify ?a (recomendado TRUE ) )
)


(defrule R17-PARECIDO-PARCIAL-FIBRA "Hemos encontrado un alimento que encaja perfectamente con la cantidad de fibra "

    ?u <- (Usuario (proteinas ?p1) (fibra ?f1 ) (carbohidratos ?c1) )

    ?a <- (Alimento (proteinas ?p2 &: ( <= ?p2 ?p1 ) ) 
            (fibra ?f1 )
            (carbohidratos ?c2 &: ( <= ?c2 ?c1 ) )
            (recomendado FALSE)
            (nombre ?n) 
            )
    ?d <- ( Dieta (alimentos $?al ) )

    =>
    (modify ?d (alimentos ?n ?al ) )
    (bind ?p3 (- ?p1 ?p2) )
    (bind ?c3 (- ?c1 ?c2) )
    (modify ?u (proteinas ?p3) (fibra 0 ) ( carbohidratos ?c3 ) )
    (modify ?a (recomendado TRUE ) )
)

(defrule R18-PARECIDO-PARCIAL-CARBOHIDRATOS "Hemos encontrado un alimento que encaja perfectamente con la cantidad de fibra "

    ?u <- (Usuario (proteinas ?p1) (fibra ?f1) (carbohidratos ?c1 ) )

    ?a <- (Alimento (proteinas ?p2 &: ( <= ?p2 ?p1 ))
            (fibra ?f2 &: (<= ?f2 ?f1) )
            (carbohidratos ?c1  )
            (recomendado FALSE)
            (nombre ?n) 
            )
    ?d <- ( Dieta (alimentos ?n $?al ) )

    =>
    (modify ?d (alimentos ?n ?d ) )
    (bind ?f3 (- ?f1 ?f2) ) 
    (bind ?p3 (- ?p1 ?p2) ) 
    (modify ?u (proteinas ?p3) (fibra ?f3 ) ( carbohidratos 0 ) )
    (modify ?a (recomendado TRUE ) )
)


;;;;;;;;;MODULO TERMINAR
(defmodule TERMINAR (import PREGUNTAS ?ALL) (import OBTENER-INFO ?ALL)  (import MAIN ?ALL) (export ?ALL) )

(defrule R19-IMPRIMIR-DIETA

    ?u <- (Usuario (proteinas 0) (fibra 0) (carbohidratos 0) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "Te recomendamos que prubes: ")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si) )

)
(defrule R20-IMPRIMIR-DIETA-INSATISFACTORIA-PROTEINAS

    ?u <- (Usuario (proteinas ?p &: (neq ?p 0 ) ) )
    ?d <- (Dieta (alimentos $?al ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades proteicas, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si) )


)

(defrule R21-IMPRIMIR-DIETA-INSATISFACTORIA-CARBOHIDRATOS

    ?u <- (Usuario (carbohidratos ?c &: (neq ?c 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades de carbohidratos, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))

)

(defrule R22-IMPRIMIR-DIETA-INSATISFACTORIA-FIBRA

    ?u <- (Usuario (fibra ?f &: (neq ?f 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades de fibra, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))

)
(defrule R23-IMPRIMIR-DIETA-INSATISFACTORIA-FIBRA-Y-CARBOHIDRATOS

    ?u <- (Usuario (fibra ?f &: (neq ?f 0 ) ) (carbohidratos ?c &: (neq ?c 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades de fibra y carbohidratos, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))

)

(defrule R24-IMPRIMIR-DIETA-INSATISFACTORIA-FIBRA-Y-PROTEINAS

    ?u <- (Usuario (fibra ?f &: (neq ?f 0 ) ) (proteinas ?p &: (neq ?p 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades proteicas y de fibra, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))

)

(defrule R25-IMPRIMIR-DIETA-INSATISFACTORIA-CARBOHIDRATOS-Y-PROTEINAS

    ?u <- (Usuario (carbohidratos ?c &: (neq ?c 0 ) ) (proteinas ?p &: (neq ?p 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    
    (printout t crlf crlf)
    (printout t "No hemos conseguido satisfacer tu necesidades proteicas y de carbohidratos, por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))

)

(defrule R26-IMPRIMIR-DIETA-INSATISFACTORIA-COMPLETA

    ?u <- (Usuario (fibra ?f &: (neq ?f 0 ) ) (proteinas ?p &: (neq ?p 0 ) ) (carbohidratos ?c &: (neq ?c 0 ) ) )
    ?d <- (Dieta (alimentos $?al &: (neq ?al nil ) ) (terminada no) )

    =>
    (modify ?d (alimentos nil))
    (printout t crlf crlf)
    (printout t "Lo sentimos pero creo que has agotado nuestra base de datos, prueba a resetear la aplicacion.
    Por favor contactenos en 'esteEmailNoExiste@sorry.com' para cualquier otra duda")
    (printout t crlf crlf)
    (printout t ?al )
    (printout t crlf crlf)
    (modify ?d (alimentos nil) (terminada si))


)

(defrule R27-PREGUNTA-FINAL
    
    ?d <- (Dieta (terminada si) )
    ?p1 <- (Pregunta (ident fin) (texto ?t) (alternativas $?al) (respuesta nil) )
    =>

    (bind  ?respuesta ( preguntar ?t ?al ) )
    (modify ?p1 (respuesta ?respuesta) )
)

(defrule R28-RESET 

    ?ob <- (Objetivo (meta ?meta) )
    ?de <- (Deporte (tipodeejercicio ?tde ) (intensidad ?i)  )
    ?fr <- (Frecuencia (dias ?dias))
    ?u  <- (Usuario (proteinas ?pro) (fibra ?f) (carbohidratos ?c) )
    ?d  <- (Dieta (terminada si) )
    ?p1 <- (Pregunta (ident fin) (respuesta reset ) )
    ?p2 <- (Pregunta (ident tipoDeporte) (respuesta ?r2) )
    ?p3 <- (Pregunta (ident objetivo) (respuesta ?r3) )
    ?p4 <- (Pregunta (ident intensidad) (respuesta ?r4) )
    ?p5 <- (Pregunta (ident frecuencia) (respuesta ?r5) )

    =>
    (printout t crlf crlf)
    (printout t "Reseteando la aplicacion" )
    (printout t crlf crlf)
    (focus OBTENER-INFO)
    (modify ?ob (meta nil) )
    (modify ?de (tipodeejercicio nil) (intensidad nil) )
    (modify ?fr (dias nil))
    (modify ?p1 (respuesta nil ) )
    (modify ?p2 (respuesta nil ) )
    (modify ?p3 (respuesta nil ) )
    (modify ?p4 (respuesta nil ) )
    (modify ?p5 (respuesta nil ) )
    (modify ?d (terminada no) )
    (modify ?u (proteinas nil) (fibra nil) (carbohidratos nil) )
    
    
)


