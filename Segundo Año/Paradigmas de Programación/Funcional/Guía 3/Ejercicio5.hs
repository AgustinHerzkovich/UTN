import Ejercicio4

notasFinales :: (Num a, Ord a) => ((a, a), (a, a)) -> (a, a)
notasFinales pardepares = (max ((fst . fst) pardepares) ((fst . snd) pardepares), max ((snd . fst) pardepares) ((snd . snd) pardepares))

recuperoDeGusto :: (Fractional a, Num a, Ord a) => ((a, a), (a, a)) -> Bool
recuperoDeGusto pardepares = (promociono . fst) pardepares && recupero pardepares

recupero :: (Num a, Ord a) => ((a, a), (a, a)) -> Bool
recupero pardepares = ((/= (-1)) . fst . snd) pardepares || ((/= (-1)) . snd . snd) pardepares

{-
Siguiendo con el dominio del ejercicio anterior, tenemos ahora dos parciales con dos recuperatorios, lo representamos mediante un par de pares ((parc1,parc2),(recup1,recup2)).
Si una persona no rindió un recuperatorio, entonces ponemos un "-1" en el lugar correspondiente.
Observamos que con la codificación elegida, siempre la mejor nota es el máximo entre nota del parcial y nota del recuperatorio.
Considerar que vale recuperar para promocionar. En este ejercicio vale usar las funciones que se definieron para el anterior.
Definir la función notasFinales que recibe un par de pares y devuelve el par que corresponde a las notas finales del alumno para el 1er y el 2do parcial. P.ej.
Main> notasFinales ((2,7),(6,-1))
(6,7)
Main> notasFinales ((2,2),(6,2))
(6,2)
Main> notasFinales ((8,7),(-1,-1))
(8,7)
Escribir la consulta que indica si un alumno cuyas notas son ((2,7),(6,-1)) recursa o no. O sea, la respuesta debe ser True si recursa, y False si no recursa.
Usar las funciones definidas en este punto y el anterior, y composición. La consulta debe tener esta forma:
Main> (... algo ...) ((2,7),(6,-1))
Escribir la consulta que indica si un alumno cuyas notas son ((2,7),(6,-1)) recuperó el primer parcial. Usar composición. La consulta debe tener esta forma:
Main> (... algo ...) ((2,7),(6,-1))
Definir la función recuperoDeGusto que dado el par de pares que representa a un alumno, devuelve True si el alumno, pudiendo promocionar con los parciales (o sea sin recup.),
igual rindió al menos un recup. Vale definir funciones auxiliares. Hacer una definición que no use pattern matching, en las eventuales funciones auxiliares tampoco; o sea, manejarse
siempre con fst y snd.
-}