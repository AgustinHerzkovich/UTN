notas :: [[Integer]]
notas = [[8, 6, 2, 4], [7, 9, 4, 5], [6, 2, 4, 2], [9, 6, 7, 10]]

mejoresNotas :: [[Integer]] -> [Integer]
mejoresNotas = map maximum

{-
Definir la función mejoresNotas, que dada la información de un curso
devuelve la lista con la mejor nota de cada alumno. P.ej.
Main> mejoresNotas [[8,6,2,4],[7,9,4,5],[6,2,4,2],[9,6,7,10]]
[8,9,6,10].
Ayuda: Utilizar la función predefinida maximum/1.
-}