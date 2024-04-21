esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe a = (== 0) . (a `mod`)

primerosPares :: [Integer] -> [Integer]
primerosPares = takeWhile even

primerosDivisores :: Integer -> [Integer] -> [Integer]
primerosDivisores n = takeWhile (esMultiploDe n)

primerosNoDivisores :: Integer -> [Integer] -> [Integer]
primerosNoDivisores n = takeWhile (not . esMultiploDe n)

{-
Usar takeWhile/2 para definir las siguientes funciones: primerosPares/1, que recibe una lista de números y devuelve la sublista hasta el primer no par exclusive. P.ej.
Main> primerosPares [4,12,3,8,2,9,6]
devuelve [4,12], corta en 3 porque no es par

primerosDivisores/2, que recibe una lista de números y un número n, y devuelve la sublista hasta el primer número que no es divisor de n exclusive. P.ej.
Main> primerosDivisores 60 [4,12,3,8,2,9,6]
devuelve [4,12,3], corta en 8 porque no divide a 60

primerosNoDivisores/2, que recibe una lista de números y un número n, y devuelve la sublista hasta el primer número que sí es divisor de n exclusive. P.ej.
Main> primerosNoDivisores 60 [8,9,4,12,3,8,2,9,6]
devuelve [8,9], corta en 4 porque divide a 60
-}