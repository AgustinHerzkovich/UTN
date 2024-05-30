import Text.Show.Functions()
---------------
--- Dominio ---
---------------
type Participante = (Nombre, Nombre, Habilidad)

type Nombre = String

type Habilidad = (Int, Int)

nombre :: Participante -> Nombre
nombre (n, _, _) = n

padre :: Participante -> Nombre
padre (_, p, _) = p

habilidad :: Participante -> Habilidad
habilidad (_, _, h) = h

fuerzaHabilidad :: Habilidad -> Int
fuerzaHabilidad (f, _) = f

precisionHabilidad :: Habilidad -> Int
precisionHabilidad (_, p) = p

--- Participantes de prueba
bart :: Participante
bart = ("Bart", "Homero", (25, 60))

todd :: Participante
todd = ("Todd", "Ned", (15, 80))

rafa :: Participante
rafa = ("Rafa", "Gorgory", (10, 1))

type Obstaculo = (Condicion, Efecto)

efecto :: Obstaculo -> Efecto
efecto = snd

type Condicion = Tiro -> Bool

type Efecto = Tiro -> Tiro

type Tiro = (Int, Int, Int)

velocidad :: Tiro -> Int
velocidad (v, _, _) = v

precision :: Tiro -> Int
precision (_, p, _) = p

altura :: Tiro -> Int
altura (_, _, a) = a

-- Obstaculos de prueba
laguna :: Int -> Obstaculo
laguna largo = ((\(v, _, a) -> v > 80 && between 10 50 a), (\(v, p, a) -> (v, p, a `div` largo)))

tunelConRampita :: Obstaculo
tunelConRampita = ((\(_, p, a) -> p > 90 && a == 0), (\(v, _, a) -> (v * 2, 100, 0)))

hoyo :: Obstaculo
hoyo = ((\(v, p, a) -> between 5 20 v && p > 95 && a == 0), (\_ -> (0, 0, 0)))

-- Funciones auxiliares
between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = elem x [n .. m]

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: (Ord a) => (t -> a) -> t -> t -> t
mayorSegun f a b
  | f a >= f b = a
  | otherwise = b

---------------
--- Punto 1 ---
---------------
type Palo = Habilidad -> Tiro

generarTiro :: Int -> Int -> Int -> Tiro
generarTiro velocidad precision altura = (velocidad, precision, altura)

putter :: Palo
putter unaHabilidad = generarTiro 10 (precisionHabilidad unaHabilidad * 2) 0

madera :: Palo
madera unaHabilidad = generarTiro 100 (precisionHabilidad unaHabilidad `div` 2) 5

hierro :: Int -> Palo
hierro n unaHabilidad
  | between 1 10 n = generarTiro (fuerzaHabilidad unaHabilidad * n) (precisionHabilidad unaHabilidad `div` n) (n ^ 2)
  | otherwise = undefined

palos :: [Palo]
palos = putter : madera : map hierro [1 .. 10]

---------------
--- Punto 2 ---
---------------
-- a.
golpe :: Palo -> Participante -> Tiro
golpe unPalo = unPalo . habilidad

-- b.
puedeSuperar :: Obstaculo -> Tiro -> Bool
puedeSuperar = fst

-- c.
palosUtiles :: Participante -> Obstaculo -> [Palo]
palosUtiles unParticipante unObstaculo = filter (esUtil unObstaculo $ habilidad unParticipante) palos

esUtil :: Obstaculo -> Habilidad -> Palo -> Bool
esUtil unObstaculo unaHabilidad unPalo = puedeSuperar unObstaculo . unPalo $ unaHabilidad

-- d.
nombresDeLosQuePuedenSuperarTodos :: [Obstaculo] -> [Participante] -> [Nombre]
nombresDeLosQuePuedenSuperarTodos obstaculos = map nombre . filter (puedeSuperarlosTodos obstaculos)

puedeSuperarlosTodos :: [Obstaculo] -> Participante -> Bool
puedeSuperarlosTodos obstaculos unParticipante = (not . any (null . palosUtiles unParticipante)) obstaculos

---------------
--- Punto 3 ---
---------------
-- a.
cuantosObstaculosSupera :: [Obstaculo] -> Tiro -> Int
cuantosObstaculosSupera []  _ = 0
cuantosObstaculosSupera (obstaculo : obstaculos) unTiro
    | puedeSuperar obstaculo unTiro = 1 + cuantosObstaculosSupera obstaculos (efecto obstaculo unTiro) 
    | otherwise = cuantosObstaculosSupera obstaculos (efecto obstaculo unTiro) 

-- b.
paloMasUtil :: Participante -> [Obstaculo] -> Palo
paloMasUtil unParticipante obstaculos = maximoSegun (\palo -> cuantosObstaculosSupera obstaculos (golpe palo unParticipante)) palos

---------------
--- Punto 4 ---
---------------
puntosGanados :: [Obstaculo] -> Participante -> Int
puntosGanados obstaculos unParticipante = cuantosObstaculosSupera obstaculos (golpe (paloMasUtil unParticipante obstaculos) unParticipante)

pierdenLaApuesta :: [Participante] -> [Obstaculo] -> [Nombre]
pierdenLaApuesta participantes obstaculos = map padre . filter (not. esGanador obstaculos participantes) $ participantes

esGanador :: [Obstaculo] -> [Participante] -> Participante -> Bool
esGanador obstaculos participantes unParticipante = puedeSuperarlosTodos obstaculos unParticipante && tieneMasPuntos unParticipante participantes obstaculos

tieneMasPuntos :: Participante -> [Participante] -> [Obstaculo] -> Bool
tieneMasPuntos unParticipante participantes obstaculos = unParticipante == maximoSegun (puntosGanados obstaculos) participantes