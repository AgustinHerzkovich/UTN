aplicar :: (a -> b, a -> c) -> a -> (b, c)
aplicar (x, y) entero = (x entero, y entero)

{-
Definir la función aplicar, que recibe como argumento una tupla de 2 elementos con funciones y un entero, me devuelve como resultado una tupla con el resultado de aplicar
el elemento a cada una de la funciones, ej:
Main> aplicar (doble,triple) 8
(16,24)
Main> aplicar ((3+),(2*)) 8
(11,16)
-}