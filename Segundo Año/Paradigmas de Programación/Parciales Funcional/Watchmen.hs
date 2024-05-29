---------------
--- Dominio ---
---------------

type Vigilante = (NombreVigilante, [Habilidad], Anio)

type NombreVigilante = String

type Habilidad = String

type Anio = Int

nombreVigilante :: Vigilante -> NombreVigilante
nombreVigilante (nombre, _, _) = nombre

habilidadesVigilante :: Vigilante -> [Habilidad]
habilidadesVigilante (_, habilidades, _) = habilidades

anioAparicionVigilante :: Vigilante -> Anio
anioAparicionVigilante (_, _, anio) = anio

algunosVigilantes :: [Vigilante]
algunosVigilantes = [("El Comediante", ["Fuerza"], 1942), ("Buho Nocturno", ["Lucha", "Ingenierismo"], 1963), ("Rorschach", ["Perseverancia", "Deduccion", "Sigilo"], 1964), ("Espectro de Seda", ["Lucha", "Sigilo", "Fuerza"], 1962), ("Ozimandias", ["Inteligencia", "Más Inteligencia Aún"], 1968), ("Buho Nocturno", ["Lucha", "Inteligencia", "Fuerza"], 1939), ("Espectro de Seda", ["Lucha", "Sigilo"], 1940)]

type Evento = [Vigilante] -> [Vigilante]

-- Eventos
-- a.
destruccionDeNiuShork :: Evento
destruccionDeNiuShork = muerte "Rorschach" . muerte "Dr. Manhattan"

-- b.
muerte :: NombreVigilante -> Evento
muerte nombre = filter (\vigilante -> nombreVigilante vigilante /= nombre)

-- c.
guerraDeVietnam :: Evento
guerraDeVietnam = map agregarCinismo

agregarCinismo :: Vigilante -> Vigilante
agregarCinismo (nombre, habilidades, anio)
  | esAgenteDelGobierno (nombre, habilidades, anio) = (nombre, "Cinismo" : habilidades, anio)
  | otherwise = (nombre, habilidades, anio)

-- d.
accidenteDeLaboratorio :: Anio -> Evento
accidenteDeLaboratorio unAnio = (:) ("Dr. Manhattan", ["Manipulacion de la materia a nivel atomico"], unAnio)

-- e.
actaDeKeene :: Evento
actaDeKeene vigilantes = filter (esViejo vigilantes) vigilantes

esViejo :: [Vigilante] -> Vigilante -> Bool
esViejo vigilantes unVigilante = length vigilantesRepetidos >= 2 && tieneMayorAntiguedad unVigilante vigilantesRepetidos
  where
    vigilantesRepetidos = filter (\vigilante -> nombreVigilante vigilante == nombreVigilante unVigilante) vigilantes

tieneMayorAntiguedad :: Vigilante -> [Vigilante] -> Bool
tieneMayorAntiguedad unVigilante vigilantes = anioAparicionVigilante unVigilante == minimoAnio
  where
    minimoAnio = minimum . map anioAparicionVigilante $ vigilantes

-- Agentes del gobierno
type NombreAgente = String

type Agente = (NombreAgente, String)

agentesDelGobierno :: [Agente]
agentesDelGobierno = [("Jack Bauer", "24"), ("El Comediante", "Watchmen"), ("Dr. Manhattan", "Watchmen"), ("Liam Neeson", "Taken")]

nombreAgente :: Agente -> NombreAgente
nombreAgente = fst

esAgenteDelGobierno :: Vigilante -> Bool
esAgenteDelGobierno unVigilante = nombreVigilante unVigilante `elem` map nombreAgente agentesDelGobierno

---------------
--- Punto 1 ---
---------------
type Historia = [Evento]

desarrolloDeUnaHistoria :: Historia -> [Vigilante] -> [Vigilante]
desarrolloDeUnaHistoria unaHistoria vigilantes = foldr id vigilantes unaHistoria

historia :: Historia
historia = [actaDeKeene, accidenteDeLaboratorio 1959, guerraDeVietnam, muerte "El Comediante", destruccionDeNiuShork]

vigilantesTrasHistoria :: [Vigilante] -> [Vigilante]
vigilantesTrasHistoria = desarrolloDeUnaHistoria historia

---------------
--- Punto 2 ---
---------------
nombreDelSalvador :: [Vigilante] -> NombreVigilante
nombreDelSalvador = nombreVigilante . masHabilidoso . destruccionDeNiuShork

masHabilidoso :: [Vigilante] -> Vigilante
masHabilidoso vigilantes = head . filter (\vigilante -> (length . habilidadesVigilante) vigilante == cantidadMaximaHabilidades) $ vigilantes
  where
    cantidadMaximaHabilidades = maximum . map (length . habilidadesVigilante) $ vigilantes

elElegido :: [Vigilante] -> Habilidad
elElegido = primeraHabilidad . vigilanteConMasPalabras . guerraDeVietnam

vigilanteConMasPalabras :: [Vigilante] -> Vigilante
vigilanteConMasPalabras vigilantes = head . filter (\vigilante -> (cantidadPalabras . nombreVigilante) vigilante == cantidadMaximaPalabras) $ vigilantes
  where
    cantidadMaximaPalabras = maximum . map (cantidadPalabras . nombreVigilante) $ vigilantes

cantidadPalabras :: NombreVigilante -> Int
cantidadPalabras = length . words

primeraHabilidad :: Vigilante -> Habilidad
primeraHabilidad = head . habilidadesVigilante

patriarca :: [Vigilante] -> Int
patriarca = edad . masAntiguo . actaDeKeene

masAntiguo :: [Vigilante] -> Vigilante
masAntiguo vigilantes = head . filter (\vigilante -> anioAparicionVigilante vigilante == anioMinimoDeAparicion) $ vigilantes
  where
    anioMinimoDeAparicion = minimum . map anioAparicionVigilante $ vigilantes

edad :: Vigilante -> Anio
edad = (anioActual -) . anioAparicionVigilante

anioActual :: Anio
anioActual = 2013

---------------
--- Punto 3 ---
---------------
{-
Fue útil definir funciones de orden superior para los eventos y para las historias
ya que esto me permitió trabajar directamente con los Eventos, los cuales son funciones, o con las historias,
las cuales son listas de Eventos, es decir, listas de funciones.
Esto permitió trabajar con los eventos como si fueran un tipo más, y aplicar composiciones
que simplifican mucho las funciones a la vista.
-}