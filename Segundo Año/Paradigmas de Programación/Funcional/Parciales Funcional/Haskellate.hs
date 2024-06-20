-------------------
-- Primera parte --
-------------------
--------------
-- Punto 01 --
--------------
data Chocolate = Chocolate
  { nombreFancy :: String,
    ingredientes :: [Ingrediente],
    peso :: Float,
    porcentajeCacao :: Float,
    porcentajeAzucar :: Float
  }
  deriving (Show)

type Ingrediente = (String, Float)

nombreIngrediente :: Ingrediente -> String
nombreIngrediente = fst

calorias :: Ingrediente -> Float
calorias = snd

-- Funciones auxiliares
precioPremium :: Chocolate -> Float
precioPremium unChocolate
  | esAptoParaDiabeticos unChocolate = 8 * peso unChocolate
  | otherwise = 5 * peso unChocolate

esAptoParaDiabeticos :: Chocolate -> Bool
esAptoParaDiabeticos = (== 0) . porcentajeAzucar

esAmargo :: Chocolate -> Bool
esAmargo = (> 60) . porcentajeCacao

cantidadIngredientes :: Chocolate -> Float
cantidadIngredientes = fromIntegral . length . ingredientes

-- Cálculo de precio
precioChocolate :: Chocolate -> Float
precioChocolate unChocolate
  | esAmargo unChocolate = peso unChocolate * precioPremium unChocolate
  | cantidadIngredientes unChocolate > 4 = 8 * cantidadIngredientes unChocolate
  | otherwise = 1.5 * peso unChocolate

--------------
-- Punto 02 --
--------------
esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((> 200) . calorias) . ingredientes

totalCalorias :: Chocolate -> Float
totalCalorias = sum . map calorias . ingredientes

aptoParaNinios :: [Chocolate] -> [Chocolate]
aptoParaNinios = take 3 . filter (not . esBombonAsesino)

-------------------
-- Segunda parte --
-------------------
type Modificacion = Chocolate -> Chocolate

-- Funciones auxiliares
agregarIngrediente :: Ingrediente -> Chocolate -> Chocolate
agregarIngrediente unIngrediente unChocolate = unChocolate {ingredientes = unIngrediente : ingredientes unChocolate}

agregarAlFinal :: String -> Chocolate -> Chocolate
agregarAlFinal unaPalabra unChocolate = unChocolate {nombreFancy = nombreFancy unChocolate ++ unaPalabra}

modificarAzucar :: (Float -> Float) -> Chocolate -> Chocolate
modificarAzucar unaOperacion unChocolate = unChocolate {porcentajeAzucar = unaOperacion (porcentajeAzucar unChocolate)}

--------------
-- Punto 03 --
--------------
-- Modificaciones
frutalizado :: Float -> String -> Modificacion
frutalizado unidades nombreFruta = agregarIngrediente (nombreFruta, 2 * unidades)

dulceDeLeche :: Modificacion
dulceDeLeche = agregarAlFinal " tentación" . agregarIngrediente ("dulce de leche", 220)

celiaCrucera :: Float -> Modificacion
celiaCrucera porcentajeDeAzucar = modificarAzucar (+ porcentajeDeAzucar)

embriagadora :: Float -> Modificacion
embriagadora gradoAlcohol = modificarAzucar (+ 20) . agregarIngrediente ("licor", min 30 gradoAlcohol)

--------------
-- Punto 04 --
--------------
type Receta = [Modificacion]

recetaEjemplo :: [Modificacion]
recetaEjemplo = [frutalizado 10 "naranja", dulceDeLeche, embriagadora 32]

--------------
-- Punto 05 --
--------------
chocolateResultante :: Chocolate -> Receta -> Chocolate
chocolateResultante = foldr ($)

------------------
-- Última parte --
------------------
data Persona = Persona
  { limiteSaturacion :: Float,
    criterioIngredientes :: Ingrediente -> Bool
  }

juan :: Persona
juan = Persona 800 ((/= "naranja") . nombreIngrediente)

--------------
-- Punto 06 --
--------------
comer :: Persona -> Chocolate -> Persona
comer unaPersona unChocolate = unaPersona {limiteSaturacion = limiteSaturacion unaPersona - totalCalorias unChocolate}

hastaAcaLlegue :: Persona -> [Chocolate] -> [Chocolate]
hastaAcaLlegue _ [] = []
hastaAcaLlegue unaPersona (chocolate : chocolates)
  | (not . all (criterioIngredientes unaPersona) . ingredientes) chocolate = hastaAcaLlegue unaPersona chocolates
  | limiteSaturacion unaPersona /= 0 = chocolate : hastaAcaLlegue (comer unaPersona chocolate) chocolates
  | otherwise = []

--------------
-- Punto 07 --
--------------
{-
En el caso de aptoParaNinios, si en la lista infinita no hay aunque sea 3 chocolates que NO sean bombones asesinos, no se podrá
determinar por completo el resultado, ya que se seguirá filtrando hasta encontrar mínimo 3 para poder tomarlos, y nunca los encontrará, por ello, puede llegar a
retornar un resultado parcial, o tal vez no retornar nada. Si hay 3 que cumplan la condición le basta para luego tomarlos y en ese caso, sí devuelve un resultado
completo, ya que, producto de la evaluación perezosa, no precisa continuar evaluando la lista.

En el caso de totalCalorias', no se podría determinar un resultado ya que la sumatoria de todos las calorías de los chocolates nunca
convergería a su caso base, que es cuando la lista de chocolates es vacía, por ende, no se puede saber el resultado.
-}