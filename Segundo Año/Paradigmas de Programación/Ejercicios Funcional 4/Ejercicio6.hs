mejor :: (Ord a) => (t -> a) -> (t -> a) -> t -> a
mejor f1 f2 num = f1 num `max` f2 num

{-
Definir la función mejor/3, que recibe dos funciones y un número,
y devuelve el resultado de la función que dé un valor más alto. P.ej.
Main> mejor cuadrado triple 1
3
(pues triple 1 = 3 > 1 = cuadrado 1)

Main> mejor cuadrado triple 5
25
(pues cuadrado 5 = 25 > 15 = triple 5)
Nota: No olvidar la función max.
-}