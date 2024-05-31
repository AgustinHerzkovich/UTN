data Persona = Persona
  { edad :: Int,
    peso :: Float,
    tonificacion :: Int
  }
  deriving (Show)

type Ejercicio = Int -> Persona -> Persona

relax :: Ejercicio
relax minutos persona = persona

pancho :: Persona
pancho = Persona 40 120 1

andres :: Persona
andres = Persona 22 80 6

------------------ Punto 1 ---
---------------
estaSaludable :: Persona -> Bool
estaSaludable unaPersona = (not . esObesa) unaPersona && ((> 5) . tonificacion) unaPersona

esObesa :: Persona -> Bool
esObesa = (> 100) . peso

---------------
--- Punto 2 ---
---------------
quemarCalorias :: Float -> Persona -> Persona
quemarCalorias calorias unaPersona
  | esObesa unaPersona = bajarPeso (calorias / 150) unaPersona
  | edad unaPersona > 30 && calorias > 200 = bajarPeso 1 unaPersona
  | otherwise = bajarPeso (calorias / (peso unaPersona * fromIntegral (edad unaPersona))) unaPersona

bajarPeso :: Float -> Persona -> Persona
bajarPeso kilogramos unaPersona = unaPersona {peso = peso unaPersona - kilogramos}

---------------
--- Punto 3 ---
---------------
cinta :: Int -> Ejercicio
cinta velocidad minutos = quemarCalorias . fromIntegral $ velocidad * minutos

velocidadMaxima :: Int -> Int -> Int
velocidadMaxima velocidadInicial = (+ velocidadInicial) . (`div` 5)

tonificar :: Int -> Persona -> Persona
tonificar kilos unaPersona = unaPersona {tonificacion = tonificacion unaPersona + kilos}

caminata :: Ejercicio
caminata = cinta 5

entrenamientoEnCinta :: Ejercicio
entrenamientoEnCinta minutos = cinta (velocidadMaxima 6 minutos) minutos

pesas :: Int -> Ejercicio
pesas kilos minutos unaPersona
  | minutos > 10 = tonificar (kilos `div` 10) unaPersona
  | otherwise = unaPersona

colina :: Int -> Ejercicio
colina inclinacion minutos = quemarCalorias $ fromIntegral (2 * inclinacion * minutos)

montaña :: Int -> Ejercicio
montaña inclinacionInicial minutos = tonificar 1 . colina (inclinacionInicial + 3) (minutos `div` 2) . colina inclinacionInicial (minutos `div` 2)

---------------
--- Punto 4 ---
---------------
type Rutina = (String, Int, [Ejercicio])

type Resumen = (String, Float, Int)

nombre :: Rutina -> String
nombre (n, _, _) = n

hacerEjercicio :: Int -> Persona -> Ejercicio -> Persona
hacerEjercicio minutos unaPersona unEjercicio = unEjercicio minutos unaPersona

hacerRutina :: Rutina -> Persona -> Persona
hacerRutina (_, _, []) unaPersona = unaPersona
hacerRutina (nombre, duracion, ejercicio : ejercicios) unaPersona = hacerRutina (nombre, duracion, ejercicios) . ejercicio duracion $ unaPersona

hacerRutina' :: Rutina -> Persona -> Persona
hacerRutina' (nombre, duracion, ejercicios) unaPersona = foldr (\ejercicio persona -> ejercicio duracion persona) unaPersona ejercicios

resumenRutina :: Persona -> Rutina -> Resumen
resumenRutina unaPersona unaRutina = (nombre unaRutina, pesoPerdido unaPersona $ hacerRutina unaRutina unaPersona, tonificacionGanada unaPersona $ hacerRutina' unaRutina unaPersona)

pesoPerdido :: Persona -> Persona -> Float
pesoPerdido personaAntes personaDespues = peso personaAntes - peso personaDespues

tonificacionGanada :: Persona -> Persona -> Int
tonificacionGanada personaAntes personaDespues = tonificacion personaDespues - tonificacion personaAntes

---------------
--- Punto 5 ---
---------------
resumenesRutinasSaludables :: Persona -> [Rutina] -> [Resumen]
resumenesRutinasSaludables unaPersona = map (resumenRutina unaPersona) . filter (esSaludable unaPersona)

esSaludable :: Persona -> Rutina -> Bool
esSaludable unaPersona unaRutina = pesoPerdido unaPersona (hacerRutina unaRutina unaPersona) > 10 && tonificacionGanada unaPersona (hacerRutina' unaRutina unaPersona) > 2