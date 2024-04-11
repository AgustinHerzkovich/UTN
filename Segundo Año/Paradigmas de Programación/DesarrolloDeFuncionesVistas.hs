--odd
esImpar :: Integral a => a -> Bool
esImpar numero = mod numero 2 /= 0

--even
esPar :: Integral a => a -> Bool
esPar numero = mod numero 2 == 0

--id
identificacion :: a -> a
identificacion x = x

--const
constante :: a -> b -> a
constante x y = x

--null
nulo :: String -> Bool
nulo palabra = palabra == ""

--max
maximo :: Ord a => a -> a -> a
maximo x y
    | x > y = x
    | y > x = y
    | otherwise = x

--min
minimo :: Ord a => a -> a -> a
minimo x y 
    | x > y = y
    | y > x = x
    | otherwise = x

--($)
peso :: (a -> b) -> a -> b
peso x = x 

--mod
resto :: Integral a => a -> a -> a
resto dividendo divisor = dividendo - divisor * div dividendo divisor

--div
divisionEntera :: Integral a => a -> a -> a
divisionEntera x y = fromInteger (toInteger x `Prelude.quot` toInteger y)