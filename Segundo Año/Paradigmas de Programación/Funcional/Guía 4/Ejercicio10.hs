listaDeLista :: (Num c) => [[c]]
listaDeLista = [[8, 6], [7, 9, 4], [6, 2, 4], [9, 6]]

promedio :: (Num a, Fractional a) => [a] -> a
promedio lista = sum lista / fromIntegral (length lista)

promedios :: (Num b, Fractional b) => [[b]] -> [b]
promedios = map promedio

{-
Armar una función promedios/1, que dada una lista de listas me devuelve
la lista de los promedios de cada lista-elemento. P.ej.
Main> promedios [[8,6],[7,9,4],[6,2,4],[9,6]]
[7,6.67,4,7.5]
Nota: Implementar una solución utilizando map/2.
-}
