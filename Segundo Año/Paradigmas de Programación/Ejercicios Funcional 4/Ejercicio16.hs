exists :: (a -> Bool) -> [a] -> Bool
exists = any

{-
Definir la función exists/2, que dadas una función booleana y
una lista devuelve True si la función da True para algún elemento de
la lista. P.ej.
Main> exists even [1,3,5]
False
Main> exists even [1,4,7]
True
porque even 4 da True
-}