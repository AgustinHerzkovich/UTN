-------------------
-- Primera Parte --
-------------------

---------------
--- Punto 1 ---
---------------
type Habilidad = String

type Planeta = String

type Material = String

type Universo = [Personaje]

type Gema = Personaje -> Personaje

data Personaje = UnPersonaje
  { edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad],
    nombre :: String,
    planeta :: Planeta
  }

data Guantelete = UnGuantelete
  { material :: Material,
    gemas :: [Gema]
  }

estaCompleto :: Guantelete -> Bool
estaCompleto unGuantelete = ((== 6) . length . gemas) unGuantelete && ((== "uru") . material) unGuantelete

reducirALaMitad :: Universo -> Universo
reducirALaMitad unUniverso = take mitad unUniverso
  where
    mitad = (`div` 2) . length $ unUniverso

chasquearUnUniverso :: Guantelete -> Universo -> Universo
chasquearUnUniverso unGuantelete unUniverso
  | estaCompleto unGuantelete && material unGuantelete == "uru" = reducirALaMitad unUniverso
  | otherwise = error "El guantelete no cumple los requisitos"

---------------
--- Punto 2 ---
---------------
esAptoParaPendex :: Universo -> Bool
esAptoParaPendex = any ((< 45) . edad)

energiaTotal :: Universo -> Int
energiaTotal = sum . map energia . filter tieneMasDeUnaHabilidad

tieneMasDeUnaHabilidad :: Personaje -> Bool
tieneMasDeUnaHabilidad = (> 1) . length . habilidades

-------------------
-- Segunda Parte --
-------------------
-- Funciones auxiliares
restarEnergia :: Int -> Personaje -> Personaje
restarEnergia cantidad unPersonaje = unPersonaje {energia = energia unPersonaje - cantidad}

eliminarHabilidad :: Habilidad -> Personaje -> Personaje
eliminarHabilidad unaHabilidad unPersonaje
  | elem unaHabilidad . habilidades $ unPersonaje = unPersonaje {habilidades = filter (/= unaHabilidad) . habilidades $ unPersonaje}
  | otherwise = error "El personaje no posee dicha habilidad"

transportarAlPlaneta :: Planeta -> Personaje -> Personaje
transportarAlPlaneta unPlaneta unPersonaje = unPersonaje {planeta = unPlaneta}

quitarHabilidadesSiTiene :: Int -> Personaje -> Personaje
quitarHabilidadesSiTiene cantidad unPersonaje
  | (<= cantidad) . length . habilidades $ unPersonaje = unPersonaje {habilidades = []}
  | otherwise = unPersonaje

mitadEdad :: Personaje -> Personaje
mitadEdad unPersonaje = unPersonaje {edad = max 18 (edad unPersonaje `div` 2)}

---------------
--- Punto 3 ---
---------------
mente :: Int -> Gema
mente = restarEnergia

alma :: Habilidad -> Gema
alma unaHabilidad = restarEnergia 10 . eliminarHabilidad unaHabilidad

espacio :: Planeta -> Gema
espacio planetaX = restarEnergia 20 . transportarAlPlaneta planetaX

poder :: Gema
poder unPersonaje = quitarHabilidadesSiTiene 2 . restarEnergia (energia unPersonaje) $ unPersonaje

tiempo :: Gema
tiempo = restarEnergia 50 . mitadEdad

gemaLoca :: Gema -> Gema
gemaLoca unaGema = unaGema . unaGema

---------------
--- Punto 4 ---
---------------
guanteleteEjemplo :: Guantelete
guanteleteEjemplo = UnGuantelete "goma" [tiempo, alma "usar Mjolnir", gemaLoca (alma "programacion en Haskell")]

---------------
--- Punto 5 ---
---------------
utilizar :: Personaje -> [Gema] -> Personaje
utilizar = foldr ($)

{-
El efecto de lado se produce gracias al foldr ($) de la siguiente manera
supongamos la lista de gemas [tiempo, alma "usar Mjolnir", gemaLoca (alma "programacion en Haskell")]
y un personaje random llamado alfred.
Al aplicar el foldr con la operación $ lo que se está haciendo es lo siguiente:

gemaLoca (alma "programacion en Haskell") $ alma "usar Mjolnir" $ tiempo alfred
por ende el efecto lado se da ya que la lista de gemas, al fin y al cabo son listas de (Personaje -> Personaje),
por lo que si yo le paso un personaje a la gema tiempo, esto me devuelve otro personaje, el cual se pasa a la siguiente gema,
y así hasta llegar a la última gema, obteniendo este "efecto de lado" que parece que se está aplicando de manera secuencial.
-}
---------------
--- Punto 6 ---
---------------
gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa unPersonaje = gemaMasPoderosaDe unPersonaje . gemas

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
gemaMasPoderosaDe unPersonaje (gema1 : gema2 : gemas)
  | (energia . gema1) unPersonaje < (energia . gema2) unPersonaje = gemaMasPoderosaDe unPersonaje (gema1 : gemas)
  | otherwise = gemaMasPoderosaDe unPersonaje (gema2 : gemas)

---------------
--- Punto 7 ---
---------------
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema : infinitasGemas gema

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete unPersonaje = (utilizar unPersonaje . take 3 . gemas) guantelete

punisher :: Personaje
punisher = UnPersonaje 38 85 ["Combate cuerpo a cuerpo", "Manejo de armas de fuego", "Estrategia militar", "Resistencia física"] "Frank Castle" "Tierra"

{-
-- gemaMasPoderosa punisher guanteleteDeLocos
Esto no muestra ningún resultado, ya que al entrar en la función gemaMasPoderosaDe
con una lista infinita, nunca logrará converger al caso base, por ende, la función se quedará infinitamente
en bucle cayendo en los casos recursivos y nunca logrará determinr cuál es la gema
más poderosa.

-- usoLasTresPrimerasGemas guanteleteDeLocos punisher
Esta función sí arroja resultado, ya que a peser de tener una lista infinita de gemas, sólo
se están tomando las primeras 3 de ella y luego esas 3 son las que utiliza el personaje, por lo tanto,
sin ningún tipo de problema, la función devuelve un resultado.
-}