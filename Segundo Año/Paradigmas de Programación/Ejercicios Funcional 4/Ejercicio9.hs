esMultiploDe :: (Integral a) => a -> a -> Bool
esMultiploDe a = (== 0) . (`mod` a)

esMultiploDeAlguno :: (Integral a) => a -> [a] -> Bool
esMultiploDeAlguno num = any (`esMultiploDe` num)

{-
Definir la función esMultiploDeAlguno/2, que recibe un número y una lista y devuelve True si el número es múltiplo de alguno de los números de la lista. P.ej.
Main> esMultiploDeAlguno 15 [2,3,4]
True,
porque 15 es múltiplo de 3

Main> esMultiploDeAlguno 34 [3,4,5]
False
porque 34 no es múltiplo de ninguno de los 3 Nota: Utilizar la función any/2.
-}
