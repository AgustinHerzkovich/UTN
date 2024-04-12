import Text.Show.Functions

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe num1 num2 =  num2 `mod` num1 == 0

esMultiploDe400 :: Integral a => a -> Bool
esMultiploDe400  =  esMultiploDe 400

esMultiploDe4 :: Integral a => a -> Bool
esMultiploDe4  =  esMultiploDe 4

esMultiploDe100 :: Integral a => a -> Bool
esMultiploDe100  =  esMultiploDe 100

esBisiesto :: Integral a => a -> Bool
esBisiesto anio = esMultiploDe400 anio || esMultiploDe4 anio && (not . esMultiploDe100) anio

{-
Resolver la función del ejercicio 5 de la guía anterior esBisiesto/1, utilizando aplicación parcial y composición
Un año es bisiesto si es divisible por 400 o es divisible por 4 pero no es divisible por 100)
-}