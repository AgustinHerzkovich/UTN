cero :: Integer -> Bool
cero = (==0)

esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe a = cero . (`mod` a)

{-
Resolver la función del ejercicio 2 de la guía anterior esMultiploDe/2, utilizando aplicación parcial y composición
-}