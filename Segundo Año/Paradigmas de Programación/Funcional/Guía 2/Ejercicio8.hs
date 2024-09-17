inversa :: Fractional a => a -> a
inversa  = (1/)

inversaRaizCuadrada :: Double -> Double
inversaRaizCuadrada  = inversa . sqrt

{-
Resolver la función inversaRaizCuadrada/1, que da un número n devolver la inversa su raíz cuadrada
Nota: Resolverlo utilizando la función inversa Ej. 2.3, sqrt y composición
-}