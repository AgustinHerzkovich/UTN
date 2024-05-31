import Text.Show.Functions()
---------------
--- Dominio ---
---------------
data Persona = UnaPersona{
    nombre :: String,
    dinero :: Float,
    suerte :: Int,
    factores :: [Factor]
} deriving (Show)

type Factor = (String,Int)

nombreFactor :: Factor -> String
nombreFactor = fst

valorFactor :: Factor -> Int
valorFactor = snd

-- Personas de prueba
nico :: Persona
nico = UnaPersona "Nico" 100.0 30 [("amuleto", 3), ("manos magicas", 100)]

maiu :: Persona
maiu = UnaPersona "Maiu" 100.0 42 [("inteligencia", 55), ("paciencia", 50)]

---------------
--- Punto 1 ---
---------------
suerteTotal :: Persona -> Int
suerteTotal unJugador
    | tieneUnFactor "amuleto" unJugador = suerte unJugador * (valorFactor . encontrarFactor "amuleto" . factores $ unJugador)
    | otherwise = suerte unJugador

tieneUnFactor :: String -> Criterio
tieneUnFactor unFactor unJugador = (any ((== unFactor) . nombreFactor) . factores ) unJugador && ((> 0) . valorFactor . encontrarFactor unFactor . factores ) unJugador

encontrarFactor :: String -> [Factor] -> Factor
encontrarFactor unFactor = head . filter ((== unFactor) . nombreFactor)
---------------
--- Punto 2 ---
---------------
data Juego = UnJuego {
    titulo :: String,
    ganancia :: Float -> Float,
    criteriosGanadores :: [Criterio]
} deriving(Show)

type Criterio = Persona -> Bool

-- a.
ruleta :: Juego
ruleta = UnJuego "La Ruleta" (* 37) [suerteMayorA 80]

suerteMayorA :: Int -> Criterio
suerteMayorA n = (>n) . suerteTotal

-- b.
maquinita :: Float -> Juego
maquinita jackpot = UnJuego "La Maquinita" (+ jackpot) [suerteMayorA 95, tieneUnFactor "paciencia"]
---------------
--- Punto 3 ---
---------------
puedeGanar :: Persona -> Juego -> Bool
puedeGanar unJugador = cumpleLasCondiciones unJugador . criteriosGanadores

cumpleLasCondiciones :: Persona -> [Criterio] -> Bool
cumpleLasCondiciones unJugador = foldr (\criterio acum -> criterio unJugador && acum ) True
---------------
--- Punto 4 ---
---------------
-- a.
puedeConseguir :: Persona -> Float -> [Juego] -> Float
puedeConseguir unJugador apuestaInicial juegos
    | any (puedeGanar unJugador) juegos = foldr ganancia apuestaInicial . filter (puedeGanar unJugador) $ juegos
    | otherwise = apuestaInicial

-- b.
puedeConseguir' :: Persona -> Float -> [Juego] -> Float
puedeConseguir' _ apuestaInicial [] = apuestaInicial
puedeConseguir' unJugador apuestaInicial juegos
  | any (puedeGanar unJugador) juegos = puedeConseguir' unJugador (ganancia (head juegos) apuestaInicial) (filter (puedeGanar unJugador) (tail juegos))
  | otherwise = apuestaInicial

-- ghci> puedeConseguir nico 200 [ruleta,maquinita 10]
-- ghci> 7400.0

-- ghci> puedeConseguir maiu 200 [ruleta,maquinita 10]
-- ghci> 200.0
---------------
--- Punto 5 ---
---------------
nombresPerdedores :: [Persona] -> [Juego] -> [String]
nombresPerdedores jugadores = map nombre . perdedores jugadores

perdedores :: [Persona] -> [Juego] -> [Persona]
perdedores [] _ = []
perdedores (jugador:jugadores) juegos
    | not . any (puedeGanar jugador) $ juegos = jugador : perdedores jugadores juegos
    | otherwise = perdedores jugadores juegos
---------------
--- Punto 6 ---
---------------
apostar :: Float -> Juego -> Persona -> Persona
apostar apuesta unJuego = jugar apuesta unJuego . subirSaldo (- apuesta)

subirSaldo :: Float -> Persona -> Persona
subirSaldo cantidad unJugador = unJugador {dinero = dinero unJugador + cantidad}

jugar :: Float -> Juego -> Persona -> Persona
jugar apuesta unJuego unJugador
    | puedeGanar unJugador unJuego = subirSaldo (ganancia unJuego apuesta) unJugador
    | otherwise = unJugador

---------------
--- Punto 7 ---
---------------
elCocoEstaEnLaCasa :: (Ord b, Num b, Foldable t1) => (a, [b]) -> (t2 -> [b]) -> b -> t1 ([b] -> [b], t2) -> Bool
elCocoEstaEnLaCasa x y z = all ((> z) . (+ 42)) . foldl (\a (b, c) -> y c ++ b a) (snd x)