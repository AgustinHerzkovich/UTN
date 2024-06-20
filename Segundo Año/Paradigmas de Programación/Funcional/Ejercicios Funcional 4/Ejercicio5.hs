existsAny :: (a -> Bool) -> (a, a, a) -> Bool
existsAny condicion tupla = (condicion . primero) tupla || (condicion . segundo) tupla || (condicion . tercero) tupla

primero :: (a, b, c) -> a
primero (x, _, _) = x

segundo :: (a, b, c) -> b
segundo (_, y, _) = y

tercero :: (a, b, c) -> c
tercero (_, _, z) = z

{-
 Definir la función existsAny/2, que dadas una función booleana y una tupla de tres elementos devuelve True si existe algún elemento de la tupla que haga verdadera la función.
Main> existsAny even (1,3,5)
False

Main> existsAny even (1,4,7)
True
porque even 4 da True

Main> existsAny (0>) (1,-3,7)
True
porque -3 es negativo
 -}