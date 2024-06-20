parDeFns :: (a -> b) -> (a -> c) -> a -> (b, c)
parDeFns funcion1 funcion2 valor = (funcion1 valor, funcion2 valor)

{-
Definir la función parDeFns/3, que recibe dos funciones y un valor,
y devuelve un par ordenado que es el resultado de aplicar
las dos funciones al valor. P.ej.
Main> parDeFns even doble 12
(True, 24)
-}