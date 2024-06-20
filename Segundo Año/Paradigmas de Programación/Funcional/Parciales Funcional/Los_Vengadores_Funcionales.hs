--------------
-- Punto 01 --
--------------
data Personaje = UnPersonaje
  { nombre :: String,
    ataqueFavorito :: Ataque,
    elementos :: [Elemento],
    energia :: Int
  }

type Elemento = String

type Ataque = Personaje -> Personaje

-- Vengadores
hulk :: Personaje
hulk = UnPersonaje "hulk" superFuerza ["pantalones"] 90

thor :: Personaje
thor = UnPersonaje "thor" (relampagos 50) ["mjolnir"] 100

viuda :: Personaje
viuda = UnPersonaje "viuda negra" artesMarciales [] 90

capitan :: Personaje
capitan = UnPersonaje "capitán américa" arrojarEscudo ["escudo"] 80

halcon :: Personaje
halcon = UnPersonaje "ojo de halcón" arqueria ["arco", "flechas"] 70

vision :: Personaje
vision = UnPersonaje "vision" (proyectarRayos 5) ["gema del infinito"] 100

ironMan :: Personaje
ironMan = UnPersonaje "iron man" (ironia (relampagos (-50))) ["armadura", "jarvis", "plata"] 60

ultron :: Personaje
ultron = UnPersonaje "robot ultron" corromperTecnologia [] 100

-- a --
esRobot :: Personaje -> Bool
esRobot = (== "robot") . head . words . nombre

-- b --
poseeElemento :: Elemento -> Personaje -> Bool
poseeElemento unElemento = elem unElemento . elementos

-- c --
potencia :: Personaje -> Int
potencia unPersonaje = (* energia unPersonaje) . length . elementos $ unPersonaje

--------------
-- Punto 02 --
--------------
modificarEnergia :: (Int -> Int) -> Personaje -> Personaje
modificarEnergia transformacion unPersonaje = unPersonaje {energia = transformacion . energia $ unPersonaje}

dejarInconsciente :: Personaje -> Personaje
dejarInconsciente = modificarEnergia (const 0)

modificarAtaque :: Ataque -> Personaje -> Personaje
modificarAtaque nuevoAtaque unPersonaje = unPersonaje {ataqueFavorito = nuevoAtaque}

-- Ataques
superFuerza :: Ataque
superFuerza = dejarInconsciente

relampagos :: Int -> Ataque
relampagos ciertaEnergia = modificarEnergia (\energiaOriginal -> energiaOriginal - ciertaEnergia)

arqueria :: Ataque
arqueria unPersonaje
  | not . poseeElemento "escudo" $ unPersonaje = dejarInconsciente unPersonaje
  | otherwise = unPersonaje

proyectarRayos :: Int -> Ataque
proyectarRayos ciertaEnergia = relampagos ciertaEnergia . relampagos ciertaEnergia

arrojarEscudo :: Ataque
arrojarEscudo unPersonaje = unPersonaje {elementos = []}

artesMarciales :: Ataque
artesMarciales = modificarAtaque id

ironia :: (Personaje -> Personaje) -> Ataque
ironia = modificarAtaque

corromperTecnologia :: Ataque
corromperTecnologia unPersonaje
  | esRobot unPersonaje = superFuerza unPersonaje
  | otherwise = unPersonaje

enfrentamiento :: Personaje -> Personaje -> Bool
enfrentamiento atacante victima = energia atacanteLuegoDelSegundoAtaque > energia victimaLuegoDelPrimerAtaque
  where
    victimaLuegoDelPrimerAtaque = ataqueFavorito atacante victima
    atacanteLuegoDelSegundoAtaque = ataqueFavorito victimaLuegoDelPrimerAtaque atacante

--------------
-- Punto 03 --
--------------
-- a --
batallaFinal :: [Personaje] -> [Personaje] -> [Personaje]
batallaFinal atacantes defensores
  | any tieneGemaInfinito atacantes && not (any tieneGemaInfinito defensores) = atacantes
  | not (any tieneGemaInfinito atacantes) && any tieneGemaInfinito defensores = defensores
  | ganoMasVeces atacantes defensores = atacantes
  | otherwise = defensores

tieneGemaInfinito :: Personaje -> Bool
tieneGemaInfinito = elem "gema del infinito" . elementos

ganoMasVeces :: [Personaje] -> [Personaje] -> Bool
ganoMasVeces unEquipo otroEquipo = (> mitadDeEnfrentamientos) . length . filter id . zipWith enfrentamiento unEquipo $ otroEquipo
  where
    mitadDeEnfrentamientos = (`div` 2) . length . zipWith enfrentamiento unEquipo $ otroEquipo

-- b --
ejercitoInfinitoDeRobots :: [Personaje]
ejercitoInfinitoDeRobots = [UnPersonaje ("robot" ++ show n) (proyectarRayos 10) [] 100 | n <- [1 ..]]

{-
Si se realiza una batalla contra el ejército infinito de robots nunca podría conocerse el resultado, debido a lo siguiente:
    a. Si el equipo opuesto tiene una gema del infinito: No alcanza con saber que el otro equipo tiene una gema del infinito,
        ya que debería verificarse que de todo el ejército de robots, ninguno la tiene, para lo cual se debería recorrer hasta el final la lista
        de robots, y esto nunca terminaría.
    b. Si el equipo opuesto no tiene una gema del infinito: En dicho caso, debería verificarse si algún robot del ejército de robots tiene la gema
        del infinito, para lo cual, nuevamente, debería recorrerse la lista completa de robots para verificar si alguno tiene la gema entre sus elementos,
        por la naturaleza del any, y teniendo en cuenta que ningún robot tiene la gema, obligatoriamente va a tener que recorrer la lista completa para cerciorarse
        de ello, por ende, nunca logrará terminar y no se mostrará ningún resultado por pantalla.
-}

--------------
-- Punto 04 --
--------------
quienesPuedenLevantarElMjolnir :: [Personaje] -> [Personaje]
quienesPuedenLevantarElMjolnir = filter puedeLevantarElMjolnir

puedeLevantarElMjolnir :: Personaje -> Bool
puedeLevantarElMjolnir unPersonaje = esDigno unPersonaje || nombre unPersonaje == "stan lee"

esDigno :: Personaje -> Bool
esDigno unPersonaje = (not . esRobot) unPersonaje && potencia unPersonaje > 1000