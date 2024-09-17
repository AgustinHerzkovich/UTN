productoListaFoldl :: (Num a) => [a] -> a
productoListaFoldl = foldl (*) 1

productoListaFoldr :: (Num a) => [a] -> a
productoListaFoldr = foldr (*) 1

{-
Definir una función que resuelva la productoria de una lista de números.
Nota: Resolverlo utilizando foldl/foldr.
-}