--------------
-- Punto 01 --
--------------
data GuerreroZ = GuerreroZ
  { nombre :: String,
    ki :: Float,
    raza :: Raza,
    fatiga :: Float,
    personalidad :: Personalidad
  }

data Raza = Humano | Namekiano | Saiyajin deriving (Eq)

gohan :: GuerreroZ
gohan = GuerreroZ "Gohan" 10000 Saiyajin 0 perezoso

--------------
-- Punto 02 --
--------------
esPoderoso :: GuerreroZ -> Bool
esPoderoso unGuerrero = ki unGuerrero > 8000 || raza unGuerrero == Saiyajin

--------------
-- Punto 03 --
--------------
-- Funciones auxiliares
agregarKi :: Float -> GuerreroZ -> GuerreroZ
agregarKi kiAgregado unGuerrero = unGuerrero {ki = kiAgregado + ki unGuerrero}

agregarFatiga :: Float -> GuerreroZ -> GuerreroZ
agregarFatiga fatigaAgregada unGuerrero = unGuerrero {fatiga = max 0 (fatigaAgregada + fatiga unGuerrero)}

esExperimentado :: GuerreroZ -> Bool
esExperimentado = (>= 22000) . ki

estaCansado :: GuerreroZ -> Bool
estaCansado = fatigaMayorAKi 44

estaExhausto :: GuerreroZ -> Bool
estaExhausto = fatigaMayorAKi 72

fatigaMayorAKi :: Float -> GuerreroZ -> Bool
fatigaMayorAKi porcentaje unGuerrero = (> ki unGuerrero * porcentaje / 100) . fatiga $ unGuerrero

-- Ejercicios
type Ejercicio = GuerreroZ -> GuerreroZ

pressBanca :: Ejercicio
pressBanca = agregarKi 90 . agregarFatiga 100

flexionDeBrazo :: Ejercicio
flexionDeBrazo = agregarFatiga 50

saltosAlCajon :: Int -> Ejercicio
saltosAlCajon centimetros = agregarFatiga (fromIntegral (centimetros `div` 5)) . agregarKi (fromIntegral (centimetros `div` 10))

snatch :: Ejercicio
snatch unGuerrero
  | esExperimentado unGuerrero = agregarFatiga (fatiga unGuerrero * 0.1) . agregarKi (ki unGuerrero * 0.05) $ unGuerrero
  | otherwise = agregarFatiga 100 unGuerrero

realizarEjercicio :: GuerreroZ -> Ejercicio -> GuerreroZ
realizarEjercicio unGuerrero unEjercicio
  | estaExhausto unGuerrero = agregarKi (- ki unGuerrero * 0.2) unGuerrero
  | estaCansado unGuerrero = agregarFatiga (4 * aumentoDeFatiga) . agregarKi (2 * aumentoDeKi) . unEjercicio $ unGuerrero
  | otherwise = unEjercicio unGuerrero
  where
    aumentoDeKi = (ki . unEjercicio) unGuerrero - ki unGuerrero
    aumentoDeFatiga = (fatiga . unEjercicio) unGuerrero - fatiga unGuerrero

--------------
-- Punto 04 --
--------------
type Rutina = [Ejercicio]

type Personalidad = Rutina -> Rutina

agregarDescanso :: Int -> Ejercicio -> Ejercicio
agregarDescanso minutos unEjercicio = descansar minutos . unEjercicio

-- Personalidades
sacado :: Personalidad
sacado = id

perezoso :: Personalidad
perezoso = map (agregarDescanso 5)

tramposo :: Personalidad
tramposo _ = []

armarRutina :: GuerreroZ -> [Ejercicio] -> Rutina
armarRutina = personalidad

{-
Si se quisiera armar una rutina con infinitos ejercicios, el resultado depende la personalidad del guerrero:
    si es tramposo: El resultado puede conocerse debido a que el tramposo no realiza ningún ejercicio, por ende, la lista
    de ejercicios de la rutina modificada por esta personalidad del guerrero, sería vacía.

    si no es tramposo: El resultado no puede conocerse por completo, ya que debería devolverse la lista de ejercicios modificada
    según la personalidad del guerrero, y por más que esta comienze a mostrarse, nunca terminaría, se quedaría imprimiendo infinitamente los ejercicios.
-}
--------------
-- Punto 05 --
--------------
realizarRutina :: GuerreroZ -> Rutina -> GuerreroZ
realizarRutina = foldl realizarEjercicio

--------------
-- Punto 06 --
--------------
descansar :: Int -> GuerreroZ -> GuerreroZ
descansar unosMinutos = agregarFatiga (- cansancioDeMinutos unosMinutos)

cansancioDeMinutos :: Int -> Float
cansancioDeMinutos unosMinutos = fromIntegral . sum $ [0 .. unosMinutos]

--------------
-- Punto 07 --
--------------
cantidadOptimaDeMinutos :: GuerreroZ -> Int
cantidadOptimaDeMinutos unGuerrero = length . takeWhile estaCansado . map (`descansar` unGuerrero) $ [0 ..]