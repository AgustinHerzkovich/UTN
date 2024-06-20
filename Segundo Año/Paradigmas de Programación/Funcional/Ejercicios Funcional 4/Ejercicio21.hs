rango :: [Int]
rango = [0 .. 12]

flimitada :: (Num a, Num b, Ord b) => (a -> b) -> a -> b
flimitada funcion = max 0 . min 12 . funcion

cambiarHabilidad :: (Num a, Num b, Ord b) => (a -> b) -> [a] -> [b]
cambiarHabilidad f = map (flimitada f)

{-
Ahora el requerimiento es más genérico: hay que cambiar la habilidad de cada jugador según una función que recibe la vieja habilidad y devuelve la nueva. Armar:
una función flimitada que recibe una función f y un número n, y devuelve f n garantizando que quede entre 0 y 12 (si f n < 0 debe devolver 0, si f n > 12 debe devolver 12). P.ej.
Main> flimitada (*2) 9
12
pues 9*2 = 18 > 12

Main> flimitada (+(-4)) 3
0
pues 3-4 = -1 < 0

Main> flimitada (*2) 5
10
pues 5*2 = 10 que está en rango
Hacerlo en una sola línea y sin guardas. Ayuda: usar min y max.

Definir una función cambiarHabilidad/2, que reciba una función f y una lista de habilidades, y devuelva el resultado de aplicar f con las garantías de rango que da flimitada.
P.ej.
Main> cambiarHabilidad (*2) [2,4,6,8,10]
[4,8,12,12,12]

Usar cambiarHabilidad/2 para llevar a 4 a los que tenían menos de 4, dejando como estaban al resto. P.ej.
Main> cambiarHabilidad ... [2,4,5,3,8]
[4,4,5,4,8]
Lo que hay que escribir es completar donde están los puntitos.
... = (max 4)
-}