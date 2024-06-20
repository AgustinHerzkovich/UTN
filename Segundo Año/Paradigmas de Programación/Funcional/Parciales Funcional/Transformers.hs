import Text.Show.Functions ()

data Autobot
  = Robot
      { nombreR :: String,
        capacidadesR :: CapacidadesRobot,
        transformacion :: Transformacion
      }
  | Vehiculo
      { nombreV :: String,
        capacidadesV :: CapacidadesAuto
      }
  deriving (Show)

type CapacidadesRobot = (Int, Int, Int)

type CapacidadesAuto = (Int, Int)

type Transformacion = CapacidadesRobot -> CapacidadesAuto

fuerza :: CapacidadesRobot -> Int
fuerza (f, _, _) = f

velocidad1 :: CapacidadesRobot -> Int
velocidad1 (_, v, _) = v

resistencia1 :: CapacidadesRobot -> Int
resistencia1 (_, _, r) = r

velocidad2 :: CapacidadesAuto -> Int
velocidad2 = fst

resistencia2 :: CapacidadesAuto -> Int
resistencia2 = snd

-- Ejemplos
optimus :: Autobot
optimus = Robot "Optimus Prime" (20, 20, 10) optimusTransformacion

optimusTransformacion :: Transformacion
optimusTransformacion (_, v, r) = (v * 5, r * 2)

jazz :: Autobot
jazz = Robot "Jazz" (8, 35, 3) jazzTransformacion

jazzTransformacion :: Transformacion
jazzTransformacion (_, v, r) = (v * 6, r * 3)

wheeljack :: Autobot
wheeljack = Robot "Wheeljack" (11, 30, 4) wheeljackTransformacion

wheeljackTransformacion :: Transformacion
wheeljackTransformacion (_, v, r) = (v * 4, r * 3)

bumblebee :: Autobot
bumblebee = Robot "Bumblebee" (10, 33, 5) bumblebeeTransformacion

bumblebeeTransformacion :: Transformacion
bumblebeeTransformacion (_, v, r) = (v * 4, r * 2)

autobots :: [Autobot]
autobots = [optimus, jazz, wheeljack, bumblebee]

---------------
--- Punto 1 ---
---------------
maximoSegun :: (Ord b) => (a -> a -> b) -> a -> a -> a
maximoSegun f x y
  | f x y >= f y x = x
  | otherwise = y

---------------
--- Punto 2 ---
---------------
fuerzaAutobot :: Autobot -> Int
fuerzaAutobot (Robot _ capacidadesR _) = fuerza capacidadesR
fuerzaAutobot (Vehiculo _ capacidadesV) = 0

velocidadAutobot :: Autobot -> Int
velocidadAutobot (Robot _ capacidadesR _) = velocidad1 capacidadesR
velocidadAutobot (Vehiculo _ capacidadesV) = velocidad2 capacidadesV

resistenciaAutobot :: Autobot -> Int
resistenciaAutobot (Robot _ capacidadesR _) = resistencia1 capacidadesR
resistenciaAutobot (Vehiculo _ capacidadesV) = resistencia2 capacidadesV

---------------
--- Punto 3 ---
---------------
transformar :: Autobot -> Autobot
transformar robot = Vehiculo (nombreR robot) . transformacion robot . capacidadesR $ robot

---------------
--- Punto 4 ---
---------------
velocidadContra :: Autobot -> Autobot -> Int
velocidadContra autobot1 autobot2 = velocidadAutobot autobot1 - max 0 (fuerzaAutobot autobot2 - resistenciaAutobot autobot1)

---------------
--- Punto 5 ---
---------------
elMasRapido :: Autobot -> Autobot -> Autobot
elMasRapido autobot1 autobot2
  | velocidadContra autobot1 autobot2 > velocidadContra autobot2 autobot1 = autobot1
  | otherwise = autobot2

---------------
--- Punto 6 ---
---------------
-- a .
domina :: Autobot -> Autobot -> Bool
domina = ganaEnTodasSusFormas

ganaEnTodasSusFormas :: Autobot -> Autobot -> Bool
ganaEnTodasSusFormas autobot1 autobot2 = gana autobot1 autobot2 && gana autobot1 (transformar autobot2) && gana (transformar autobot1) autobot2 && gana (transformar autobot1) (transformar autobot2)

gana :: Autobot -> Autobot -> Bool
gana (Robot nombre capacidades transformacion) = (== nombre) . nombreR . elMasRapido (Robot nombre capacidades transformacion)
gana (Vehiculo nombre capacidades) = (== nombre) . nombreV . elMasRapido (Vehiculo nombre capacidades)

-- b.
losDominaATodos :: Autobot -> [Autobot] -> Bool
losDominaATodos autobot1 = all (domina autobot1)

---------------
--- Punto 7 ---
---------------
-- a.
type Condicion = Autobot -> Bool

quienesCumplen :: Condicion -> [Autobot] -> [String]
quienesCumplen condicion = map nombreR . filter condicion

-- b.
esVocal :: Char -> Bool
esVocal = (`elem` "aeiouAEIOU")

nombreTerminaEnVocal :: Condicion
nombreTerminaEnVocal = esVocal . last . nombreR

-- Consulta
-- ghci> quienesCumplen ((`losDominaATodos` autobots) && nombreTerminaEnVocal) autobots
-- ghci>
---------------
--- Punto 8 ---
---------------

-- Razonamiento
saraza :: (Ord b) => a -> a -> a -> (a -> a -> b) -> b
saraza x y w z = z w . maximoSegun z y $ x

{-
saraza x y w z = z w . maximoSegun z y $ x

Recordemos el tipo de maximoSegun
maximoSegun :: (Ord b) => (a -> a -> b) -> a -> a -> a
por lo que z = (a -> a -> b) ; y = a ; x = a

El resultado de esto es de tipo a, y esto entra en la función w, y luego a z
z es de tipo (a -> a -> b), por lo que w es de tipo a por ser lo primero en aplicarse a z
entonces w = a, luego por la composición recibe el segundo a y termina devolviendo b

El resultado de la función saraza es de tipo b ya que z es lo último en aplicarse.
-}