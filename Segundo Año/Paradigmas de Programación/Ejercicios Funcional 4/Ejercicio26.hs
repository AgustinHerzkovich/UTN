lluviasEnero :: [Int]
lluviasEnero = [0, 2, 5, 1, 34, 2, 0, 21, 0, 0, 0, 5, 9, 18, 4, 0]

rachasLluvia :: [Int] -> [Int]
rachasLluvia  = dropWhile (==0) 

{-
Se tiene información de las lluvias en un determinado mes por Ej: se conoce la siguiente información: 
lluviasEnero = [0,2,5,1,34,2,0,21,0,0,0,5,9,18,4,0]
(muy difícil) Definir la función rachasLluvia/1, que devuelve una lista de las listas de los días seguidos que llovió. P.ej. se espera que la consulta 
Main> rachasLluvia lluviasEnero 
[[2,5,1,34,2],[21],[5,9,18,4]]. 
A partir de esta definir mayorRachaDeLluvias/1, que devuelve la cantidad máxima de días seguidos que llovió. P.ej. se espera que la consulta mayorRachaDeLluvias lluviasEnero devuelva 5. 
Ayuda: ver las funciones dropWhile y takeWhile, probar p.ej. esto:
takeWhile even [2,4,7,10,14,15]
dropWhile even [2,4,7,10,14,15]
-}