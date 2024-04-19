esCapicua :: (Eq a) => [[a]] -> Bool
esCapicua lista = concat lista == (reverse . concat) lista

{-Definir la función esCapicua/1, si data una lista de listas,
me devuelve si la concatenación de las sublistas es una lista capicua..Ej:
Main> esCapicua ["ne", "uqu", "en"]
True
Porque “neuquen” es capicua.
Ayuda: Utilizar concat/1, reverse/1.
-}