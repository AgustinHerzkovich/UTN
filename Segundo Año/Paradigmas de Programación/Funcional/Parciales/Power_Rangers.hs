import Data.Char
import Data.Foldable (maximumBy)

---------------
--- Punto 1 ---
---------------
-- a.
type Persona = ([Habilidad], Bool)

type Habilidad = String

habilidadesPersona :: Persona -> [Habilidad]
habilidadesPersona = fst

esBuena :: Persona -> Bool
esBuena = snd

fede :: Persona
fede = (["jugar al cs", "comer hamburguesas", "dormir", "bailar"], True)

-- b.
type PowerRanger = (Color, [Habilidad], Int)

type Color = String

colorRanger :: PowerRanger -> Color
colorRanger (c, _, _) = c

nivelDePelea :: PowerRanger -> Int
nivelDePelea (_, _, n) = n

habilidadesRanger :: PowerRanger -> [Habilidad]
habilidadesRanger (_, h, _) = h

azul :: PowerRanger
azul = ("azul", ["trepar muros", "correr muy rápido", "volar"], 10)

---------------
--- Punto 2 ---
---------------
convertirEnPowerRanger :: Color -> Persona -> PowerRanger
convertirEnPowerRanger unColor unaPersona = (unColor, habilidadesPotenciadas . habilidadesPersona $ unaPersona, cantidadLetras . habilidadesPersona $ unaPersona)

habilidadesPotenciadas :: [Habilidad] -> [Habilidad]
habilidadesPotenciadas = map (("super" ++) . mayuscalizar)

mayuscalizar :: String -> String
mayuscalizar unaPalabra = (cabezaMayuscula :) . tail $ unaPalabra
  where
    cabezaMayuscula = toUpper . head $ unaPalabra

cantidadLetras :: [String] -> Int
cantidadLetras = sum . map length

---------------
--- Punto 3 ---
---------------
formarEquipoRanger :: [Color] -> [Persona] -> [PowerRanger]
formarEquipoRanger colores = zipWith convertirEnPowerRanger colores . filter esBuena

-- Personas de prueba
jason :: Persona
jason = (["liderazgo", "artes marciales", "estrategia"], True)

skull :: Persona
skull = (["tocar trompeta", "causar problemas", "hacer comedia"], False)

kimberly :: Persona
kimberly = (["gimnasia", "tiro con arco", "liderazgo"], True)

bulk :: Persona
bulk = (["causar problemas", "fuerza bruta", "hacer comedia"], False)

---------------
--- Punto 4 ---
---------------
-- a.
findOrElse :: (a -> Bool) -> a -> [a] -> a
findOrElse condicion valor lista
  | any condicion lista = head . filter condicion $ lista
  | otherwise = valor

-- b.
rangerLider :: [PowerRanger] -> PowerRanger
rangerLider = genericLider colorRanger

---------------
--- Punto 5 ---
---------------
-- a.
maximumBy' :: (Ord b) => (a -> b) -> [a] -> a
maximumBy' funcion lista = head . filter (\x -> funcion x == resultadoMaximo) $ lista
  where
    resultadoMaximo = maximum . map funcion $ lista

-- b.
rangerMasPoderoso :: [PowerRanger] -> PowerRanger
rangerMasPoderoso = maximumBy' nivelDePelea

---------------
--- Punto 6 ---
---------------
rangerHabilidoso :: PowerRanger -> Bool
rangerHabilidoso = (> 5) . length . habilidadesRanger

---------------
--- Punto 7 ---
---------------
-- a.
alfa5 :: PowerRanger
alfa5 = ("metalico", ["reparar cosas", "decir " ++ cycle "ay "], 0)

-- b.
-- Ejemplo de aplicación que termina
-- ghci> rangerHabilidoso alfa5
-- ghci> False

-- Ejemplo de aplicación que no termina
-- ghci> findOrElse ((>100) . length) "no"  (habilidadesRanger alfa5)
-- ghci> "

---------------
--- Punto 8 ---
---------------
type ChicaSuperpoderosa = (Color, Int)

colorChica :: ChicaSuperpoderosa -> Color
colorChica = fst

chicaLider :: [ChicaSuperpoderosa] -> ChicaSuperpoderosa
chicaLider = genericLider colorChica

genericLider :: (a -> Color) -> [a] -> a
genericLider funcionColor equipo = findOrElse ((== "rojo") . funcionColor) (head equipo) equipo