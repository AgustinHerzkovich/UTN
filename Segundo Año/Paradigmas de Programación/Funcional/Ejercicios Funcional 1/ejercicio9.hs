mcm :: Integral a => a -> a -> a
mcm num1 num2 = (num1 * num2) `div` gcd num1 num2

{-
Definir la función mcm/2 que devuelva el mínimo común múltiplo entre dos números, de acuerdo a esta fórmula.
m.c.m.(a, b) = {a * b} / {m.c.d.(a, b)} 
Nota: Se puede utilizar gcd.
-}