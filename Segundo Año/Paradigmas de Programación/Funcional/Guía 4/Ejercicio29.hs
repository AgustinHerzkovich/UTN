dispersion :: (Num a, Foldable t, Ord a) => t a -> a
dispersion lista = maximum lista - minimum lista

{-
Definir la función dispersion, que recibe una lista de números y devuelve la dispersión de los valores, o sea máximo - mínimo.
Nota: Probar de utilizar foldr.
-}