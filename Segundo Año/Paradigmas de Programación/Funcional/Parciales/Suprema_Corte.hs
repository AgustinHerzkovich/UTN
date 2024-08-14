import Data.List (intersect, isInfixOf)

-- Las leyes
data Ley = Ley
  { tema :: String,
    presupuesto :: Int,
    impulsores :: [Partido]
  }
  deriving (Eq)

type Partido = String

leyCannabis :: Ley
leyCannabis = Ley "Ley de uso medicinal del cannabis" 5 ["cambio de todos", "sector financiero"]

leyEdudacion :: Ley
leyEdudacion = Ley "Ley de educación superior" 30 ["docentes universitarios", "partido central federal"]

leyTenisProfesional :: Ley
leyTenisProfesional = Ley "Ley de profesionalización del tenista de mesa" 1 ["partido central federal", "liga de deportistas autónomos", "club paleta veloz"]

leyTenis :: Ley
leyTenis = Ley "Ley sobre tenis" 2 ["liga de deportistas autónomos"]

--------------
-- Punto 01 --
--------------
sonCompatibles :: Ley -> Ley -> Bool
sonCompatibles unaLey otraLey = (not . null . intersect (impulsores unaLey) . impulsores) otraLey || isInfixOf (tema unaLey) (tema otraLey) || isInfixOf (tema otraLey) (tema unaLey)

-- Constitucionalidad de las leyes
type Juez = Ley -> Bool

type CorteSuprema = [Juez]

-- Ejemplo de agenda
agenda :: [String]
agenda = ["Ley de educación superior", "Ley sobre tenis"]

presupuestoMinimo :: Int -> Ley -> Bool
presupuestoMinimo n = (<= n) . presupuesto

laApoya :: Partido -> Ley -> Bool
laApoya unSector = elem unSector . impulsores

-- Jueces
juezOpinionPublica :: Juez
juezOpinionPublica = (`elem` agenda) . tema

juezFinanciero :: Juez
juezFinanciero = laApoya "sector financiero"

juezPreocupado :: Juez
juezPreocupado = presupuestoMinimo 10

juezTolerante :: Juez
juezTolerante = presupuestoMinimo 20

juezConservador :: Juez
juezConservador = laApoya "partido conservador"

--------------
-- Punto 01 --
--------------
esConstitucional :: CorteSuprema -> Ley -> Bool
esConstitucional unaCorte unaLey = esMayoria unaCorte . length . filter ($ unaLey) $ unaCorte

esMayoria :: [a] -> Int -> Bool
esMayoria unaLista = (>= length unaLista `div` 2)

--------------
-- Punto 02 --
--------------
-- a --
juezPositivo :: Juez
juezPositivo _ = True

-- b --
juezInventado :: Juez
juezInventado = sonCompatibles leyCannabis

-- c --
juezPreocupado' :: Juez
juezPreocupado' = presupuestoMinimo 30

--------------
-- Punto 03 --
--------------
cualesPodrianSerConstitucionales :: [Ley] -> CorteSuprema -> [Ley]
cualesPodrianSerConstitucionales leyes unaCorte = filter (esConstitucional nuevaCorte) . filter (esConstitucional unaCorte) $ leyes
  where
    nuevaCorte = juezPositivo : juezInventado : juezPreocupado' : unaCorte

-- Cuestión de principios
--------------
-- Punto 01 --
--------------
borocotizar :: CorteSuprema -> CorteSuprema
borocotizar = map (not .)

--------------
-- Punto 02 --
--------------
coincideConSector :: Juez -> Partido -> [Ley] -> Bool
coincideConSector unJuez unSector leyes = filter unJuez leyes == filter (laApoya unSector) leyes

{-
Si hay una ley con infinitos sectores, dependerá del tipo de juez si es declarad constitucional o no

juezOpinionPublica, juezPreocupado, juezTolerante, juezPositivo, juezTolerante' y juezInventado pueden votarla ya que en estos casos
dan igual los sectores de la ley, sus condiciones para votarla son independientes de sus impulsores.

juezFinanciero y juezConservador depende de si en la lista de sectores se encuentra el que ellos prefieren,
si el sector se encuentra, devuelve True y no evalúa el resto de la lista (evaluación perezosa), por lo que vota la ley.
Si el sector no se encuentra, nunca podrá determinarse, ya que requerirá recorrer la lista en su totalida para asegurarse de
que efectivamente el sector no se encuentra entre sus impulsores, y esto nunca podrá determinarse, por ende, no devuelve resultado.
-}