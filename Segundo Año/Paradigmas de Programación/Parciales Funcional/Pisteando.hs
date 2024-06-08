---------------
--- Punto 1 ---
---------------
data Auto = Auto
  { marca :: String,
    modelo :: String,
    desgaste :: (Chasis, Ruedas),
    velocidadMaxima :: Int,
    tiempoCarrera :: Int
  }
  deriving (Show)

type Chasis = Int

type Ruedas = Int

-- a.
ferrari :: Auto
ferrari = Auto "Ferrari" "F50" (0, 0) 65 0

-- b.
lamborghini :: Auto
lamborghini = Auto "Lamborghini" "Diablo" (7, 4) 73 0

-- c.
fiat :: Auto
fiat = Auto "Fiat" "600" (33, 27) 44 0

---------------
--- Punto 2 ---
---------------
-- a.
estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado unAuto = desgasteChasis unAuto < 40 && desgasteRuedas unAuto < 60

desgasteChasis :: Auto -> Chasis
desgasteChasis = fst . desgaste

desgasteRuedas :: Auto -> Ruedas
desgasteRuedas = snd . desgaste

-- b.
noDaMas :: Auto -> Bool
noDaMas unAuto = desgasteChasis unAuto > 80 || desgasteRuedas unAuto > 80

---------------
--- Punto 3 ---
---------------
reparar :: Auto -> Auto
reparar = reducirDesgasteRuedas 100 . reducirDesgasteChasis 85

reducirDesgasteChasis :: Int -> Auto -> Auto
reducirDesgasteChasis porcentaje unAuto = unAuto {desgaste = (restarPorcentaje (desgasteChasis unAuto) 85, desgasteRuedas unAuto)}

reducirDesgasteRuedas :: Int -> Auto -> Auto
reducirDesgasteRuedas porcentaje unAuto = unAuto {desgaste = (desgasteChasis unAuto, restarPorcentaje (desgasteRuedas unAuto) 100)}

restarPorcentaje :: Int -> Int -> Int
restarPorcentaje numero porcentaje = numero - numero * porcentaje `div` 100

---------------
--- Punto 4 ---
---------------
type Tramo = Auto -> Auto

-- a.
curva :: Int -> Int -> Tramo
curva angulo longitud unAuto = sumarTiempo (div longitud (velocidadMaxima unAuto `div` 2)) . desgastarRuedas (3 * longitud `div` angulo) $ unAuto

desgastarRuedas :: Int -> Auto -> Auto
desgastarRuedas valor unAuto = unAuto {desgaste = (desgasteChasis unAuto, sumarDesgaste (desgasteRuedas unAuto) valor)}

desgastarChasis :: Int -> Auto -> Auto
desgastarChasis valor unAuto = unAuto {desgaste = (sumarDesgaste (desgasteChasis unAuto) valor, desgasteRuedas unAuto)}

sumarDesgaste :: Int -> Int -> Int
sumarDesgaste = (+)

sumarTiempo :: Int -> Auto -> Auto
sumarTiempo unTiempo unAuto = unAuto {tiempoCarrera = tiempoCarrera unAuto + unTiempo}

-- i.
curvaPeligrosa :: Tramo
curvaPeligrosa = curva 60 300

-- ii.
curvaTranca :: Tramo
curvaTranca = curva 110 550

--- b.
tramoRecto :: Int -> Tramo
tramoRecto longitud unAuto = sumarTiempo (longitud `div` velocidadMaxima unAuto) . desgastarChasis (longitud `div` 100) $ unAuto

-- i.
tramoRectoClassic :: Tramo
tramoRectoClassic = tramoRecto 750

-- ii.
tramito :: Tramo
tramito = tramoRecto 280

-- c.
boxes :: Tramo -> Tramo
boxes unTramo unAuto
  | estaEnBuenEstado unAuto = unTramo unAuto
  | otherwise = sumarTiempo 10 . reparar $ unAuto

-- d.
tramoMojado :: Tramo -> Tramo
tramoMojado unTramo unAuto = sumarTiempo (div tiempoAgegadoPorElTramo 2) . unTramo $ unAuto
  where
    tiempoAgegadoPorElTramo = (tiempoCarrera . unTramo) unAuto - tiempoCarrera unAuto

-- e.
tramoRipio :: Tramo -> Tramo
tramoRipio = dobleEfecto

dobleEfecto :: Tramo -> Tramo
dobleEfecto unTramo = unTramo . unTramo

-- f.
tramoObstruido :: Int -> Tramo -> Tramo
tramoObstruido metros unTramo = desgastarRuedas (2 * metros)

---------------
--- Punto 5 ---
---------------
pasarPorTramo :: Auto -> Tramo -> Auto
pasarPorTramo unAuto unTramo
  | puedeSeguir unAuto = unTramo unAuto
  | otherwise = unAuto

puedeSeguir :: Auto -> Bool
puedeSeguir = not . noDaMas

---------------
--- Punto 6 ---
---------------
-- a.
type Pista = [Tramo]

superPista :: Pista
superPista = [tramoRectoClassic, curvaTranca, tramoMojado tramito, tramito, tramoObstruido 2 (curva 80 400), curva 115 650, tramoRecto 970, curvaPeligrosa, tramoRipio tramito, boxes (tramoRecto 800)]

-- b.
peganLaVuelta :: Pista -> [Auto] -> [Auto]
peganLaVuelta unaPista autos = foldl (flip pasanPorTramo) autos unaPista

pasanPorTramo :: Tramo -> [Auto] -> [Auto]
pasanPorTramo unTramo = filter puedeSeguir . map (`pasarPorTramo` unTramo)

---------------
--- Punto 7 ---
---------------
-- a.
data Carrera = Carrera
  { pista :: Pista,
    vueltas :: Int
  }

-- b.
tourBuenosAires :: Carrera
tourBuenosAires = Carrera superPista 20

-- c.
jugarCarrera :: Carrera -> [Auto] -> [[Auto]]
jugarCarrera unaCarrera = take (vueltas unaCarrera) . iterate (peganLaVuelta (pista unaCarrera))

-- Autos de prueba
listaAutos :: [Auto]
listaAutos = [ferrari, lamborghini, fiat]

{-
 Simulación
-- ghci> jugarCarrera tourBuenosAires listaAutos
[[Auto {marca = "Ferrari", modelo = "F50", desgaste = (0,0), velocidadMaxima = 65, tiempoCarrera = 0},Auto {marca = "Lamborghini", modelo = "Diablo", desgaste = (7,4),
velocidadMaxima = 73, tiempoCarrera = 0},Auto {marca = "Fiat", modelo = "600", desgaste = (33,27), velocidadMaxima = 44, tiempoCarrera = 0}],[Auto {marca = "Ferrari", modelo = "F50", desgaste = (32,50), velocidadMaxima = 65, tiempoCarrera = 101},Auto {marca = "Lamborghini", modelo = "Diablo", desgaste = (39,54), velocidadMaxima = 73,
tiempoCarrera = 87},Auto {marca = "Fiat", modelo = "600", desgaste = (9,0), velocidadMaxima = 44, tiempoCarrera = 143}],[Auto {marca = "Fiat", modelo = "600", desgaste
= (41,50), velocidadMaxima = 44, tiempoCarrera = 294}],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
-}