import Text.Show.Functions

data Chico = Chico
  { nombreChico :: Nombre,
    edad :: Int,
    habilidadesChico :: [Habilidad],
    deseos :: [Deseo]
  } deriving(Show)

type Habilidad = String

type Deseo = Chico -> Chico

type Nombre = String

---------------
--- Punto A ---
---------------
-- 1.
-- a.
aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades habilidades unChico = unChico {habilidadesChico = habilidades ++ habilidadesChico unChico}

-- b.
serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = aprenderHabilidades ["jugar need for speed " ++ show n | n <- [1 ..]]

-- c.
modificarEdad :: Int -> Chico -> Chico
modificarEdad nuevaEdad unChico = unChico {edad = nuevaEdad}

serMayor :: Deseo
serMayor = modificarEdad 18

-- 2.
-- a.
quitarPrimerDeseo :: Chico -> Chico
quitarPrimerDeseo unChico = unChico{deseos= drop 1 $ deseos unChico}

quitarTodosLosDeseos :: Chico -> Chico
quitarTodosLosDeseos unChico = unChico{deseos = []}

aumentarEdad :: Int -> Chico -> Chico
aumentarEdad aumento unChico = unChico {edad = edad unChico + aumento}

madurar :: Deseo
madurar = aumentarEdad 1

wanda :: Chico -> Chico
wanda unChico = (madurar . quitarPrimerDeseo .  (head . deseos $ unChico)) unChico

-- b .
cosmo :: Chico -> Chico
cosmo unChico = unChico {edad = edad unChico `div` 2}

-- c.
muffinMagico :: Chico -> Chico
muffinMagico unChico = quitarTodosLosDeseos (foldr ($) unChico $ deseos unChico)

---------------
--- Punto B ---
---------------
-- 1.
-- a.
tieneHabilidad :: Habilidad -> Condicion
tieneHabilidad unaHabilidad unChico = unaHabilidad `elem` habilidadesChico unChico

-- b.
esMayor :: Condicion
esMayor = (> 18) . edad

sabeManejar :: Condicion
sabeManejar = elem "saber manejar" . habilidadesChico

esSuperMaduro :: Condicion
esSuperMaduro unChico = esMayor unChico && sabeManejar unChico

-- 2.
data Chica = Chica
  { nombreChica :: Nombre,
    condicion :: Condicion
  }

type Condicion = Chico -> Bool

noEsTimmy :: Condicion
noEsTimmy = (/= "Timmy") . nombreChico

trixie :: Chica
trixie = Chica "Trixie Tang" noEsTimmy

vicky :: Chica
vicky = Chica "Vicky" (tieneHabilidad "ser un supermodelo noruego")

-- a.
tomarPrimero :: (a -> Bool) -> [a] -> a
tomarPrimero condicion = head . dropWhile (not . condicion)

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica losPretendientes
  | any (condicion unaChica) losPretendientes = tomarPrimero (condicion unaChica) losPretendientes
  | otherwise = last losPretendientes

-- b.
tootie :: Chica
tootie = Chica "Tootie" (tieneHabilidad "saber cocinar")

timmy :: Chico
timmy = Chico "Timmy Turner" 20 ["saber cocinar", "jugar fútbol"] []

chip :: Chico
chip = Chico "Chip Skylark" 25 ["saber cocinar", "bailar salsa"] []

aj :: Chico
aj = Chico "A.J." 18 ["jugar videojuegos", "programar en Haskell"] [serGrosoEnNeedForSpeed]

-- consulta
chicoConquistador :: Chico
chicoConquistador = quienConquistaA tootie [timmy,chip,aj]

-- chicoConquistador = timmy

---------------
--- Punto C ---
---------------
habilidadesProhibidas :: [Habilidad]
habilidadesProhibidas = ["enamorar","matar","dominarElMundo"]

-- 1.
esHabilidadProhibida :: Habilidad -> Bool
esHabilidadProhibida unaHabilidad = unaHabilidad `elem` habilidadesProhibidas

esDeseoProhibido :: Chico -> Deseo -> Bool
esDeseoProhibido unChico unDeseo = any esHabilidadProhibida . take 5 . habilidadesChico $ unDeseo unChico

tieneDeseosProhibidos :: Chico -> Bool
tieneDeseosProhibidos unChico = any (esDeseoProhibido unChico) (deseos unChico)

infractoresDeDaRules :: [Chico] -> [Nombre]
infractoresDeDaRules = map nombreChico . filter tieneDeseosProhibidos

---------------
--- Punto D ---
---------------
{-
la composición se utilizó en funciones como  wanda, tomarPrimero, sabeMamejar, esDeseoProhibido, infractoresDeDaRules. se utilizó para componer funciones de la siguiente manera:
  -- borrarDeseo unDeseo . unDeseo -- unDeseo recibe Chico y devuelve Chico, y borrarDeseo unDeseo recibe Chico y devuelve Chico, entonces se aplica primero unDeseo y luego borrarDeseo unDeseo
  -- (madurar . quitarPrimerDeseo .  (head . deseos $ unChico)) unChico
  -- elem "saber manejar" . habilidadesChico
  -- head . dropWhile (not . condicion)
  -- any esHabilidadProhibida . take 5 . habilidadesChico $ unDeseo unChico

funciones de orden superior creadas podría decirse que todas aquellas que reciban Deseo, ya que Deseo es una función Chico -> Chico, pero dejando estas de lado, tenemos tomarPrimero
  tomarPrimero :: (a -> Bool) -> [a] -> a -- esta función recibe una condición y una lista y devuelve el primer elemento de la lista que cumpla dicha condición

aplicación parcial podemos encontrar por ejemplo
  -- esDeseoProhibido unChico unDeseo = any esHabilidadProhibida . take 5 . habilidadesChico $ unDeseo unChico -- en este caso take 5 está aplicado parcialemente ya que
  la lista la recibe luego de la composición , lo mismo con any esHabilidadProhibida
  -- map nombreChico . filter tieneDeseosProhibidos -- filter recibe dos parámetros y sólo se está invocando con uno

la única lista infinita que utilizamos es en la función serGrosoEnNeedForSpeed -- serGrosoEnNeedForSpeed = aprenderHabilidades ["jugar need for speed " ++ show n | n <- [1 ..]] --
la consulta -- tieneHabilidad "jugar need for speed 8000" unChico arroja resultado
la consulta -- last . habilidadesChico . muffinMagico $ aj no arroja ningún resultado ya que no puede determinar cuál es la última habilidad, debido a que la lista es infinita
-}