import Text.Show.Functions

esDivisiblePor :: Integral a => a -> a -> Bool
esDivisiblePor num1  = (==0) . mod num1

esBisiesto :: Integral a => a -> Bool
esBisiesto anio = (`esDivisiblePor` 400) anio || (`esDivisiblePor` 4) anio && (not . (`esDivisiblePor` 100)) anio

{-
Resolver la función del ejercicio 5 de la guía anterior esBisiesto/1, utilizando aplicación parcial y composición
Un año es bisiesto si es divisible por 400 o es divisible por 4 pero no es divisible por 100)
-}