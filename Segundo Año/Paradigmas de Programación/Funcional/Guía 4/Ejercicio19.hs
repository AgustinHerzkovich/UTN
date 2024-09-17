sumaF :: (Num b) => [a -> b] -> a -> b
sumaF lista numero = sum (aplicarFunciones lista numero)

aplicarFunciones :: [a -> b] -> a -> [b]
aplicarFunciones lista valor = transformacionRecursiva valor lista []

transformacionRecursiva :: a -> [a -> b] -> [b] -> [b]
transformacionRecursiva valor lista1 lista2
  | null lista1 = reverse lista2
  | otherwise = transformacionRecursiva valor (tail lista1) (head lista1 valor : lista2)

{-
Definir la función sumaF/2, que dadas una lista de funciones y un ´
número, devuelve la suma del resultado de aplicar las funciones al
número. P.ej.
Main> sumaF[(*4),(+3),abs] (-8)
-29
-}