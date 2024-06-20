infoCurso :: [[Integer]]
infoCurso = [[8, 6, 2, 4], [7, 9, 6, 7], [6, 2, 4, 2], [9, 6, 7, 10]]

aprobo :: (Ord a, Num a) => [a] -> Bool
aprobo lista = (>= 6) `all` lista

aprobaron :: (Ord a, Num a) => [[a]] -> [[a]]
aprobaron = filter aprobo

{-
Definir la función aprobaron/1, que dada la información de un
curso devuelve la información de los alumnos que aprobaron. P.ej.
Main> aprobaron [[8,6,2,4],[7,9,6,7],[6,2,4,2],[9,6,7,10]]
[[7,9,6,7],[9,6,7,10]]
Ayuda: usar la función aprobó/1.
-}