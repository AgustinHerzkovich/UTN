---------------
--- Punto 1 ---
---------------
-- a.
data Pais = UnPais
  { ingresoPerCapita :: Float,
    sectorPublico :: Int,
    sectorPrivado :: Int,
    riquezasNaturales :: [Recurso],
    deudaFMI :: Float
  }
  deriving (Show)

type Recurso = String

-- b.
namibia :: Pais
namibia = UnPais 4140 400000 650000 ["mineria", "ecoturismo"] 50

---------------
--- Punto 2 ---
---------------
type Estrategia = Pais -> Pais

-- Funciones auxiliares
endeudar :: Float -> Pais -> Pais
endeudar deuda unPais = unPais {deudaFMI = deudaFMI unPais + deuda}

disminuirPerCapita :: Pais -> Pais
disminuirPerCapita unPais
  | sectorPublico unPais > 100 = reducirPorcentaje 20 unPais
  | otherwise = reducirPorcentaje 15 unPais

reducirPorcentaje :: Float -> Pais -> Pais
reducirPorcentaje x unPais = unPais {ingresoPerCapita = ingresoPerCapita unPais - ingresoPerCapita unPais * x / 100}

reducirActivosPublicos :: Int -> Pais -> Pais
reducirActivosPublicos cantidad unPais = unPais {sectorPublico = sectorPublico unPais - cantidad}

quitarRecurso :: Recurso -> Pais -> Pais
quitarRecurso unRecurso unPais = unPais {riquezasNaturales = filter (/= unRecurso) . riquezasNaturales $ unPais}

disminuirDeuda :: Float -> Pais -> Pais
disminuirDeuda millones = endeudar (-millones)

pbi :: Pais -> Float
pbi unPais = ingresoPerCapita unPais * fromIntegral (poblacionActiva unPais)

poblacionActiva :: Pais -> Int
poblacionActiva unPais = sectorPublico unPais + sectorPrivado unPais

-- Estrategias
prestarNMillones :: Float -> Estrategia
prestarNMillones n = endeudar (150 / 100 * n)

reducirSectorPublico :: Int -> Estrategia
reducirSectorPublico x = disminuirPerCapita . reducirActivosPublicos x

darExplotacion :: Recurso -> Estrategia
darExplotacion recursoNatural = quitarRecurso recursoNatural . disminuirDeuda 2

establecerBlindaje :: Estrategia
establecerBlindaje unPais = reducirSectorPublico 500 . prestarNMillones (pbi unPais / 2) $ unPais

---------------
--- Punto 3 ---
---------------
type Receta = [Estrategia]

-- a.
receta1 :: Receta
receta1 = [prestarNMillones 200, darExplotacion "mineria"]

-- b.
aplicarReceta :: Pais -> Receta -> Pais
aplicarReceta = foldr ($)

-- ghci> aplicarReceta namibia receta1
{-
El efecto colateral se logra debido a que el foldr ($) aplica el país
con la primer estrategia de la receta, luego el resultado de eso da otro país,
el cual se aplica a la estrategia que sigue, y así sucesivamente hasta que no queden
estrategias por aplicar. El resultado final es el país luego de pasar por todas las
estrategias de la receta, de izquierda a derecha.
-}
---------------
--- Punto 4 ---
---------------
-- a.
zafadores :: [Pais] -> [Pais]
zafadores = filter (elem "petroleo" . riquezasNaturales)

-- b.
totalDeuda :: [Pais] -> Float
totalDeuda = sum . map deudaFMI

-- c.
{-
En ambas funciones aparecen los 3 conceptos:
  -Orden superior por las funciones filter y map, que reciben una
  función y una lista como parámetros.
  -Composición para componer riquezasNaturales con elem "petroleo" y
  poder filtrar la lista, y para componer sum con map y sumar toda
  la lista ya mapeada.
  -Aplicación parcial ya que las funciones filter y map están siendo
  aplicadas sólo pasándole su primer parámetro, porque el segundo
  está implícito, además elem "petroleo" también es una aplicación
  parcial.
-}
---------------
--- Punto 5 ---
---------------
estaOrdenadaPeorAMejor :: [Receta] -> Pais -> Bool
estaOrdenadaPeorAMejor [_] _ = True
estaOrdenadaPeorAMejor (receta1 : receta2 : recetas) unPais = (pbi . aplicarReceta unPais) receta1 <= (pbi . aplicarReceta unPais) receta2 && estaOrdenadaPeorAMejor (receta2 : recetas) unPais

---------------
--- Punto 6 ---
---------------
recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

-- a.
{-
Al evaluar la función zafadores con ese país no mostrará ningún resultado, ya que
el filter necesita evaluar toda la lista de recursos para determinar cuáles son "petroleo", sin embargo,
en esta lista infinita de recursos, nunca terminará de recorrerla, por lo que no podrá determinar nunca cuáles son los países zafadores.
-}

-- b.
{-
Esta función sí puede evaluarse, ya que lo que influye es la deuda con el FMI, no los recursos naturales,
por lo que sin problemas podrá mapear los países con la función deudaFMI, y luego sumar todos los resultados.
-}