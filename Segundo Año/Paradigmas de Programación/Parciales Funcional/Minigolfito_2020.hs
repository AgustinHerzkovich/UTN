import Data.Time (TimeZone (timeZoneSummerOnly))
import Distribution.Make (unAbiHash)

-- Modelo inicial
data Jugador = UnJugador
  { nombre :: String,
    padre :: String,
    habilidad :: Habilidad
  }
  deriving (Eq, Show)

data Habilidad = Habilidad
  { fuerzaJugador :: Int,
    precisionJugador :: Int
  }
  deriving (Eq, Show)

-- Jugadores de ejemplo
bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)

todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)

rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro
  { velocidad :: Int,
    precision :: Int,
    altura :: Int
  }
  deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = x `elem` [n .. m]

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: (Ord a) => (t -> a) -> t -> t -> t
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

---------------
--- Punto 1 ---
---------------
-- a.

type Palo = Habilidad -> Tiro

-- i.
putter :: Palo
putter unaHabilidad = UnTiro 10 ((2 *) . precisionJugador $ unaHabilidad) 0

-- ii.
madera :: Palo
madera unaHabilidad = UnTiro 100 ((`div` 2) . precisionJugador $ unaHabilidad) 5

-- iii.
hierro :: Int -> Palo
hierro n unaHabilidad = UnTiro ((* n) . fuerzaJugador $ unaHabilidad) ((`div` n) . precisionJugador $ unaHabilidad) (n - 3)

-- b.
palos :: [Palo]
palos = [putter, madera] ++ [hierro n | n <- [1 .. 10]]

---------------
--- Punto 2 ---
---------------
golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo $ habilidad jugador

---------------
--- Punto 3 ---
---------------
type Condicion = Tiro -> Bool

type Efecto = Tiro -> Tiro

data Obstaculo = Obstaculo
  { condicionSuperacion :: Condicion,
    efecto :: Efecto
  }

tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0

condicionTunelConRampita :: Condicion
condicionTunelConRampita tiro = precision tiro > 90 && altura tiro == 0

efectoTunelConRampita :: Efecto
efectoTunelConRampita tiro = tiro {velocidad = (2 *) . precision $ tiro, precision = 100, altura = 0}

condicionLaguna :: Condicion
condicionLaguna tiro = velocidad tiro > 80 && (between 1 5 . altura) tiro

efectoLaguna :: Int -> Efecto
efectoLaguna largo tiro = tiro {altura = altura tiro `div` largo}

condicionHoyo :: Condicion
condicionHoyo tiro = (between 5 20 . velocidad) tiro && altura tiro == 0 && precision tiro > 95

efectoHoyo :: Efecto
efectoHoyo _ = tiroDetenido

tunelConRampita :: Obstaculo
tunelConRampita = Obstaculo condicionTunelConRampita efectoTunelConRampita

laguna :: Int -> Obstaculo
laguna largo = Obstaculo condicionLaguna $ efectoLaguna largo

hoyo :: Obstaculo
hoyo = Obstaculo condicionHoyo efectoHoyo

intentarSuperar :: Obstaculo -> Tiro -> Tiro
intentarSuperar obstaculo tiro
  | condicionSuperacion obstaculo tiro = efecto obstaculo tiro
  | otherwise = tiroDetenido

---------------
--- Punto 4 ---
---------------
-- a.
esUtil :: Jugador -> Obstaculo -> Palo -> Bool
esUtil jugador obstaculo palo = condicionSuperacion obstaculo $ golpe jugador palo

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (esUtil jugador obstaculo) palos

-- b.
tirosSucesivos :: Tiro -> [Obstaculo] -> [Tiro]
tirosSucesivos tiro = foldl (\tirosGenerados obstaculo -> tirosGenerados ++ [efecto obstaculo (last tirosGenerados)]) [tiro]

cuantosObstaculosPuedeSuperar :: Tiro -> [Obstaculo] -> Int
cuantosObstaculosPuedeSuperar tiro obstaculos = (length . takeWhile (uncurry condicionSuperacion) . zip obstaculos . tirosSucesivos tiro) obstaculos

-- c.
paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos = maximoSegun (flip cuantosObstaculosPuedeSuperar obstaculos . golpe jugador) palos

---------------
--- Punto 5 ---
---------------
padresPerdedores :: [(Jugador, Puntos)] -> [String]
padresPerdedores lista = map (padre . fst) (filter (\(jugador, puntos) -> puntos /= maximum (map snd lista)) lista)