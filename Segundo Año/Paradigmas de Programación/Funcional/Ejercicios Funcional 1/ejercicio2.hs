esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe num1 num2 = mod num2 num1 == 0

{-
Definir la función esMultiploDe/2, que devuelve True si el segundo 
es múltiplo del primero, p.ej. 
Main> esMultiploDe 3 12
True
-}