import Control.Monad (replicateM)

---------------
--- Punto 1 ---
---------------
data Animal = Animal
  { coeficienteIntelectual :: Int,
    especie :: String,
    capacidades :: [Capacidad]
  }
  deriving (Show)

type Capacidad = String

-- Ejemplos de animales
delfin :: Animal
delfin = Animal 90 "Delfin" ["Ecolocación", "Natación rápida", "Comunicación compleja"]

perro :: Animal
perro = Animal 60 "Perro" ["Olfato agudo", "Lealtad", "Entrenamiento"]

cuervo :: Animal
cuervo = Animal 85 "Cuervo" ["Uso de herramientas", "Memoria", "Resolución de problemas"]

raton :: Animal
raton = Animal 17 "Raton" ["Destruenglonir el mundo", "Hacer planes desalmados"]

---------------
--- Punto 2 ---
---------------
type Transformacion = Animal -> Animal

inteligenciaSuperior :: Int -> Transformacion
inteligenciaSuperior n unAnimal = unAnimal {coeficienteIntelectual = coeficienteIntelectual unAnimal + n}

pinkificar :: Transformacion
pinkificar unAnimal = unAnimal {capacidades = []}

superpoderes :: Transformacion
superpoderes unAnimal
  | es "Elefante" unAnimal = agregarCapacidad "No tenerle miedo a los ratones" unAnimal
  | es "Raton" unAnimal && coeficienteIntelectual unAnimal > 100 = agregarCapacidad "Hablar" unAnimal
  | otherwise = unAnimal

es :: String -> Animal -> Bool
es talEspecie = (== talEspecie) . especie

agregarCapacidad :: Capacidad -> Animal -> Animal
agregarCapacidad nuevaCapacidad unAnimal = unAnimal {capacidades = nuevaCapacidad : capacidades unAnimal}

---------------
--- Punto 3 ---
---------------
type Criterio = Animal -> Bool

antropomorfico :: Criterio
antropomorfico unAnimal = sabe "Hablar" unAnimal && coeficienteIntelectual unAnimal > 60

sabe :: Capacidad -> Animal -> Bool
sabe hacerAlgo = elem hacerAlgo . capacidades

noTanCuerdo :: Criterio
noTanCuerdo = (> 2) . length . filter pinkiesco . capacidades

pinkiesco :: Capacidad -> Bool
pinkiesco unaCapacidad = ((== "hacer") . head . words $ unaCapacidad) && (esPalabraPinkiesca . (!! 1) . words $ unaCapacidad)

esPalabraPinkiesca :: String -> Bool
esPalabraPinkiesca unaPalabra = ((<= 4) . length $ unaPalabra) && any esVocal unaPalabra

esVocal :: Char -> Bool
esVocal letra = letra `elem` "aeiouAEIOU"

---------------
--- Punto 4 ---
---------------
type Experimento = ([Transformacion], Criterio)

transformaciones :: Experimento -> [Transformacion]
transformaciones = fst

criterio :: Experimento -> Criterio
criterio = snd

experimentoExitoso :: Experimento -> Animal -> Bool
experimentoExitoso unExperimento = criterio unExperimento . aplicarExperimento unExperimento

aplicarTransformacion :: Animal -> Transformacion -> Animal
aplicarTransformacion unAnimal unaTransformacion = unaTransformacion unAnimal

aplicarExperimento :: Experimento -> Animal -> Animal
aplicarExperimento unExperimento unAnimal = foldl aplicarTransformacion unAnimal . transformaciones $ unExperimento

-- Experimento de prueba
experimento0 :: Experimento
experimento0 = ([pinkificar, inteligenciaSuperior 10, superpoderes], antropomorfico)

{-
Consulta:
ghci > experimentoExitoso experimento0 raton
ghci > False
-}

---------------
--- Punto 5 ---
---------------
resultados :: (Animal -> a) -> Criterio -> Experimento -> [Animal] -> [a]
resultados parametro condicion unExperimento = map parametro . filter condicion . map (aplicarExperimento unExperimento)

reporte1 :: [Capacidad] -> Experimento -> [Animal] -> [Int]
reporte1 unasCapacidades = resultados coeficienteIntelectual (any (`elem` unasCapacidades) . capacidades)

reporte2 :: [Capacidad] -> Experimento -> [Animal] -> [String]
reporte2 unasCapacidades = resultados especie (all (`elem` unasCapacidades) . capacidades)

reporte3 :: [Capacidad] -> Experimento -> [Animal] -> [Int]
reporte3 unasCapacidades = resultados (length . capacidades) (not . any (`elem` unasCapacidades) . capacidades)

{-
Se generalizó la lógica de mapear la lista de animales aplicando el experimento, luego filtrarla
según una condición, y luego mapearla según un parámetro en una función "resultados".
-}

---------------
--- Punto 6 ---
---------------
{-
Dentro de un experimento tenemos transformaciones y un criterio de éxito, todas las transformaciones
desarrolladas pueden aplicarse sobre un animal con infinitas capacidades, ya que ninguna requiere recorrer
la lista completa de capacidades, y dentro de los criterios, el antropom+orfico arrojará resultado en tanto
y en cuanto el animal sepa Hablar, ya que si no lo sabe se quedará recorriendo la lista infinitamente, no pudiendo
determinar si sabe Hablar o no, mientras que para el criterio noTanCuerdo, podría llegar a arrojar un resultado parcialmente,
sin embargo, la función filter se quedará recorriendo infinitamente la lista de capacidades por más que ya no haya más
pinkiescas, por ello un experimento que posea dicho criterio no arrojaría nunca resultado para un animal con capacidades
infinitas.
-}

---------------
--- Punto 7 ---
---------------
palabrasPinkiescas :: [String]
palabrasPinkiescas = filter (any esVocal) . generateWordsUpTo $ 4

generateWordsUpTo :: Int -> [String]
generateWordsUpTo n = concatMap (`replicateM` (['a' .. 'z'] ++ ['A' .. 'Z'])) [1 .. n]