import Text.Show.Functions()
--------------
-- Punto 01 --
--------------
data Persona = Persona{
    nombre :: String,
    deuda :: Int,
    felicidad :: Float,
    tieneEsperanza :: Bool,
    estrategiaEleccion ::  Criterio
} deriving(Show)
type Criterio = Persona -> Bool

-- Criterios para elegir un candidato
conformista :: Criterio
conformista _ = True

esperanzado :: Bool -> Criterio
esperanzado gradoDeEsperanza unCandidato = ((== gradoDeEsperanza) . tieneEsperanza) unCandidato || ((>50) . felicidad) unCandidato

economico :: Int -> Criterio
economico cantidadPesos = (<cantidadPesos) . deuda

combinado :: Criterio
combinado unCandidato = esperanzado True unCandidato || economico 500 unCandidato

type Pais = [Persona]

-- Ejemplos
silvia :: Persona
silvia = Persona "Silvia" 500 10 True conformista

lara :: Persona
lara = Persona "Lara" 700 2 False (economico 1000)

manuel :: Persona
manuel = Persona "Manuel" 500 25 False combinado

victor :: Persona
victor = Persona "Victor" 50 95 False (esperanzado True)

paradigimia :: Pais
paradigimia = [silvia,lara,manuel,victor]
--------------
-- Punto 02 --
--------------
isVowel :: Char -> Bool
isVowel character = character `elem` "aeiou"

-- a --
alguienConMasDeDosVocales :: Pais -> Bool
alguienConMasDeDosVocales = any ((> 2) . length . filter isVowel . nombre)

-- b --
totalDeudasPares :: Pais -> Int
totalDeudasPares = sum . map  deuda . filter (even . deuda)
--------------
-- Punto 03 --
--------------
type Candidato = Persona -> Persona

modificarDeuda :: (Int -> Int) -> Persona -> Persona
modificarDeuda unaOperacion unaPersona = unaPersona{deuda = unaOperacion (deuda unaPersona)}

modificarEsperanza :: Bool -> Persona -> Persona
modificarEsperanza valorDeEsperanza unaPersona = unaPersona{tieneEsperanza = valorDeEsperanza}

modificarFelicidad :: (Float -> Float) -> Persona -> Persona
modificarFelicidad unaOperacion unaPersona = unaPersona{felicidad = unaOperacion (felicidad unaPersona)}

-- Candidatos
yrygoyen :: Persona -> Persona
yrygoyen = modificarDeuda (`div` 2)

alende :: Persona -> Persona
alende = modificarFelicidad (* 1.1). modificarEsperanza True

alsogaray :: Persona -> Persona
alsogaray = modificarDeuda (+ 100) . modificarEsperanza False

martinezRaymonda :: Persona -> Persona
martinezRaymonda = alende . yrygoyen
--------------
-- Punto 04 --
--------------
aQuienesVotaria :: Persona -> [Candidato] -> [Candidato]
aQuienesVotaria _ [] = []
aQuienesVotaria unaPersona (candidato : candidatos)
    | estrategiaEleccion unaPersona (candidato unaPersona) = candidato : aQuienesVotaria unaPersona candidatos
    | otherwise = []
--------------
-- Punto 05 --
--------------
comoQuedaria :: Persona -> [Candidato] -> Persona
comoQuedaria unaPersona unosCandidatos = foldl (flip id) unaPersona (aQuienesVotaria unaPersona unosCandidatos)

{-
Si se pasara una lista infinita de candidatos a la función del punto anterior, el resultado depende:
    Si todos los candidatos de la lista infinita cumplen la promesa de la persona nunca se podrá saber el resultado,
    ya que requerriría recorrer la lista completa hasta que se vacíe para volver al converger al caso base de la función,
    y esto nunca ocurriría, por ende, no muestra resultado.

    Si al menos un candidato de la lista no cumple la promesa de la persona, muestra un resultado, ya que la función se detiene
    en ese punto y corta, quedándose con una cantidad finita de candidatos.
-}