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
concatenacionSimple [] lista = lista
concatenacionSimple (x : xs) lista = x : concatenacionSimple xs lista

-- reverse
invertirLista :: [a] -> [a]
invertirLista [] = []
invertirLista (x : xs) = invertirLista xs ++ [x]

-- foldr
plegar :: (a -> b -> b) -> b -> [a] -> b
plegar _ neutro [] = neutro
plegar operacion neutro (x : xs) = x `operacion` plegar operacion neutro xs

-- sum
sumatoria :: (Num t) => [t] -> t
sumatoria = plegar (+) 0

-- product
producto :: (Num t) => [t] -> t
producto = plegar (*) 1

-- and
conjuncion :: [Bool] -> Bool
conjuncion = plegar (&&) True

-- or
disyuncion :: [Bool] -> Bool
disyuncion = plegar (||) False

-- concat
concatenacionDoble :: [[a]] -> [a]
concatenacionDoble = plegar (++) []

-- length
longitud :: [a] -> Int
longitud = plegar (\_ y -> 1 + y) 0

-- foldl
plegar2 :: (b -> a -> b) -> b -> [a] -> b
plegar2 _ neutro [] = neutro
plegar2 operacion neutro (x : xs) = plegar2 operacion (operacion neutro x) xs

-- elem
perteneceA :: (Eq a) => a -> [a] -> Bool
perteneceA elemento = any (== elemento)

-- !!
posicionLista :: [a] -> Int -> a
posicionLista lista indice
  | indice == 0 = head lista
  | otherwise = posicionLista (tail lista) (indice - 1)

-- filter
filtrar :: (a -> Bool) -> [a] -> [a]
filtrar _ [] = []
filtrar criterio (x : xs)
  | criterio x = x : filtrar criterio xs
  | otherwise = filtrar criterio xs

-- map
mapear :: (a -> b) -> [a] -> [b]
mapear _ [] = []
mapear funcion (x : xs) = funcion x : mapear funcion xs

-- all
todosCumplen :: (Eq a) => (a -> Bool) -> [a] -> Bool
todosCumplen _ [] = True
todosCumplen criterio lista = filter criterio lista == lista

-- any
algunoCumple :: (Eq a) => (a -> Bool) -> [a] -> Bool
algunoCumple _ [] = False
algunoCumple criterio lista = (not . null . filter criterio) lista

-- drop
dropear :: Int -> [a] -> [a]
dropear _ [] = []
dropear n lista
  | n <= 0 = [] 
  | length lista == n + 1 = lista
  | otherwise = dropear n (tail lista)

-- take
tomar :: Int -> [a] -> [a]
tomar _ [] = []
tomar n lista
  | n <= 0 = []
  | length lista == n = lista
  | otherwise = tomar n (init lista)

-- maximum
maximo2 :: (Num a, Ord a) => [a] -> a
maximo2 [] = error "Prelude.maximum: empty list"
maximo2 [x] = x
maximo2 (x : xs) = max x (maximo2 xs)

-- minimum
minimo2 :: (Num a, Ord a) => [a] -> a
minimo2 [] = error "Prelude.maximum: empty list"
minimo2 [x] = x
minimo2 (x : xs) = min x (minimo2 xs)

-- takeWhile
tomarMientras :: (a -> Bool) -> [a] -> [a]
tomarMientras _ [] = []
tomarMientras condicion (x : xs)
  | condicion x = x : tomarMientras condicion xs
  | otherwise = []

-- dropWhile
quitarMientras :: (a -> Bool) -> [a] -> [a]
quitarMientras _ [] = []
quitarMientras condicion (x : xs)
  | condicion x = quitarMientras condicion xs
  | otherwise = x : xs

-- fst
primero :: (a, b) -> a
primero (x, _) = x

-- snd
segundo :: (a, b) -> b
segundo (_, y) = y

-- groupBy
agruparPor :: (a -> a -> Bool) -> [a] -> [[a]]
agruparPor _ [] = []
agruparPor comparacion (x : xs) = (x : mismoGrupo) : agruparPor comparacion resto
  where
    (mismoGrupo, resto) = span (comparacion x) xs

-- zip
zipar :: [a] -> [b] -> [(a, b)]
zipar [] _ = []
zipar _ [] = []
zipar (x : xs) (y : ys) = (x, y) : zipar xs ys