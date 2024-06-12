import Text.Show.Functions ()

--------------
-- Punto 01 --
--------------
data Plomero = Plomero
  { nombre :: String,
    cajaHerramientas :: [Herramienta],
    historialReparaciones :: [Reparacion],
    dinero :: Int
  }
  deriving (Show)

data Herramienta = Herramienta
  { denominacion :: String,
    precio :: Int,
    materialEmpuniadura :: Material
  }
  deriving (Show)

data Material = Hierro | Madera | Goma | Plastico deriving (Show, Eq)

-- a --
mario :: Plomero
mario = Plomero "Mario" [llaveInglesa, martillo] [] 1200

llaveInglesa :: Herramienta
llaveInglesa = Herramienta "Llave inglesa" 200 Hierro

martillo :: Herramienta
martillo = Herramienta "Martillo" 20 Madera

-- b --
wario :: Plomero
wario = Plomero "Wario" (iterate (modificarPrecio (+ 1)) llaveFrancesa) [] 50

llaveFrancesa :: Herramienta
llaveFrancesa = Herramienta "Llave francesa" 1 Hierro

modificarPrecio :: (Int -> Int) -> Herramienta -> Herramienta
modificarPrecio unaOperacion unaHerramienta = unaHerramienta {precio = unaOperacion . precio $ unaHerramienta}

--------------
-- Punto 02 --
--------------
-- a --
tieneHerramienta :: String -> Plomero -> Bool
tieneHerramienta unaDenominacion = elem unaDenominacion . map denominacion . cajaHerramientas

-- b --
esMalvado :: Plomero -> Bool
esMalvado = (== "Wa") . take 2 . nombre

-- c --
puedeComprar :: Herramienta -> Plomero -> Bool
puedeComprar unaHerramienta = (>= precio unaHerramienta) . dinero

--------------
-- Punto 03 --
--------------
esBuena :: Herramienta -> Bool
esBuena (Herramienta _ precio Hierro) = precio > 10000
esBuena (Herramienta "Martillo" _ material) = material == Madera || material == Goma
esBuena _ = False

--------------
-- Punto 04 --
--------------
comprar :: Herramienta -> Plomero -> Plomero
comprar unaHerramienta unPlomero
  | puedeComprar unaHerramienta unPlomero = agregarHerramienta unaHerramienta . modificarDinero (+ (-precio unaHerramienta)) $ unPlomero
  | otherwise = unPlomero

agregarHerramienta :: Herramienta -> Plomero -> Plomero
agregarHerramienta unaHerramienta unPlomero = unPlomero {cajaHerramientas = unaHerramienta : cajaHerramientas unPlomero}

modificarDinero :: (Int -> Int) -> Plomero -> Plomero
modificarDinero unaOperacion unPlomero = unPlomero {dinero = unaOperacion (dinero unPlomero)}

--------------
-- Punto 05 --
--------------
-- a --
data Reparacion = Reparacion
  { descripcion :: String,
    requerimiento :: Plomero -> Bool
  }
  deriving (Show)

filtracionDeAgua :: Reparacion
filtracionDeAgua = Reparacion "Filtracion de agua" (tieneHerramienta "Llave inglesa")

-- b --
esDificil :: Reparacion -> Bool
esDificil unaReparacion = (esComplicada . descripcion) unaReparacion && (esUnGrito . descripcion) unaReparacion

esComplicada :: String -> Bool
esComplicada = (> 100) . length

esUnGrito :: String -> Bool
esUnGrito = all esMayuscula

esMayuscula :: Char -> Bool
esMayuscula = flip elem ['A' .. 'Z']

-- c --
presupuesto :: Reparacion -> Int
presupuesto = (3 *) . length . descripcion

--------------
-- Punto 06 --
--------------
hacerReparacion :: Plomero -> Reparacion -> Plomero
hacerReparacion unPlomero unaReparacion
  | puedeResolver unaReparacion unPlomero = agregarReparacion unaReparacion . modificarDinero (+ presupuesto unaReparacion) $ unPlomero
  | otherwise = modificarDinero (+ 100) unPlomero

agregarReparacion :: Reparacion -> Plomero -> Plomero
agregarReparacion unaReparacion unPlomero = unPlomero {historialReparaciones = unaReparacion : historialReparaciones unPlomero}

puedeResolver :: Reparacion -> Plomero -> Bool
puedeResolver unaReparacion unPlomero = requerimiento unaReparacion unPlomero || esMalvado unPlomero

--------------
-- Punto 07 --
--------------
trabajar :: Plomero -> [Reparacion] -> Plomero
trabajar = foldl hacerReparacion

--------------
-- Punto 08 --
--------------
type Criterio = Plomero -> Int

maximoSegun :: (Ord b) => (a -> b) -> [a] -> a
maximoSegun f [x] = x
maximoSegun f (x : y : ys)
  | f x > f y = maximoSegun f (x : ys)
  | otherwise = maximoSegun f (y : ys)

cantidadReparaciones :: Plomero -> Int
cantidadReparaciones = length . historialReparaciones

empleadoConMayor :: Criterio -> [Reparacion] -> [Plomero] -> Plomero
empleadoConMayor unCriterio jornadaLaboral = maximoSegun unCriterio . map (`trabajar` jornadaLaboral)

plataInvertida :: Plomero -> Int
plataInvertida = sum . map precio . cajaHerramientas

-- a --
masReparador :: [Reparacion] -> [Plomero] -> Plomero
masReparador = empleadoConMayor cantidadReparaciones

-- b --
masAdinerado :: [Reparacion] -> [Plomero] -> Plomero
masAdinerado = empleadoConMayor dinero

-- c --
masInversor :: [Reparacion] -> [Plomero] -> Plomero
masInversor = empleadoConMayor plataInvertida