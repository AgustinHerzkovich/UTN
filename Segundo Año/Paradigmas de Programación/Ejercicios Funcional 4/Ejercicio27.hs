sumarListaFoldl :: (Num a) => [a] -> a
sumarListaFoldl = foldl (+) 0

sumarListaFoldr :: (Num a) => [a] -> a
sumarListaFoldr = foldr (+) 0

{-
Definir una función que sume una lista de números.
Nota: Resolverlo utilizando foldl/foldr.
-}