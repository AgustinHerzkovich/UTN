import Data.List (isPrefixOf, maximumBy)
import Data.Ord (comparing)

data Ladron = Ladron
  { nombreL :: String,
    habilidades :: [Habilidad],
    armas :: [Arma]
  }

data Rehen = Rehen
  { nombreR :: String,
    nivelComplot :: Int,
    nivelMiedo :: Int,
    plan :: Plan
  }

type Arma = Rehen -> Rehen

type Habilidad = String

type FormaDeIntimidacion = Ladron -> Rehen -> Rehen

type Plan = Ladron -> Ladron

-- Funciones auxiliares
modificarMiedo :: Int -> Rehen -> Rehen
modificarMiedo cantidad unRehen = unRehen {nivelMiedo = nivelMiedo unRehen + cantidad}

modificarComplot :: Int -> Rehen -> Rehen
modificarComplot cantidad unRehen = unRehen {nivelComplot = nivelComplot unRehen + cantidad}

disparar :: Arma -> Ladron -> Rehen -> Rehen
disparar unArma unLadron unRehen = modificarMiedo (nivelMiedo . unArma $ unRehen) unRehen

armaMasTemida :: Rehen -> [Arma] -> Arma
armaMasTemida unRehen = maximumBy (comparing (`miedoQueProvoca` unRehen))

miedoQueProvoca :: Arma -> Rehen -> Int
miedoQueProvoca unArma = nivelMiedo . unArma

quitarArmas :: Int -> Ladron -> Ladron
quitarArmas cantidad unLadron = unLadron {armas = drop cantidad . armas $ unLadron}

-- Armas
pistola :: Int -> Arma
pistola calibre unRehen = modificarMiedo ((* 3) . length . nombreR $ unRehen) . modificarComplot ((-5) * calibre) $ unRehen

ametralladora :: Int -> Arma
ametralladora balas unRehen = modificarMiedo balas . modificarComplot ((-1) * nivelComplot unRehen `div` 2) $ unRehen

armasTotales :: [Arma]
armasTotales = map pistola [1 .. 100] ++ map ametralladora [1 .. 100]

-- Métodos de intimidación
disparos :: FormaDeIntimidacion
disparos unLadron unRehen = disparar (armaMasTemida unRehen armasTotales) unLadron unRehen

hacerseElMalo :: FormaDeIntimidacion
hacerseElMalo unLadron unRehen
  | nombreL unLadron == "Berlín" = modificarMiedo (sum . map length . habilidades $ unLadron) unRehen
  | nombreL unLadron == "Río" = modificarComplot 20 unRehen
  | otherwise = modificarMiedo 10 unRehen

-- Planes
atacarAlLadronCon :: Rehen -> Plan
atacarAlLadronCon companiero = quitarArmas (length . nombreR $ companiero)

esconderse :: Plan
esconderse unLadron = quitarArmas ((`div` 3) . length . habilidades $ unLadron) unLadron

---------------
--- Punto 1 ---
---------------
-- a.
tokio :: Ladron
tokio = Ladron "Tokio" ["trabajo psicológico", "entrar en moto"] [pistola 9, pistola 9, ametralladora 30]

-- b.
profesor :: Ladron
profesor = Ladron "Profesor" ["disfrazarse de linyera", "disfrazarse de payaso", "estar siempre un paso adelante"] []

-- c.
pablo :: Rehen
pablo = Rehen "Pablo" 40 30 esconderse

-- d.
arturito :: Rehen
arturito = Rehen "Arturito" 70 50 (atacarAlLadronCon pablo . esconderse)

---------------
--- Punto 2 ---
---------------
esInteligente :: Ladron -> Bool
esInteligente = (> 2) . length . habilidades

---------------
--- Punto 3 ---
---------------
conseguirArma :: Arma -> Ladron -> Ladron
conseguirArma unArma unLadron = unLadron {armas = unArma : armas unLadron}

---------------
--- Punto 4 ---
---------------
intimidar :: FormaDeIntimidacion -> Ladron -> Rehen -> Rehen
intimidar unMetodo = unMetodo

---------------
--- Punto 5 ---
---------------
calmarLasAguas :: Ladron -> [Rehen] -> [Rehen]
calmarLasAguas _ = map calmar

calmar :: Rehen -> Rehen
calmar unRehen
  | nivelComplot unRehen > 60 = modificarMiedo ((-1) * nivelMiedo unRehen) unRehen
  | otherwise = unRehen

---------------
--- Punto 6 ---
---------------
puedeEscaparse :: Ladron -> Bool
puedeEscaparse = any (empiezaCon "disfrazarse de") . habilidades

empiezaCon :: String -> String -> Bool
empiezaCon = isPrefixOf

---------------
--- Punto 7 ---
---------------
laCosaPintaMal :: [Ladron] -> [Rehen] -> Bool
laCosaPintaMal ladrones rehenes = promedio nivelComplot rehenes > promedio nivelMiedo rehenes * cantidadArmas ladrones

promedio :: (Rehen -> Int) -> [Rehen] -> Int
promedio factor rehenes = (`div` length rehenes) . sum . map factor $ rehenes

cantidadArmas :: [Ladron] -> Int
cantidadArmas = length . concatMap armas

---------------
--- Punto 8 ---
---------------
rebelarse :: [Rehen] -> Ladron -> Ladron
rebelarse rehenes unLadron = foldl (flip plan) unLadron (map (modificarComplot (-10)) rehenes)

---------------
--- Punto 9 ---
---------------
planValencia :: [Rehen] -> [Ladron] -> Int
planValencia rehenes ladrones = 1000000 * cantidadArmas ladronesFinales
  where
    ladronesFinales = map (rebelarse rehenes . conseguirArma (ametralladora 45)) ladrones

--------------
-- Punto 10 --
--------------
{-
No puede ejecutarse ya que no se podrá determinar nunca la cantidad de armas totales, lo que requiere
utilizar la función length sobre la lista de armas, pero si esta es infinita, length no retornará nunca un resultado.
-}
--------------
-- Punto 11 --
--------------
{-
En este caso depende del plan de los rehenes, por ejemplo, si algún rehén tiene un plan que requiere recorrer
la lista completa de habilidades del ladrón (como lo es esconderse), entonces el planValencia no retorna nada
y se queda procesando infinitamente. En cambio, si los rehenes que ejecutan el planValencia no tienen ningún plan
que requiera recorrer toda la lista de habilidades del ladrón, la función arroja un resultado.
-}
--------------
-- Punto 12 --
--------------
funcion :: b -> ([a] -> [c]) -> (b -> [a] -> Bool) -> Int -> [[a]] -> Bool
funcion cond num lista str = (> str) . sum . map (length . num) . filter (lista cond)

-- Razonamiento
{-
funcion cond num lista str lista2= (> str) . sum . map (length . num) . filter (lista cond) $ lista2

Primero se filtra lista2 con la condición (lista cond), osea que suponiendo que lista2 = [a],
entonces (lista cond) = (a -> Bool), por lo que podemos decir que lista = (b -> a -> Bool) y cond = b
El resultado de este filtrado es [a], lo que luego recibe como último parámetro el map (length . num).

Debido a que el map aplica la función length, deduzco que la lista que se recibe, o bien es una lista de listas, o
se transforma en ella al aplicar la función num. Voy a suponer que lista2 = [[a]], en ese caso
(lista cond) = ([a] -> Bool), es decir que cond = b y lista = (b -> [a] -> Bool)

Luego se mapea [[a]] con (length . num), supongamos que num = ([a] -> [c]), entonces tiene sentido
mapear con num y luego con length. para luego aplicar sum sobre la lista de tamaños y obtener la suma de todos ellos.

Por último se quiere saber si la suma de los tamaños es mayor a str, con lo cual str es Int.
La función final retorna Bool, debido al operador mayor.
-}
