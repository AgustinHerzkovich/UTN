--f
resto :: (Eq a, Num a, Integral a) => a -> a -> a
resto dividendo divisor = dividendo - divisor * div dividendo divisor

--g
cero :: (Eq a, Num a) => a -> Bool
cero = (==0)

--voy a hacer gof, primero aplico f y luego g
{-
Resolver la función del ejercicio 2 de la guía anterior esMultiploDe/2, utilizando aplicación parcial y composición
-}
