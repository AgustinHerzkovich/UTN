data Jugador = CJugador
  { nombreJ :: String,
    edad :: Int,
    promedioGol :: Float,
    habilidad :: Int,
    cansancio :: Float
  }
  deriving (Show)

type Equipo = (String, Char, [Jugador])

nombreE :: Equipo -> String
nombreE (n, _, _) = n

grupo :: Equipo -> Char
grupo (_, g, _) = g

jugadores :: Equipo -> [Jugador]
jugadores (_, _, j) = j

-- Jugadores de prueba
martin :: Jugador
martin = CJugador "Martin" 26 0.0 50 35.0

juan :: Jugador
juan = CJugador "Juancho" 30 0.2 50 40.0

maxi :: Jugador
maxi = CJugador "Maxi Lopez" 27 0.4 68 30.0

jonathan :: Jugador
jonathan = CJugador "Chueco" 20 1.5 80 99.0

lean :: Jugador
lean = CJugador "Hacha" 23 0.01 50 35.0

brian :: Jugador
brian = CJugador "Panadero" 21 5 80 15.0

garcia :: Jugador
garcia = CJugador "Sargento" 30 1 80 13.0

messi :: Jugador
messi = CJugador "Pulga" 26 10 99 43.0

aguero :: Jugador
aguero = CJugador "Aguero" 24 5 90 5.0

-- Equipos de prueba
equipo1 :: Equipo
equipo1 = ("Lo Que Vale Es El Intento", 'F', [martin, juan, maxi])

losDeSiempre :: Equipo
losDeSiempre = ("Los De Siempre", 'F', [jonathan, lean, brian])

restoDelMundo :: Equipo
restoDelMundo = ("Resto del Mundo", 'A', [garcia, messi, aguero])

equipoInfinito :: Equipo
equipoInfinito = ("Infinity", 'I', repeat messi)

-- Función auxiliar
quickSort :: (a -> a -> Bool) -> [a] -> [a]
quickSort _ [] = []
quickSort criterio (x : xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs

---------------
--- Punto 1 ---
---------------
figuras :: Equipo -> [Jugador]
figuras = filter esFigura . jugadores

esFigura :: Jugador -> Bool
esFigura unJugador = habilidad unJugador > 75 && promedioGol unJugador > 0

---------------
--- Punto 2 ---
---------------
tieneFarandulero :: Equipo -> Bool
tieneFarandulero = any farandulero . jugadores

farandulero :: Jugador -> Bool
farandulero = (`elem` jugadoresFaranduleros) . nombreJ

jugadoresFaranduleros :: [String]
jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

---------------
--- Punto 3 ---
---------------
figuritasDificiles :: Char -> [Equipo] -> [String]
figuritasDificiles unGrupo = map nombreJ . concatMap (filter dificil . jugadores) . filter (perteneceAlGrupo unGrupo)

perteneceAlGrupo :: Char -> Equipo -> Bool
perteneceAlGrupo unGrupo = (== unGrupo) . grupo

dificil :: Jugador -> Bool
dificil unJugador = esFigura unJugador && esJoven unJugador && (not . farandulero) unJugador

esJoven :: Jugador -> Bool
esJoven = (< 27) . edad

---------------
--- Punto 4 ---
---------------
jugarPartido :: Equipo -> [Jugador]
jugarPartido = map cansar . jugadores

cansar :: Jugador -> Jugador
cansar unJugador
  | dificil unJugador = sumarCansancio (cansancio unJugador * (-1) + 50) unJugador
  | esJoven unJugador = sumarCansancio (cansancio unJugador * 0.1) unJugador
  | esFigura unJugador = sumarCansancio 20 unJugador
  | otherwise = sumarCansancio (cansancio unJugador) unJugador

sumarCansancio :: Float -> Jugador -> Jugador
sumarCansancio cansancioAgregado unJugador = unJugador {cansancio = cansancio unJugador + cansancioAgregado}

---------------
--- Punto 5 ---
---------------
ganadorDelPartido :: Equipo -> Equipo -> Equipo
ganadorDelPartido unEquipo otroEquipo = mejorPromedio (seleccionarJugadores unEquipo) (seleccionarJugadores otroEquipo)

jugadoresMenosCansados :: [Jugador] -> [Jugador]
jugadoresMenosCansados = take 11 . quickSort (\jugador1 jugador2 -> cansancio jugador1 <= cansancio jugador2)

seleccionarJugadores :: Equipo -> Equipo
seleccionarJugadores (n, g, j) = (n, g, jugadoresMenosCansados j)

mejorPromedio :: Equipo -> Equipo -> Equipo
mejorPromedio ganador perdedor
  | promedios ganador > promedios perdedor = ganador
  | promedios ganador < promedios perdedor = perdedor

promedios :: Equipo -> Float
promedios = sum . map promedioGol . jugadores

---------------
--- Punto 6 ---
---------------
equipoCampeon :: [Equipo] -> Equipo
equipoCampeon [equipo] = equipo
equipoCampeon [equipo1, equipo2] = ganadorDelPartido equipo1 equipo2
equipoCampeon (equipo1 : equipo2 : equiposRestantes) = equipoCampeon (nuevoGanador : equiposRestantes)
  where
    nuevoGanador = ganadorDelPartido equipo1 equipo2

equipoCampeon' :: [Equipo] -> Equipo
equipoCampeon' = foldl1 ganadorDelPartido

---------------
--- Punto 7 ---
---------------
elMejor :: [Equipo] -> String
elMejor = nombreJ . head . filter esFigura . jugadores . equipoCampeon

---------------
-- Teórico 1 --
---------------
{-
Se utilizaron funciones de orden superior en:
    figuras: filter para filtrar los jugadores que cumplan la condición de ser figura.
    tieneFarandulero: any para verificar si algún jugador cumplía la condición de ser farandulero.
    figuritasDificiles: filter para filtrar los equipos que pertenecían al grupo dado.
    filter para filtrar los jugadores que cumplían la condición dificil en los equipos previamente filtrados.
    concatMap para mapear con la función jugadores la lista de equipos y aplanarla para quedarme únicamente con la lista de jugadores.
    map para aplicar la función nombreJ sobre todos los jugadores de la lista.
    jugarPartido: map para aplicar la función cansar sobre todos los jugadores del equipo.
    jugadoresMenosCansados: quickSort para ordenar la lista de jugadores de manera creciente por cansancio.
    promedios: map para aplicar la función promedioGol sobre todos los jugadores del equipo
    equipoCampeon': foldl1 para plegar la lista de equipos con la función ganadorDelPartido.
    elMejor: filter para filtrar la lista de jugadores del equipo campeon con la condición esFigura.

No se crearon funciones de orden superior.
-}
---------------
-- Teórico 2 --
---------------
{-
Si un equipo tuviera una lista infinita de jugadores nunca podría determinarse el ganador del partido,
y por ende, el equipo campeón y el mejor.
Esto se debe a que para poder determinar quién gana un partido , primero se deben tomar los primeros 11
menos cansados, y para ello se debe ordenar la lista de jugadores, al ser infinita, nunca terminará de ordenarla,
por lo que nunca podrá tomar los 11 primeros y nunca podrá evaluarse el ganador.
-}
