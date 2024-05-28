{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Avoid lambda" #-}
import Text.Show.Functions

-- Lugar
type Lugar = (NombreLugar, DistanciaABsAs, [Caracteristica])

type NombreLugar = String

type Caracteristica = String

type DistanciaABsAs = Int

distanciaABsAs :: Lugar -> DistanciaABsAs
distanciaABsAs (_, distancia, _) = distancia

nombreLugar :: Lugar -> NombreLugar
nombreLugar (nombre, _, _) = nombre

atracciones :: Lugar -> [Caracteristica]
atracciones (_, _, caracteristicas) = caracteristicas

-- lugares de ejemplo
rosario :: Lugar
rosario = ("Rosario", 300, ["Monumento a la bandera", "Rio"])

marDelPlata :: Lugar
marDelPlata = ("Mar Del Plata", 400, ["Playa", "Alfajores", "Puloveres"])

bariloche :: Lugar
bariloche = ("Bariloche", 1600, ["Montañas", "Nieve", "Puloveres", "Chocolate"])

lugaresDeEjemplo :: [Lugar]
lugaresDeEjemplo = [rosario, marDelPlata, bariloche]

-- Persona
type Persona = (NombrePersona, Estilo)

type NombrePersona = String

type Estilo = Lugar -> Bool

estilo :: Persona -> Estilo
estilo = snd

-- Personas de ejemplo
juan :: Persona
juan = ("Juan", playero)

ana :: Persona
ana = ("Ana", mejorCerca)

jorge :: Persona
jorge = ("Jorge", gastronomico)

zulma :: Persona
zulma = ("Zulma", playero)

-- Estilos de vacaciones
playero :: Estilo
playero = elem "Playa" . atracciones

mejorCerca :: Estilo
mejorCerca = (<= 500) . distanciaABsAs

gastronomico :: Estilo
gastronomico = any productoComestible . atracciones

esquiador :: Estilo
esquiador unLugar = elem "Montaña" caracteristicas && elem "Nieve" caracteristicas && distanciaABsAs unLugar > 500
  where
    caracteristicas = atracciones unLugar

---------------
--- Punto 1 ---
---------------
productoComestible :: Caracteristica -> Bool
productoComestible producto = producto `elem` comidasTipicas

comidasTipicas :: [Caracteristica]
comidasTipicas = ["Alfajores", "Chocolate"]

---------------
--- Punto 2 ---
---------------
puedeIr :: Persona -> [Lugar] -> [NombreLugar]
puedeIr (_,estilo) = map nombreLugar . filter estilo
---------------
--- Punto 3 ---
---------------
lugarMasElegido :: [Persona] -> [Lugar] -> NombreLugar
lugarMasElegido personas lugares = elQueMasAparece $ puedenIr personas lugares

puedenIr :: [Persona] -> [Lugar] -> [NombreLugar]
puedenIr [] _ = []
puedenIr (persona:personas) lugares = puedeIr persona lugares ++ puedenIr personas lugares

elQueMasAparece :: (Eq a, Ord a) => [a] -> a
elQueMasAparece [] = error "La lista no puede estar vacía"
elQueMasAparece lista = snd . maximum $ [(cantidadDeVeces lista x, x) | x <- lista]

cantidadDeVeces :: (Eq a) => [a] -> a -> Int
cantidadDeVeces [] _ = 0
cantidadDeVeces (x : xs) unElem
    | unElem == x = 1 + cantidadDeVeces xs unElem
    | otherwise = cantidadDeVeces xs unElem
---------------
--- Punto 4 ---
---------------
puedenIrTodosA :: [Persona] -> Lugar -> Bool
puedenIrTodosA [] _ = True
puedenIrTodosA (persona : personas) unLugar = estilo persona unLugar && puedenIrTodosA personas unLugar

---------------
--- Punto 5 ---
---------------
lugaresCompatibles :: [Persona] -> [Lugar] -> [NombreLugar]
lugaresCompatibles familia = map nombreLugar . filter (puedenIrTodosA familia)
---------------
--- Punto 6 ---
---------------
carlos :: Persona
carlos = ("Carlos",\lugar -> esPalindromo $ nombreLugar lugar)

esPalindromo :: String -> Bool
esPalindromo cadena = cadena == reverse cadena