--------------
-- Punto 01 --
--------------
data Personaje = Personaje{
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
} deriving(Show)

type Actividad = Personaje -> Personaje

modificarFelicidad :: (Int -> Int) -> Personaje -> Personaje
modificarFelicidad unaOperacion unPersonaje = unPersonaje{felicidad = max 0 (unaOperacion (felicidad unPersonaje))}

modificarDinero :: (Int -> Int) -> Personaje -> Personaje
modificarDinero unaOperacion unPersonaje = unPersonaje {dinero = unaOperacion (dinero unPersonaje)}

-- Actividades
irALaEscuela :: Actividad
irALaEscuela unPersonaje
    | (== "lisa") .nombre $ unPersonaje = modificarFelicidad (+ 20) unPersonaje
    | otherwise = modificarFelicidad (+ (-20)) unPersonaje

comerDonas :: Int -> Actividad
comerDonas cantidadDonas = modificarDinero (+ (-10)) . modificarFelicidad (+ 10 * cantidadDonas)

irATrabajar :: Foldable t => t a -> Actividad
irATrabajar unTrabajo = modificarDinero (+ length unTrabajo)

trabajarComoDirector :: Actividad
trabajarComoDirector = irALaEscuela . irATrabajar "escuela elemental"

actividadSuprema :: Actividad
actividadSuprema = modificarFelicidad (* 9999) . modificarDinero (+100000000)

-- Personajes 
homero :: Personaje
homero = Personaje "homero" 100 15

skinner :: Personaje
skinner = Personaje "skinner" 500 10

lisa :: Personaje
lisa = Personaje "lisa" 50 70

srBurns :: Personaje
srBurns = Personaje "sr burns" 1000000 5

-- ghci> comerDonas 12 homero
-- Personaje {nombre = "homero", dinero = 90, felicidad = 135}

-- ghci> trabajarComoDirector skinner
-- Personaje {nombre = "skinner", dinero = 517, felicidad = 0}

-- ghci> actividadSuprema . irALaEscuela $ lisa
-- Personaje {nombre = "lisa", dinero = 100000050, felicidad = 899910}

--------------
-- Punto 02 --
--------------
type Logro = Personaje -> Bool

-- Logros
serMillonario :: Logro
serMillonario = (> dinero srBurns) . dinero

alegrarse :: Int -> Logro
alegrarse felicidadDeseada = (> felicidadDeseada) . felicidad

verProgramaDeKrosti :: Logro
verProgramaDeKrosti = (>= 10) . dinero

nombreLargo :: Logro
nombreLargo = (> 20) . length . nombre
-- A --
esDecisiva :: Personaje -> Logro -> Actividad -> Bool
esDecisiva unPersonaje unLogro unaActividad  = (not . unLogro) unPersonaje && (unLogro . unaActividad) unPersonaje

-- B --
realizarPrimeraActividadDecisiva :: Personaje -> Logro -> [Actividad] -> Personaje
realizarPrimeraActividadDecisiva unPersonaje unLogro unasActividades
    | any (esDecisiva unPersonaje unLogro) unasActividades = ($ unPersonaje) . head . filter (esDecisiva unPersonaje unLogro) $ unasActividades
    | otherwise = unPersonaje

-- C --
infinitasActividades :: [Actividad]
infinitasActividades = repeat actividadSuprema

-- ghci> realizarPrimeraActividadDecisiva homero serMillonario infinitasActividades
{-
En este caso retorna un resultado, ya que existe por lo menos una actividad que es decisiva para homero para lograr ser millonario,
y no necesita evaluar las demás simplemente se queda con la primera debido a su evaliación perezosa.
-}

-- ghci> realizarPrimeraActividadDecisiva homero nombreLargo infinitasActividades
{-
En este caso no llega a retornar ningún resultado, ya que ninguna de las actividades resulta decisiva para homero si quiere
lograr un nombre largo, sin embargo para asegurarse de ello, tiene que recorrer toda la lista y por ello nunca termina, por lo que
no muestra ningún resultado.
-}