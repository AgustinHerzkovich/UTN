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

-- 1.
-- a. Modelar los palos usados en el juego que a partir de una determinada habilidad generan un tiro que se compone por velocidad, precisión y altura.

data Palo = Putter | Madera | Hierro Int deriving (Show)

-- i. El putter genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0
-- ii. La madera genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.
-- iii. Los hierros, que varían del 1 al 10 (número al que denominaremos n), generan un tiro de velocidad igual a la fuerza multiplicada por n, la precisión dividida por n y una altura
-- de n-3 (con mínimo 0). Modelarlos de la forma más genérica posible

generarTiro :: Habilidad -> Palo  -> Tiro
generarTiro habilidad Putter  = UnTiro 10 (((* 2) . precisionJugador) habilidad) 0
generarTiro habilidad Madera  = UnTiro 100 (((`div` 2) . precisionJugador) habilidad) 5
generarTiro habilidad (Hierro n)  = UnTiro (((* n) . fuerzaJugador) habilidad) (((`div` n) . precisionJugador) habilidad) (max 0 n - 3)

-- b. Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.

palos :: [Palo]
palos = [Putter, Madera] ++ [Hierro n | n <- [1 .. 10]]

-- 2. Definir la función golpe que dados una persona y un palo, obtiene el tiro resultante de usar ese palo con las habilidades de la persona.
-- Por ejemplo si Bart usa un putter, se genera un tiro de velocidad = 10, precisión = 120 y altura = 0.

golpe :: Jugador -> Palo -> Tiro
golpe jugador = generarTiro (habilidad jugador) 

-- 3. Lo que nos interesa de los distintos obstáculos es si un tiro puede superarlo, y en el caso de poder superarlo, cómo se ve afectado dicho tiro por el obstáculo.
-- En principio necesitamos representar los siguientes obstáculos:
data Obstaculo = Tunel | Laguna Int | Hoyo deriving (Show)

-- a. Un túnel con rampita sólo es superado si la precisión es mayor a 90 yendo al ras del suelo, independientemente de la velocidad del tiro.
-- Al salir del túnel la velocidad del tiro se duplica, la precisión pasa a ser 100 y la altura 0.

-- b. Una laguna es superada si la velocidad del tiro es mayor a 80 y tiene una altura de entre 1 y 5 metros.
-- Luego de superar una laguna el tiro llega con la misma velocidad y precisión, pero una altura equivalente a la altura original dividida por el largo de la laguna.

-- c. Un hoyo se supera si la velocidad del tiro está entre 5 y 20 m/s yendo al ras del suelo con una precisión mayor a 95.
-- Al superar el hoyo, el tiro se detiene, quedando con todos sus componentes en 0.

puedeSuperarlo :: Tiro -> Obstaculo -> Bool
puedeSuperarlo (UnTiro _ precision altura) Tunel = precision > 90 && altura == 0
puedeSuperarlo (UnTiro velocidad _ altura) (Laguna _) = velocidad > 80 && (altura >= 1 && altura <= 5)
puedeSuperarlo (UnTiro velocidad precision altura) Hoyo = (velocidad >= 5 && velocidad <= 20) && altura == 0 && precision > 95

modificar :: Tiro -> Obstaculo -> Tiro
modificar (UnTiro velocidad _ _) Tunel = UnTiro ((* 2) velocidad) 100 0
modificar (UnTiro velocidad precision altura) (Laguna largo) = UnTiro velocidad precision (altura `div` largo)
modificar (UnTiro {}) Hoyo = UnTiro 0 0 0

-- Se desea saber cómo queda un tiro luego de intentar superar un obstáculo, teniendo en cuenta que en caso de no superarlo, se detiene, quedando con todos sus componentes en 0.

comoQueda :: Tiro -> Obstaculo -> Tiro
comoQueda tiro obstaculo
  | puedeSuperarlo tiro obstaculo  = modificar tiro obstaculo
  | otherwise = modificar tiro Hoyo

-- 4.
-- a. Definir palosUtiles que dada una persona y un obstáculo, permita determinar qué palos le sirven para superarlo.

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (\palo -> puedeSuperarlo (golpe jugador palo) obstaculo) palos

-- b. Saber, a partir de un conjunto de obstáculos y un tiro, cuántos obstáculos consecutivos se pueden superar.
-- Por ejemplo, para un tiro de velocidad = 10, precisión = 95 y altura = 0, y una lista con dos túneles con rampita seguidos de un hoyo,
-- el resultado sería 2 ya que la velocidad al salir del segundo túnel es de 40, por ende no supera el hoyo.
-- BONUS: resolver este problema sin recursividad, teniendo en cuenta que existe una función takeWhile :: (a -> Bool) -> [a] -> [a] que podría ser de utilidad.

cuantosObstaculosPuedeSuperar :: Tiro -> [Obstaculo] -> Int
cuantosObstaculosPuedeSuperar tiro  = length . takeWhile (puedeSuperarlo tiro)

-- c. Definir paloMasUtil que recibe una persona y una lista de obstáculos y determina cuál es el palo que le permite superar más obstáculos con un solo tiro

--paloMasUtil :: Jugador -> [Obstaculo] -> Palo
--paloMasUtil jugador obstaculos = (!!) .  max . map (cuantosObstaculosPuedeSuperar (map (generarTiro habilidad jugador) (palos))) obstaculos

-- 5. Dada una lista de tipo [(Jugador, Puntos)] que tiene la información de cuántos puntos ganó cada niño al finalizar el torneo, se pide retornar la lista de padres que pierden
-- la apuesta por ser el “padre del niño que no ganó”. Se dice que un niño ganó el torneo si tiene más puntos que los otros niños.

padresPerdedores :: [(Jugador,Puntos)] -> [String]
padresPerdedores lista = map padre (map fst (filter (\(jugador,puntos) -> puntos /= maximum (map snd lista)) lista))

listado :: [(Jugador, Puntos)]
listado = [(bart,20),(todd,50),(rafa,10)]