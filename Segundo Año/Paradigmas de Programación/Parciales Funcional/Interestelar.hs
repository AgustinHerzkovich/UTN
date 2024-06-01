---------------
--- Dominio ---
---------------
data Planeta = UnPlaneta
  { nombreP :: String,
    posicion :: Posicion,
    tiempo :: Int -> Int
  }

type Posicion = (Float, Float, Float)

coordX :: Posicion -> Float
coordX (x, _, _) = x

coordY :: Posicion -> Float
coordY (_, y, _) = y

coordZ :: Posicion -> Float
coordZ (_, _, z) = z

data Astronauta = UnAstronauta
  { nombreA :: String,
    edad :: Int,
    planeta :: Planeta
  }

---------------
--- Punto 1 ---
---------------
-- a.
distanciaPlanetas :: Planeta -> Planeta -> Float
distanciaPlanetas planeta1 planeta2 = distancia (posicion planeta1) (posicion planeta2)

distancia :: Posicion -> Posicion -> Float
distancia p1 p2 = sqrt (distanciaX p1 p2 + distanciaY p1 p2 + distanciaZ p1 p2)

distanciaX :: Posicion -> Posicion -> Float
distanciaX p1 p2 = (coordX p1 - coordX p2) ^ 2

distanciaY :: Posicion -> Posicion -> Float
distanciaY p1 p2 = (coordY p1 - coordY p2) ^ 2

distanciaZ :: Posicion -> Posicion -> Float
distanciaZ p1 p2 = (coordZ p1 - coordZ p2) ^ 2

-- b.
tiempoViaje :: Int -> Planeta -> Planeta -> Int
tiempoViaje velocidad planeta1 = (`div` velocidad) . round . distanciaPlanetas planeta1

---------------
--- Punto 2 ---
---------------
pasarTiempo :: Int -> Astronauta -> Astronauta
pasarTiempo años unAstronauta = aumentarEdad unAstronauta . ($ años) . tiempo . planeta $ unAstronauta

aumentarEdad :: Astronauta -> Int -> Astronauta
aumentarEdad unAstronauta aumento = unAstronauta {edad = edad unAstronauta + aumento}

---------------
--- Punto 3 ---
---------------
type Nave = Planeta -> Planeta -> Int

-- a.
naveVieja :: Int -> Nave
naveVieja tanquesDeOxigeno planeta1 planeta2
  | tanquesDeOxigeno < 6 = tiempoViaje 10 planeta1 planeta2
  | otherwise = tiempoViaje 7 planeta1 planeta2

-- b.
naveFuturista :: Nave
naveFuturista _ _ = 0

viajar :: Nave -> Planeta -> Planeta -> Astronauta -> Astronauta
viajar unaNave origen destino = cambiarPlaneta destino . (`aumentarEdad` unaNave origen destino)

cambiarPlaneta :: Planeta -> Astronauta -> Astronauta
cambiarPlaneta nuevoPlaneta unAstronauta = unAstronauta {planeta = nuevoPlaneta}

---------------
--- Punto 4 ---
---------------
-- a.
rescate :: [Astronauta] -> Nave -> Planeta -> Astronauta -> [Astronauta]
rescate astronautas unaNave destino astronautaVarado = viajeGrupo unaNave destino (planeta . head $ astronautas) . incorporarTripulacion astronautaVarado . pasarTiempoGrupo (tiempoNave unaNave destino (head astronautas)) . viajeGrupo unaNave (planeta astronautaVarado) destino $ astronautas

viajeGrupo :: Nave -> Planeta -> Planeta -> [Astronauta] -> [Astronauta]
viajeGrupo unaNave origen destino = map (viajar unaNave origen destino)

incorporarTripulacion :: Astronauta -> [Astronauta] -> [Astronauta]
incorporarTripulacion unAstronauta = (unAstronauta :)

pasarTiempoGrupo :: Int -> [Astronauta] -> [Astronauta]
pasarTiempoGrupo años = map (pasarTiempo años)

tiempoNave :: Nave -> Planeta -> Astronauta -> Int
tiempoNave unaNave destino unAstronauta = tiempoViaje (unaNave (planeta unAstronauta) destino) (planeta unAstronauta) destino

-- b.
posiblesRescatados :: [Astronauta] -> Nave -> [Astronauta] -> [String]
posiblesRescatados rescatistas unaNave = map nombreA . filter (puedeSerRescatado rescatistas unaNave)

puedeSerRescatado :: [Astronauta] -> Nave -> Astronauta -> Bool
puedeSerRescatado rescatistas unaNave astronautaVarado = all ((<= 90) . edad) . rescate rescatistas unaNave (planeta astronautaVarado) $ astronautaVarado

---------------
--- Punto 5 ---
---------------
f :: (Ord y, Num z) => (y -> x -> y) -> y -> (z -> x -> Bool) -> [x] -> Bool
f a b c = any ((> b) . a b) . filter (c 10)

-- Razonamiento
{-
f a b c d = any ((> b) . a b) . filter (c 10) $ d

d es una lista la cual puede filtrarse con (c 10)
(c 10) es de tipo (x -> Bool) siendo x el tipo de los elementos de la
lista d. entonces c a secas es de tipo (Num -> x -> Bool)

luego de filtrarla obtenemos [x] , y esta la recibe la función any.
recordemos :t any
any :: (Foldable t) => (a -> Bool) -> t a -> Bool

entonces en este caso any :: (x -> Bool) -> [x] -> Bool
por lo que obtenemos que ((> b) . a b) es de tipo (x -> Bool)

a  es una función que al aplicarle b, se aplica parcialmente, resultando
una función aplicable a [x]
entonces a es de tipo (y -> x -> y)
donde y es el tipo de b, entonces al aplicar a b con un elemento de x
obtenemos un resultado de tipo y, el cual debe ser del mismo tipo que b
para comparar si es mayor ,y además debe ser Ord

obviamente el resultado de f es de tipo Bool ya que finaliza con un any
-}