data Investigador = Investigador{
    nombre :: String,
    cordura :: Int,
    items :: [Item],
    sucesosEvitados :: [String]
} deriving (Show, Eq)

data Item = Item{
    nombreItem :: String,
    valor :: Int
} deriving (Show, Eq)

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
    | f a > f b = a
    | otherwise = b


deltaSegun :: Num a => (b -> a) -> (b -> b) -> b -> a
deltaSegun ponderacion transformacion valor = abs ((ponderacion . transformacion) valor - ponderacion valor)

--------------
-- Punto 01 --
--------------
-- a --
enloquecer :: Int -> Investigador -> Investigador
enloquecer puntos unInvestigador = unInvestigador {cordura = max 0 (cordura unInvestigador - puntos)}

-- b --
hallarItem :: Item -> Investigador -> Investigador
hallarItem unItem = enloquecer (valor unItem) . agregarItem unItem

agregarItem :: Item -> Investigador -> Investigador
agregarItem unItem unInvestigador = unInvestigador{items = unItem : items unInvestigador}
--------------
-- Punto 02 --
--------------
algunoTieneItem :: Item -> [Investigador] -> Bool
algunoTieneItem unItem = any (tieneItem unItem)

tieneItem :: Item -> Investigador -> Bool
tieneItem unItem = elem unItem . items
--------------
-- Punto 03 --
--------------
lider :: [Investigador] -> Investigador
lider = maximoSegun potencial

potencial :: Investigador -> Int
potencial unInvestigador
    | estaTotalmenteLoco unInvestigador = 0
    | otherwise = cordura unInvestigador * experiencia unInvestigador + valorMaximo (items unInvestigador)

estaTotalmenteLoco :: Investigador -> Bool
estaTotalmenteLoco  = (== 0) . cordura

experiencia :: Investigador -> Int
experiencia  = (+ 1) . (* 3) . length . sucesosEvitados

valorMaximo :: [Item] -> Int
valorMaximo  = valor . maximoSegun valor
--------------
-- Punto 04 --
--------------
-- a --
deltaCorduraTotal :: Int -> [Investigador] -> Int
deltaCorduraTotal puntos = deltaSegun corduraTotal (enloquecerTodos puntos)

corduraTotal :: [Investigador] -> Int
corduraTotal = sum . map cordura

enloquecerTodos :: Int -> [Investigador] -> [Investigador]
enloquecerTodos puntos = map (enloquecer puntos)

-- b --
deltaPotencialPrimerIntegrante :: [Investigador] -> Int
deltaPotencialPrimerIntegrante = deltaSegun potencialPrimerIntegrante perderIntegrantesLocos

potencialPrimerIntegrante :: [Investigador] -> Int
potencialPrimerIntegrante = potencial . head

perderIntegrantesLocos :: [Investigador] -> [Investigador]
perderIntegrantesLocos = filter (not . estaTotalmenteLoco)

-- c --
{-
Para la función del punto a no es posible conocer un resultado ya que se requeriría la cordura de todos
los investigadores, es decir un map de cordura sobre la lista infinita, y esto nunca llegará a realizarse ya que
el map converge en su caso base cuando la lista es vacía, lo cual no ocurre en este caso.

Para la función del punto b sí es posible conocer un resultado ya que el delta que estamos evaluando es sobre
el primer integrante únicamente, y si bien se realiza un filter sobre la lista infinita, esta no se evalúa por completo,
por lo que no es necesario que el filter termine para hallar el delta del primer integrante, producto de la evaluación diferida.
-}
--------------
-- Punto 05 --
--------------
data Suceso = Suceso{
    descripcion :: String,
    consecuencias :: [Consecuencia],
    formasDeEvitar :: [FormaDeEvitar]
}

type Consecuencia = [Investigador] -> [Investigador]
type FormaDeEvitar = [Investigador] -> Bool

-- Ejemplo 1
despertar :: Suceso
despertar = Suceso "Despertar de un antiguo" [enloquecerTodos 10, perderPrimerIntegrante] [any (tieneItem necronomicon)]

perderPrimerIntegrante :: [Investigador] -> [Investigador]
perderPrimerIntegrante = drop 1

necronomicon :: Item
necronomicon = Item "Necronomicón" 100

-- Ejemplo 2
ritual :: Suceso
ritual = Suceso "Ritual en Innsmouth" [aplicarAlPrimero (hallarItem dagaMaldita) ,enloquecerTodos 2,enfrentar despertar] [(>100) . potencial . lider]

dagaMaldita :: Item
dagaMaldita = Item "Daga maldita" 3

aplicarAlPrimero :: (a -> a) -> [a] -> [a]
aplicarAlPrimero f xs = (f . head $ xs) : drop 1 xs
--------------
-- Punto 06 --
--------------
enfrentar :: Suceso -> [Investigador] -> [Investigador]
enfrentar unSuceso unGrupo
    | puedenEvitar unSuceso unGrupo = incorporanSuceso unSuceso . enloquecerTodos 1 $ unGrupo
    | otherwise = sufrirConsecuencias unSuceso . enloquecerTodos 1 $ unGrupo

puedenEvitar :: Suceso -> [Investigador] -> Bool
puedenEvitar unSuceso unGrupo = all ($ unGrupo) . formasDeEvitar $ unSuceso

incorporanSuceso :: Suceso -> [Investigador] -> [Investigador]
incorporanSuceso unSuceso  = map (incorporarSuceso unSuceso)

incorporarSuceso :: Suceso -> Investigador -> Investigador
incorporarSuceso unSuceso unInvestigador = unInvestigador{sucesosEvitados = descripcion unSuceso : sucesosEvitados unInvestigador}

sufrirConsecuencias :: Suceso -> [Investigador] -> [Investigador]
sufrirConsecuencias unSuceso unGrupo = foldl sufrirConsecuencia unGrupo (consecuencias unSuceso)

sufrirConsecuencia :: [Investigador] -> Consecuencia -> [Investigador]
sufrirConsecuencia = flip ($)

--------------
-- Punto 07 --
--------------
sucesoMasAterrador :: [Suceso] -> [Investigador] -> Suceso
sucesoMasAterrador unosSucesos unGrupo =  maximoSegun (deltaTrasSuceso unGrupo) unosSucesos

deltaTrasSuceso :: [Investigador] -> Suceso -> Int
deltaTrasSuceso unGrupo unSuceso = deltaSegun corduraTotal (enfrentar unSuceso) unGrupo