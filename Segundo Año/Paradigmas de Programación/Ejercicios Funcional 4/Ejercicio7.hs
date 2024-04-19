
{-
Definir la función aplicarPar/2, que recibe una función y un par, 
y devuelve el par que resulta de aplicar la función a los elementos 
del par. P.ej. 
Main> aplicarPar doble (3,12) 
(6,24) 

Main> aplicarPar even (3,12) 
(False, True) 

Main> aplicarPar (even . doble) (3,12) 
(True, True) 
-}