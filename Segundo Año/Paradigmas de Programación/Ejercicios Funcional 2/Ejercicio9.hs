cuadrado :: Num a => a -> a
cuadrado = (^2)

incrementMCuadradoN :: Num a => a -> a -> a
incrementMCuadradoN m  = (+m) . cuadrado

{-
Definir una función incrementMCuadradoN, que invocándola con 2 números m y n, incrementa un valor m al cuadrado de n
Nota: Resolverlo utilizando aplicación parcial y composición
-}