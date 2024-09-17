calcular :: (Int, Int) -> (Int, Int)
calcular tupla
  | (even . fst) tupla = auxiliar (((* 2) . fst) tupla, snd tupla)
  | (odd . fst) tupla = auxiliar tupla

auxiliar :: (Int, Int) -> (Int, Int)
auxiliar tupla
  | (odd . snd) tupla = (fst tupla, ((+ 1) . snd) tupla)
  | otherwise = tupla

{-
Definir la función calcular, que recibe una tupla de 2 elementos, si el primer elemento es par lo duplica, sino lo deja como está y con el segundo elemento en caso de ser impar
le suma 1 y si no deja esté último como esta.
Main> calcular (4,5)
(8,6)
Main> calcular (3,7)
(3,8)
Nota: Resolverlo utilizando aplicación parcial y composición.
-}