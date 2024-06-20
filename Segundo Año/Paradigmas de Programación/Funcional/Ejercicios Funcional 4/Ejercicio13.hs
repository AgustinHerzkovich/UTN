aprobo :: (Ord a, Num a) => [a] -> Bool
aprobo lista = (>= 6) `all` lista

{-
Definir la función aprobó/1, que dada la lista de las notas de un alumno
devuelve True si el alumno aprobó. Se dice que un alumno aprobó si 
todas sus notas son 6 o más. P.ej. 
Main> aprobo [8,6,2,4] 
False 
Main> aprobo [7,9,6,8] 
True 
Ayuda: Utilizar la función predefinida minimum/1. 
-}