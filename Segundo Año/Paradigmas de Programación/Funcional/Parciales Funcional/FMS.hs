type Palabra = String

type Verso = String

type Estrofa = [Verso]

type Artista = String -- Solamente interesa el nombre

esVocal :: Char -> Bool
esVocal = flip elem "aeiou"

tieneTilde :: Char -> Bool
tieneTilde = flip elem "áéíóú"

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen f comp v1 v2 = comp (f v1) (f v2)

---------------
--- Punto 1 ---
---------------
-- Rimas
ultimasLetrasSi :: (Char -> Bool) -> Int -> Palabra -> String
ultimasLetrasSi condicion cantidad = take cantidad . reverse . filter condicion

nada :: Char -> Bool
nada _ = True

rimaAsonante :: Palabra -> Palabra -> Bool
rimaAsonante palabra1 palabra2 = ultimasLetrasSi esVocal 2 palabra1 == ultimasLetrasSi esVocal 2 palabra2

rimaConsonante :: Palabra -> Palabra -> Bool
rimaConsonante palabra1 palabra2 = ultimasLetrasSi nada 3 palabra1 == ultimasLetrasSi nada 3 palabra2

-- a.
riman :: Palabra -> Palabra -> Bool
riman palabra1 palabra2 = palabra1 /= palabra2 && (rimaAsonante palabra1 palabra2 || rimaConsonante palabra1 palabra2)

-- b.
{-
RimaAsonante_PalabrasDiferentes: parcial y estirar.
RimaConsonante_PalabrasDiferentes: función y canción.
PalabrasIguales_NoRiman: canción y canción.
NoRiman_PalabrasCompletamenteDiferentes: mesa y silla.
RimaAsonanteConTilde_PalabrasDiferentes: canción y razón.
RimaConsonanteConTilde_PalabrasDiferentes: acción y función.
PalabrasCortas_NoRimanConsonante: me y se.
PalabrasCortas_RimaAsonante: a y la.
RimaAsonante_DiferenteConsonanteFinal: amor y color.
TerminanEnMismaVocal_NoRimanConsonante: cielo y feo.
-}

---------------
--- Punto 2 ---
---------------
type Conjugacion = Verso -> Verso -> Bool

ultimaPalabra :: Verso -> Palabra
ultimaPalabra = last . words

primeraPalabra :: Verso -> Palabra
primeraPalabra = head . words

conjuganConRima :: Conjugacion
conjuganConRima verso1 verso2 = riman (ultimaPalabra verso1) (ultimaPalabra verso2)

conjuganConAnadiplosis :: Conjugacion
conjuganConAnadiplosis verso1 verso2 = ultimaPalabra verso1 == primeraPalabra verso2

---------------
--- Punto 3 ---
---------------
type Patron = Estrofa -> Bool

-- a.
-- Funciones Auxiliares
esVocalConTilde :: Char -> Bool
esVocalConTilde letra = esVocal letra || tieneTilde letra

esEsdrujula :: Palabra -> Bool
esEsdrujula = tieneTilde . (!! 2) . reverse . filter esVocalConTilde

-- Patrones
patronSimple :: Int -> Int -> Patron
patronSimple posicion1 posicion2 estrofa = conjuganConRima (estrofa !! posicion1) (estrofa !! posicion2)

patronEsdrujula :: Patron
patronEsdrujula = all (esEsdrujula . ultimaPalabra)

patronAnafora :: Patron
patronAnafora estrofa = all ((== (primeraPalabra . head) estrofa) . primeraPalabra) estrofa

patronCadena :: Conjugacion -> Patron
patronCadena conjugacion estrofa = all (uncurry conjugacion) . zip estrofa . tail $ estrofa

patronCombinaDos :: Patron -> Patron -> Patron
patronCombinaDos patron1 patron2 estrofa = patron1 estrofa && patron2 estrofa

-- b.
aabb :: Patron
aabb = patronCombinaDos (patronSimple 1 2) (patronSimple 3 4)

abab :: Patron
abab = patronCombinaDos (patronSimple 1 3) (patronSimple 2 4)

abba :: Patron
abba = patronCombinaDos (patronSimple 1 4) (patronSimple 2 3)

hardcore :: Patron
hardcore = patronCombinaDos (patronCadena conjuganConRima) patronEsdrujula

-- c.
{-
En el caso del patrón hardcore, depende, ya que para que la estrofa sea hardcore,
debe cumplir patronCadeena conjuganConRima y patronEsdrujula, y nunca podrá saberse si el resultado es True,
lo que si puede saberse es si NO cumple, ya que la evaluación de la función all es diferida, por ende cuando encuentre dos
versos que no se conjuguen, retorna false, pero en cambio si es verdadero, quedará procesando infinitamente, y el 
resultado no podrá saberse.

En el caso del patrón aabb, sí puede saberse el resultado ya que sólo se toman los versos en la posición 1, 2, 3 y 4,
es decir no se necesita evaluar a todos.
-}
---------------
--- Punto 4 ---
---------------
data PuestaEnEscena = PuestaEnEscena{
    publicoExaltado :: Bool,
    potencia :: Float,
    estrofaFreestyle :: Estrofa,
    artista :: Artista
}

type Estilo = PuestaEnEscena -> PuestaEnEscena

puestaBase :: Estrofa -> Artista -> PuestaEnEscena
puestaBase = PuestaEnEscena False 1

aumentarPotencia :: Float -> PuestaEnEscena -> PuestaEnEscena
aumentarPotencia porcentaje puesta = puesta{potencia = potencia puesta + potencia puesta * porcentaje / 100}

exaltar :: Bool -> PuestaEnEscena -> PuestaEnEscena
exaltar booleano puesta = puesta{publicoExaltado = booleano}

gritar :: Estilo
gritar = aumentarPotencia 50

responderAcote :: Bool -> Estilo
responderAcote efectividad = exaltar efectividad. aumentarPotencia 20

tirarTecnicas :: Patron -> Estilo
tirarTecnicas patron puesta = exaltar (patron . estrofaFreestyle $ puesta) . aumentarPotencia 10 $ puesta

tirarFreestyle :: Estilo -> Estrofa -> Artista -> PuestaEnEscena
tirarFreestyle estilo estrofa = estilo . puestaBase estrofa
---------------
--- Punto 5 ---
---------------
type Jurado = [(Criterio,Puntaje)]
type Criterio = PuestaEnEscena -> Bool
type Puntaje = Float

-- a.
alToke :: Jurado
alToke = [(aabb . estrofaFreestyle,0.5),(patronCombinaDos patronEsdrujula (patronSimple 1 4) . estrofaFreestyle,1),(publicoExaltado,1),((> 1.5) . potencia,2)]

-- b.
puntajeTotal :: Jurado -> PuestaEnEscena -> Float
puntajeTotal jurado puesta = min 3 . sum . map snd . filter (\(criterio,_) -> criterio puesta) $ jurado
---------------
--- Punto 6 ---
---------------
puntosBatalla :: [Jurado] -> [PuestaEnEscena] -> Float
puntosBatalla jurados = sum . zipWith puntajeTotal jurados

ganador :: [PuestaEnEscena] -> [PuestaEnEscena] -> [Jurado] -> Artista
ganador puestas1 puestas2 jurados
    | puntosBatalla jurados puestas1  > puntosBatalla jurados puestas2  = artista . head $ puestas1
    | otherwise = artista . head $ puestas2