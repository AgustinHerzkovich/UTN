elevar :: Integral a => a -> a -> a
elevar n m = (^m) n

esResultadoPar :: Integral a => a -> a -> Bool
esResultadoPar  m = even . elevar m

{-
Definir una función esResultadoPar/2, que invocándola con número n y otro m, devuelve true si el resultado de elevar n a m es par
Nota Obvia: Resolverlo utilizando aplicación parcial y composición
-}