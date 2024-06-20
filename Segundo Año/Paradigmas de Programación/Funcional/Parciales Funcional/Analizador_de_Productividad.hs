import Data.List (maximumBy)

type RespuestasDiarias = (Empleado, Integer, Integer)

type Empleado = String

correos :: Integer -> [RespuestasDiarias]

nombre :: RespuestasDiarias -> Empleado
nombre (a, _, _) = a

dia :: RespuestasDiarias -> Integer
dia (_, b, _) = b

cantidadRespuestas :: RespuestasDiarias -> Integer
cantidadRespuestas (_, _, c) = c

concat :: (Foldable t) => t [a] -> [a]
concat = foldr (++) []

sinRepetidos :: (Foldable t, Eq a) => t a -> [a]
sinRepetidos = foldr agregarSiNoEsta []

--------------
-- Punto 01 --
--------------
agregarSiNoEsta :: (Eq a) => a -> [a] -> [a]
agregarSiNoEsta unElemento unaLista
  | unElemento `elem` unaLista = unaLista
  | otherwise = unElemento : unaLista

--------------
-- Punto 02 --
--------------
type Criterio = RespuestasDiarias -> Bool

respuestasQueCumplan :: Criterio -> Integer -> [RespuestasDiarias]
respuestasQueCumplan unCriterio = filter unCriterio . correos

-- a --
respuestasDelDia :: Integer -> Integer -> [RespuestasDiarias]
respuestasDelDia unDia = respuestasQueCumplan ((== unDia) . dia)

-- b --
respuestasDe :: Empleado -> Integer -> [RespuestasDiarias]
respuestasDe unEmpleado = respuestasQueCumplan ((== unEmpleado) . nombre)

-- c --
superanMinimo :: Integer -> Integer -> [RespuestasDiarias]
superanMinimo unNumero = respuestasQueCumplan ((> unNumero) . cantidadRespuestas)

--------------
-- Punto 03 --
--------------
totalRespuestasDe :: Empleado -> Integer -> Int
totalRespuestasDe unEmpleado = sum . map cantidadRespuestas . respuestasDe unEmpleado

--------------
-- Punto 04 --
--------------
empleadosEntre :: Integer -> Integer -> [Empleado]
empleadosEntre mes1 mes2 = sinRepetidos . map nombre . concatMap correos $ [mes1 .. mes2]

--------------
-- Punto 05 --
--------------
type Bono = (ObjetivoProductividad, Int)

type ObjetivoProductividad = Empleado -> Bool

aplicarBonosAEmpleado :: [Bono] -> Empleado -> (Empleado, Int)
aplicarBonosAEmpleado bonos unEmpleado = (unEmpleado, sum [monto | (objetivo, monto) <- bonos, objetivo unEmpleado])

trabajoTodoElAnio :: Empleado -> Bool
trabajoTodoElAnio empleado = all ((/= []) . respuestasDe empleado) [1 .. 12]

montosAPagar :: [Bono] -> [(Empleado, Int)]
montosAPagar bonos = (map (aplicarBonosAEmpleado bonos) . filter trabajoTodoElAnio) (empleadosEntre 1 12)

-- i --
productividadCreciente :: ObjetivoProductividad
productividadCreciente unEmpleado = tieneOrdenCreciente . map totalRespuestasDe unEmpleado $ [1 .. 12]

tieneOrdenCreciente :: (Ord a) => [a] -> Bool
tieneOrdenCreciente [_] = True
tieneOrdenCreciente (x : y : ys) = x <= y && tieneOrdenCreciente y ys

-- ii --
fueEmpleadoDelMes :: ObjetivoProductividad
fueEmpleadoDelMes unEmpleado = elem unEmpleado . map empleadoDelMes $ [1 .. 12]

empleadoDelMes :: Integer -> Empleado
empleadoDelMes = nombre . maximumBy cantidadRespuestas . correos

-- iii --
buenaPerformance :: Integer -> ObjetivoProductividad
buenaPerformance minimoRespuestas unEmpleado = all (all ((>= minimoRespuestas) . cantidadRespuestas) . respuestasDe unEmpleado) $ [1 .. 12]

--------------
-- Punto 06 --
--------------
f :: (Foldable t) => Int -> (Int -> t a -> [Char]) -> [t a] -> Bool
f a b = any ((== 'h') . head . b a) . filter ((> a) . length)

-- Razonamiento
{-
f a b c = any ((== 'h') . head . b a) . filter ((> a) . length) $ c

"c" es una lista que se puede mapear con la función length, por lo tanto
c :: Foldable t => [t a]

Se filtra la lista por aquellos elementos que tienen tamaño mayor a "a", por ende
a :: Int

b a es una función que se aplica a los elementos de la lista "c" para luego corroborar
que la cabeza tras ser aplicada a esta función, es == 'h'.
De aquí se deduce que b :: (Int -> t a -> [Char])

El resultado de la función es Bool debido al any
-}