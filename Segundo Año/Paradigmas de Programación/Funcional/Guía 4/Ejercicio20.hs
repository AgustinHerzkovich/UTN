subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad numero = reemplazarPor12 . map (+ numero)

reemplazarPor12 :: [Int] -> [Int]
reemplazarPor12 [] = [] -- Caso base: lista vacía
reemplazarPor12 (x : xs)
  | x > 12 = 12 : reemplazarPor12 xs -- Si el elemento es mayor que 12, lo reemplazamos por 12
  | otherwise = x : reemplazarPor12 xs -- Si no, mantenemos el elemento original y continuamos con el resto de la lista

{-
Un programador Haskell está haciendo las cuentas para un juego de fútbol virtual (como el Hattrick o el ManagerZone). En un momento le llega la información sobre la habilidad de
cada jugador de un equipo, que es un número entre 0 y 12, y la orden de subir la forma de todos los jugadores en un número entero; p.ej., subirle 2 la forma a cada jugador. Ahora,
ningún jugador puede tener más de 12 de habilidad; si un jugador tiene 11 y la orden es subir 2, pasa a 12, no a 13; si estaba en 12 se queda en 12. Escribir una función subirHabilidad/2
que reciba un número (que se supone positivo sin validar) y una lista de números, y le suba la habilidad a cada jugador cuidando que ninguno se pase de 12. P.ej.
Main> subirHabilidad 2 [3,6,9,10,11,12]
[5,8,11,12,12,12]
-}