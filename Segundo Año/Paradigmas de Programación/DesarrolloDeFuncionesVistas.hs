{-FUNCIONES DESARROLLADAS DE HASKELL
by Tadeo Sorrentino && Agustín Herzkovich
2024
-}
import Data.List
import Data.Text.Encoding (validateUtf8More)
import System.Win32 (xBUTTON1)
import Text.Show.Functions

-- odd
esImpar :: (Integral a) => a -> Bool
esImpar numero = mod numero 2 /= 0

-- even
esPar :: (Integral a) => a -> Bool
esPar numero = mod numero 2 == 0

-- id
identificacion :: a -> a
identificacion x = x

-- const
constante :: a -> b -> a
constante x y = x

-- null
nulo :: String -> Bool
nulo palabra = palabra == ""

-- max
maximo :: (Ord a) => a -> a -> a
maximo x y
  | x > y = x
  | y > x = y
  | otherwise = x

-- min
minimo :: (Ord a) => a -> a -> a
minimo x y
  | x > y = y
  | y > x = x
  | otherwise = x

-- ($)
peso :: (a -> b) -> a -> b
peso x = x

-- mod
resto :: (Integral a) => a -> a -> a
resto dividendo divisor = dividendo - divisor * div dividendo divisor

-- div
divisionEntera :: (Integral a) => a -> a -> a
divisionEntera x y = fromInteger (toInteger x `Prelude.quot` toInteger y)

-- lista de prueba
listaAux :: [Integer]
listaAux = [1 .. 5]

-- flip
voltear :: (a -> b -> c) -> b -> a -> c
voltear f x y = f y x

-- abs
modulo :: (Ord a, Num a) => a -> a
modulo x
  | x >= 0 = x
  | x < 0 = -x

-- signum
signo :: (Ord a1, Num a1, Num a2) => a1 -> a2
signo 0 = 0
signo x
  | x > 0 = 1
  | x < 0 = -1

-- length
cantidadDeElementos :: [a] -> Int
cantidadDeElementos = contadorAuxiliar 0

contadorAuxiliar :: (Num t) => t -> [a] -> t
contadorAuxiliar acumulador lista
  | null lista = acumulador
  | otherwise = contadorAuxiliar (acumulador + 1) (tail lista)

-- head
primerElemento :: [a] -> a
primerElemento = (!! 0)

-- last
ultimoElemento :: [a] -> a
ultimoElemento lista = ((lista !!) . anterior . length) lista

anterior :: (Num a) => a -> a
anterior num = num - 1

-- tail
eliminarPrimerElemento :: [a] -> [a]
eliminarPrimerElemento (x : xs) = xs

-- null
esVacia :: [a] -> Bool
esVacia = (0 ==) . length

-- ++
concatenacionSimple :: [a] -> [a] -> [a]
concatenacionSimple = agregarRecursiva

agregarRecursiva :: [a] -> [a] -> [a]
agregarRecursiva lista1 lista2
  | null lista1 = reverse lista2
  | otherwise = agregarRecursiva (tail lista1) (head lista1 : lista2)

-- reverse
invertirLista :: [a] -> [a]
invertirLista lista = agregarRecursiva lista []

-- sum
sumatoria :: (Num t) => [t] -> t
sumatoria lista = operar (+) lista 0

-- product
producto :: (Num t) => [t] -> t
producto lista = operar (*) lista 1

operar :: (Num t) => (t -> t -> t) -> [t] -> t -> t
operar operador lista numero
  | null lista = numero
  | otherwise = operar operador (tail lista) (operador numero (head lista))

listaNatural :: Integer -> [Integer]
listaNatural val = [1 .. val]

factorial :: Integer -> Integer
factorial = producto . listaNatural

-- elem
perteneceA :: (Foldable ((->) p), Eq p) => p -> (Bool -> Bool) -> Bool
perteneceA elemento lista = lista `any` (== elemento)

-- !!
posicionLista :: [a] -> Int -> a
posicionLista = recorrerHasta

recorrerHasta :: [a] -> Int -> a
recorrerHasta lista indice
  | ((+ 1) . length) lista == indice = head lista
  | otherwise = recorrerHasta ((tail . reverse) lista) indice

-- filter
filtrar :: (a -> Bool) -> [a] -> [a]
filtrar criterio lista = agregarConCriterio criterio lista []

agregarConCriterio :: (a -> Bool) -> [a] -> [a] -> [a]
agregarConCriterio criterio lista1 lista2
  | null lista1 = reverse lista2
  | (criterio . head) lista1 = agregarConCriterio criterio (tail lista1) (head lista1 : lista2)
  | otherwise = agregarConCriterio criterio (tail lista1) lista2

-- map
mapa :: (a -> b) -> [a] -> [b]
mapa transformacion lista = transformacionRecursiva transformacion lista []

transformacionRecursiva :: (a -> b) -> [a] -> [b] -> [b]
transformacionRecursiva transformacion entrada salida
  | null entrada = reverse salida
  | otherwise = transformacionRecursiva transformacion (tail entrada) ((transformacion . head) entrada : salida)

-- all
todosCumplen :: (Eq a) => (a -> Bool) -> [a] -> Bool
todosCumplen criterio lista = filter criterio lista == lista

-- any
algunoCumple :: (Eq a) => (a -> Bool) -> [a] -> Bool
algunoCumple criterio = not . null . filter criterio

-- drop
quitarPrimerosN :: Int -> [a] -> [a]
quitarPrimerosN n [] = []
quitarPrimerosN n lista
  | tamaño == n + 1 = lista
  | otherwise = quitarPrimerosN n (tail lista)
  where
    tamaño = length lista

-- take
tomar :: Int -> [a] -> [a]
tomar n lista = extraerLosNPrimeros n lista []

extraerLosNPrimeros :: Int -> [a] -> [a] -> [a]
extraerLosNPrimeros n [] [] = []
extraerLosNPrimeros n lista1 lista2
  | tamaño == n + 1 = reverse lista2
  | otherwise = extraerLosNPrimeros n (tail lista1) (head lista1 : lista2)
  where
    tamaño = length lista1

-- concat
concatenacionDoble :: [[a]] -> [a]
concatenacionDoble listaDeListas = compresor listaDeListas []

compresor :: [[a]] -> [a] -> [a]
compresor [[]] [] = []
compresor listaDeListas listaCompacta
  | null listaDeListas = listaCompacta
  | otherwise = compresor (tail listaDeListas) ((reverse . head) listaDeListas `concatenacionSimple` listaCompacta)

-- maximum
maximo2 :: (Num a, Ord a) => [a] -> a
maximo2 lista = piola lista (head lista) (>)

-- minimum
minimo2 :: (Num a, Ord a) => [a] -> a
minimo2 lista = piola lista (head lista) (<)

piola :: (Num a, Ord a) => [a] -> a -> (a -> a -> Bool) -> a
piola lista valor operador
  | null lista = valor
  | head lista `operador` valor = piola (tail lista) (head lista) (operador)
  | otherwise = piola (tail lista) valor (operador)

-- takeWhile
tomarMientras :: (a -> Bool) -> [a] -> [a]
tomarMientras condicion lista = avanzar condicion lista []

avanzar :: (a -> Bool) -> [a] -> [a] -> [a]
avanzar condicion lista1 lista2
  | (condicion.head) lista1 = avanzar condicion (tail lista1) (head lista1 : lista2)
  | otherwise = reverse lista2

--dropWhile
quitarMientras :: (a -> Bool) -> [a] -> [a]
quitarMientras condicion lista
  | (condicion.head) lista = quitarMientras condicion (tail lista)
  | otherwise = lista

-- fst
primero :: (a, b) -> a
primero (x, _) = x

-- snd
segundo :: (a, b) -> b
segundo (_, y) = y