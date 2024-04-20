esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe a = (== 0) . (a `mod`)

divisores :: Integer -> [Integer]
divisores numero = filter (esMultiploDe numero) [1 .. numero]

{-
Definir la función divisores/1, que recibe un número y devuelve la lista
de divisores. P.ej.
Main> divisores 60
[1,2,3,4,5,6,10,12,15,20,30,60]
Ayuda: para calcular divisores n alcanza con revisar los números
entre 1 y n.
-}