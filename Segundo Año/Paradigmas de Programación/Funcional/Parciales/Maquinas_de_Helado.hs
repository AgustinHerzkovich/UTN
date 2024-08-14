type Helado = (String, Int, Float)

primero :: (a, b, c) -> a
primero (a, b, c) = a

segundo :: (a, b, c) -> b
segundo (a, b, c) = b

tercero :: (a, b, c) -> c
tercero (a, b, c) = c

gusto :: Helado -> String
gusto = primero

temperatura :: Helado -> Int
temperatura = segundo

proporcionAguaFruta :: Helado -> Float
proporcionAguaFruta = tercero

---------------
--- Punto 1 ---
---------------
salioMal :: Helado -> Bool
salioMal unHelado = (not . seCongelo) unHelado || (not . tieneProporcionCorrecta) unHelado

seCongelo :: Helado -> Bool
seCongelo = (<= 0) . temperatura

tieneProporcionCorrecta :: Helado -> Bool
tieneProporcionCorrecta (sabor, _, proporcion)
  | sabor == "frutilla" = proporcion == 0.4
  | sabor == "durazno" = proporcion >= 0.2 && proporcion <= 0.6
  | length sabor < 8 = proporcion == fromIntegral (length sabor `div` 10)
  | otherwise = proporcion == fromIntegral (cantidadDeVocales sabor `div` 10)

cantidadDeVocales :: String -> Int
cantidadDeVocales = length . filter esVocal

esVocal :: Char -> Bool
esVocal unaLetra = unaLetra `elem` "AEIOUaeiou"

---------------
--- Punto 2 ---
---------------
-- a.
heladera :: Int -> Helado -> Helado
heladera grados unHelado
  | grados < temperatura unHelado = (gusto unHelado, grados, proporcionAguaFruta unHelado)
  | otherwise = unHelado

-- b.
batidora :: BidonAgua -> CajonFruta -> Helado
batidora bidon cajon = (fruta cajon, temperaturaAgua bidon, litros bidon / peso cajon)

data CajonFruta = CajonFruta
  { fruta :: String,
    peso :: Float
  }

data BidonAgua = BidonAgua
  { litros :: Float,
    temperaturaAgua :: Int
  }

-- c.
exprimidora :: CajonFruta -> CajonFruta
exprimidora cajonNatural = cajonNatural {peso = peso cajonNatural - peso cajonNatural * 0.5}

-- d.
mixturadora :: Helado -> Helado -> Helado
mixturadora helado1 helado2 = (combinarGustos (gusto helado1) (gusto helado2), min (temperatura helado1) (temperatura helado2), promedio (proporcionAguaFruta helado1) (proporcionAguaFruta helado2))

combinarGustos :: String -> String -> String
combinarGustos gusto1 gusto2 = gusto1 ++ " y " ++ gusto2

promedio :: Float -> Float -> Float
promedio num1 = (/ 2) . (+) num1

-- e.
dispenser :: Float -> BidonAgua
dispenser cantidadAgua = BidonAgua cantidadAgua 0

---------------
--- Punto 3 ---
---------------
-- a.
cintaTransportadora :: (a -> b) -> (b -> c) -> (c -> d) -> (a -> d)
cintaTransportadora maquinaA maquinaB maquinaC = maquinaC . maquinaB . maquinaA

-- b.
cintaUnificadora :: (a -> b) -> (c -> d) -> (b -> d -> e) -> (a, c) -> e
cintaUnificadora maquinaA maquinaB maquinaC (entradaA, entradaB) = maquinaC (maquinaA entradaA) (maquinaB entradaB)

---------------
--- Punto 4 ---
---------------
-- a.
heladoA :: Helado
heladoA = cintaUnificadora dispenser exprimidora batidora (5, CajonFruta "frutilla" 10)

-- b.
heladoB :: Helado -> Helado -> Helado
heladoB = cintaTransportadora enfriar enfriar mixturadora

enfriar :: Helado -> Helado
enfriar = heladera 0

-- c.
heladoC :: (Float, CajonFruta) -> Helado
heladoC = cintaTransportadora (cintaUnificadora dispenser exprimidora batidora) (heladera 0) (heladera (-15))

---------------
--- Punto 5 ---
---------------
produccionEnSerie :: [CajonFruta] -> BidonAgua -> [Helado]
produccionEnSerie cajones bidon = filter (not . salioMal) (map (batidora bidon) cajones)

---------------
--- Punto 6 ---
---------------
{-
Reutilizables:
Tipos de datos:

BidonAgua: Este tipo de dato sigue siendo útil porque los bidones de agua son un insumo común.
CajonFruta (con una adaptación a CajonProducto): Podemos reutilizar la estructura pero cambiar su significado.

Funciones genéricas:

dispenser: La función que crea bidones de agua.
Funciones de combinación, como promedio, pueden ser útiles para mezclar ingredientes en proporciones específicas.

No reutilizables:
Funciones específicas para helados:

Funciones como salioMal, seCongelo, y tieneProporcionCorrecta no son reutilizables tal cual porque se basan en las reglas específicas para helados.

Conceptos de Programación:
Polimorfismo: Podemos usar funciones polimórficas que trabajan con diferentes tipos de datos.
Tipo: Cambiamos o adaptamos los tipos de datos para representar productos diferentes (de CajonFruta a CajonProducto).
Orden superior: Reutilizamos funciones de orden superior (como cintaTransportadora y cintaUnificadora) para combinar nuevas funciones de manera flexible.
-}
type Shampoo = (String, Int, Float) -- Nombre, temperatura, proporción de agua

data CajonProducto = CajonProducto
  { producto :: String,
    cantidad :: Float
  }
  deriving (Show)

type Proporcion = Float

mezcladora :: CajonProducto -> BidonAgua -> Proporcion -> Shampoo
mezcladora cajon bidon proporcion = (producto cajon, temperaturaAgua bidon + 50, proporcion)

elevadorDeTemperatura :: Shampoo -> Int -> Shampoo
elevadorDeTemperatura (nombre, temp, proporcion) incremento = (nombre, temp + incremento, proporcion)

cintaUnificadoraCosmetica :: (a -> b) -> (c -> d) -> (b -> d -> e) -> (a, c) -> e
cintaUnificadoraCosmetica maquinaA maquinaB maquinaC (entradaA, entradaB) = maquinaC (maquinaA entradaA) (maquinaB entradaB)

-- Ejemplo de fabricación de shampoo
cajonPerfume :: CajonProducto
cajonPerfume = CajonProducto "perfume" 2.0

bidonAgua :: BidonAgua
bidonAgua = dispenser 5.0

-- Máquina que eleva la temperatura del Shampoo en 10 grados
elevador10Grados :: Shampoo -> Shampoo
elevador10Grados shampoo = elevadorDeTemperatura shampoo 10

-- Combinamos la mezcladora y el elevador de temperatura usando cinta unificadora
produccionShampoo :: (CajonProducto, BidonAgua) -> Proporcion -> Shampoo
produccionShampoo (cajon, bidon) proporcion = cintaUnificadoraCosmetica
    (\cajon -> mezcladora cajon bidon proporcion) -- Aquí ajustamos la función
    (const proporcion) -- Se agrega la proporción directa para la cinta unificadora
    (\shampoo proporcion -> elevadorDeTemperatura shampoo 10)
    (cajon, ())