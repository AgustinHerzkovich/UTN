aplicarFunciones :: [a -> b] -> a -> [b]
aplicarFunciones lista valor = transformacionRecursiva valor lista []

transformacionRecursiva :: a -> [a -> b] -> [b] -> [b]
transformacionRecursiva valor lista1 lista2
  | null lista1 = reverse lista2
  | otherwise = transformacionRecursiva valor (tail lista1) (head lista1 valor : lista2)

{-
Definir la función aplicarFunciones/2, que dadas una lista de funciones
y un valor cualquiera, devuelve la lista del resultado de aplicar las
funciones al valor. P.ej.
Main> aplicarFunciones[(*4),(+3),abs] (-8)
[-32,-5,8]
Si pongo:
Main> aplicarFunciones[(*4),even,abs] 8
da error. ¿Por qué?
porque hay funciones de distinto tipo
-}