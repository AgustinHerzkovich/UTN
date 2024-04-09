esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe num1 num2 = mod num2 num1 == 0

esBisiesto :: Integral a => a -> Bool
esBisiesto anio = esMultiploDe 400 anio || (esMultiploDe 4 anio && not(esMultiploDe 100 anio))

{-
Definir la función esBisiesto/1, indica si un año es bisiesto. (Un año es bisiesto si es divisible por 400 o es divisible por 4 pero no es divisible por 100) 
Nota: Resolverlo reutilizando la función esMultiploDe/2
-}