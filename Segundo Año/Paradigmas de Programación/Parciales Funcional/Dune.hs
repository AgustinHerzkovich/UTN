{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use zipWith" #-}
--------------
-- Punto 01 --
--------------
data Fremen = Fremen
  { nombre :: String,
    toleranciaAEspecia :: Float,
    titulos :: [String],
    cantidadReconocimientos :: Int
  }
  deriving (Show, Eq)

type Tribu = [Fremen]

stilgar :: Fremen
stilgar = Fremen "Stilgar" 150 ["Guía"] 3

-- a --
recibirReconocimiento :: Int -> Fremen -> Fremen
recibirReconocimiento cantidad unFremen = unFremen {cantidadReconocimientos = cantidadReconocimientos unFremen + cantidad}

-- b --
hayAlgunElegido :: Tribu -> Bool
hayAlgunElegido = any (\unFremen -> tieneTitulo "Domador" unFremen && toleranciaAEspecia unFremen > 100)

tieneTitulo :: String -> Fremen -> Bool
tieneTitulo unTitulo = elem unTitulo . titulos

-- c --
elElegido :: Tribu -> Fremen
elElegido = maximoSegun cantidadReconocimientos

maximoSegun :: (Ord b) => (a -> b) -> [a] -> a
maximoSegun _ [x] = x
maximoSegun f (x : y : ys)
  | f x > f y = maximoSegun f (x : ys)
  | otherwise = maximoSegun f (y : ys)

--------------
-- Punto 02 --
--------------
data Gusano = Gusano
  { longitud :: Float,
    nivelHidratacion :: Int,
    descripcion :: String
  }
  deriving (Show)

reproducir :: Gusano -> Gusano -> Gusano
reproducir unGusano otroGusano = Gusano (0.1 * max (longitud unGusano) (longitud otroGusano)) 0 (descripcion unGusano ++ " - " ++ descripcion otroGusano)

criasApareadas :: [Gusano] -> [Gusano] -> [Gusano]
criasApareadas unosGusanos = map (uncurry reproducir) . zip unosGusanos

--------------
-- Punto 03 --
--------------
aumentarTolerancia :: Float -> Fremen -> Fremen
aumentarTolerancia nivelAumento unFremen = unFremen {toleranciaAEspecia = nivelAumento + toleranciaAEspecia unFremen}

obtenerTitulo :: String -> Fremen -> Fremen
obtenerTitulo unTitulo unFremen = unFremen {titulos = unTitulo : titulos unFremen}

type Mision = Gusano -> Fremen -> Fremen

domarGusanoDeArena :: Mision
domarGusanoDeArena unGusano unFremen
  | toleranciaAEspecia unFremen >= longitud unGusano / 2 = aumentarTolerancia 100 . obtenerTitulo "Domador" $ unFremen
  | otherwise = aumentarTolerancia (-(toleranciaAEspecia unFremen * 0.1)) unFremen

destruirGusanoDeArena :: Mision
destruirGusanoDeArena unGusano unFremen
  | tieneTitulo "Domador" unFremen && toleranciaAEspecia unFremen < longitud unGusano / 2 = aumentarTolerancia 100 . recibirReconocimiento 1 $ unFremen
  | otherwise = aumentarTolerancia (-(toleranciaAEspecia unFremen * 0.2)) unFremen

despistarGusanoDeArena :: Mision
despistarGusanoDeArena unGusano unFremen
  | tieneTitulo "Guía" unFremen || ((> 3) . length . titulos) unFremen = obtenerTitulo "Sigiloso" . aumentarTolerancia 50 $ unFremen
  | otherwise = aumentarTolerancia (-(toleranciaAEspecia unFremen * 0.5)) unFremen

misionColectiva :: Mision -> Gusano -> Tribu -> Tribu
misionColectiva unaMision unGusano = map (unaMision unGusano)

resultaUnElegidoDiferente :: Mision -> Gusano -> Tribu -> Bool
resultaUnElegidoDiferente unaMision unGusano unaTribu = elElegido unaTribu /= elegidoTrasMision
  where
    elegidoTrasMision = (elElegido . misionColectiva unaMision unGusano) unaTribu

--------------
-- Punto 04 --
--------------
-- a --
{-
Al entrenar una tribu con infinitos Fremen, el resultado se comenzará a imprimir, pero no se llegará a visualizar
nunca por completo, ya que deberían imprimirse los infinitos Fremen resultantes luego de la misión.
-}
-- ghci> misionColectiva destruirGusanoDeArena (Gusano 10 5 "rojo con lunares") (repeat stilgar)
-- Resultado infinito

-- b --
{-
Al querer saber si hay algún candidato a ser elegido, en caso de que no haya ninguno, nunca podrá saberse, ya que la función "any"
recorrería infinitamente la lista y nunca lograría converger a su caso base. En caso de que haya algún candidato, lo retorna ya que el any termina
cuando encuentra uno que cumple la condición, y gracias a la evaluación diferida, no precisa seguir recorriendo la lista.
-}
-- Ejemplo de False
-- ghci> hayAlgunElegido (repeat stilgar)
--
-- Ejemplo de True
-- ghci> hayAlgunElegido . repeat $ (Fremen "fremen" 200 ["Domador"] 4)
-- True

-- c --
{-
El elegido nunca podrá determinarse, ya que para ello debe aplicarse la función "maximoSegun" para determinar
quién es el que tiene más cantidad de reconocimientos, al aplicar esta función con una lista infinita nunca
se podría determinar un resultado, ya que esta converge en su caso base cuando la lista tiene un sólo elemento, lo cual
sería imposible para el caso que estamos evaluando, por ende, no determina un resultado.
-}
-- ghci> elElegido (repeat stilgar)
--
