listaDeLista :: (Num c) => [[c]]
listaDeLista = [[8, 6], [6, 2, 6]]

promedio :: (Num a, Fractional a) => [a] -> a
promedio lista = sum lista / fromIntegral (length lista)

promedios :: (Num b, Fractional b) => [[b]] -> [b]
promedios = map promedio

filtrarSublistas :: (a -> Bool) -> [[a]] -> [[a]]
filtrarSublistas condicion = map (filter condicion)

promediosSinAplazos :: (Num b, Fractional b, Ord b) => [[b]] -> [b]
promediosSinAplazos lista = promedios (filtrarSublistas (> 4) lista)

{-
Armar una función promediosSinAplazos que dada una lista de listas
me devuelve la lista de los promedios de cada lista-elemento,
excluyendo los que sean menores a 4 que no se cuentan. P.ej.
Main> promediosSinAplazos [[8,6],[6,2,6]]
[7,6]
Nota: Implementar una solución utilizando map/2.
-}