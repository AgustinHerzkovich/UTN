hayAlgunNegativo :: (Foldable t, Ord a, Num a) => t a -> (a -> Bool) -> Bool
hayAlgunNegativo lista condicion = any condicion lista

{-
Definir la función hayAlgunNegativo/2, que dada una lista de números y
un (…algo…) devuelve True si hay algún nro. negativo.
Main> hayAlgunNegativo [2,-3,9] (…algo…)
True
-}