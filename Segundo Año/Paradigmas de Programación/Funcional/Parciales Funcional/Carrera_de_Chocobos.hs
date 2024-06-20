---------------
--- Dominio ---
---------------

type Distancia = Int

type CorreccionDeVelocidad = Chocobo -> Int

type Tramo = (Distancia, CorreccionDeVelocidad)

type Pista = [Tramo]

distancia :: Tramo -> Distancia
distancia = fst

correccionDeVelocidad :: Tramo -> CorreccionDeVelocidad
correccionDeVelocidad = snd

-- Pistas
bosqueTenebroso :: Pista
bosqueTenebroso = [(100, f1), (50, f2), (120, f2), (200, f1), (80, f3)]

pantanoDelDestino :: Pista
pantanoDelDestino = [(40, f2), (90, \(f, p, v) -> f + p + v), (120, fuerza), (20, fuerza)]

-- Correctores de velocidad
f1 :: Chocobo -> Int
f1 chocobo = velocidad chocobo * 2

f2 :: Chocobo -> Int
f2 chocobo = velocidad chocobo + fuerza chocobo

f3 :: Chocobo -> Int
f3 chocobo = velocidad chocobo `div` peso chocobo

type Chocobo = (Fuerza, Peso, Velocidad)

type Fuerza = Int

type Peso = Int

type Velocidad = Int

fuerza :: Chocobo -> Int
fuerza (f, _, _) = f

peso :: Chocobo -> Int
peso (_, p, _) = p

velocidad :: Chocobo -> Int
velocidad (_, _, v) = v

-- Chocobos
amarillo :: Chocobo
amarillo = (5, 3, 3)

negro :: Chocobo
negro = (4, 4, 4)

blanco :: Chocobo
blanco = (2, 3, 6)

rojo :: Chocobo
rojo = (3, 3, 4)

type Jinete = (Nombre, Chocobo)

type Nombre = String

nombreJinete :: Jinete -> Nombre
nombreJinete = fst

chocoboJinete :: Jinete -> Chocobo
chocoboJinete = snd

-- Los 4 jinetes del apocalipsis
apocalipsis :: [Jinete]
apocalipsis = [("Leo", amarillo), ("Gise", blanco), ("Mati", negro), ("Alf", rojo)]

-- Función de ayuda
quickSort :: (a -> a -> Bool) -> [a] -> [a]
quickSort _ [] = []
quickSort criterio (x : xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs

---------------
--- Punto 1 ---
---------------
mayorSegun :: (Ord b) => (a -> b) -> a -> a -> Bool
mayorSegun funcion valor1 valor2 = funcion valor1 > funcion valor2

menorSegun :: (Ord b) => (a -> b) -> a -> a -> Bool
menorSegun funcion valor1 valor2 = funcion valor1 < funcion valor2

---------------
--- Punto 2 ---
---------------
-- a.
tiempo :: Chocobo -> Tramo -> Int
tiempo unChocobo unTramo = distancia unTramo `div` correccionDeVelocidad unTramo unChocobo

-- b.
tiempoTotal :: Pista -> Chocobo -> Int
tiempoTotal unaPista unChocobo = sum . map (tiempo unChocobo) $ unaPista

---------------
--- Punto 3 ---
---------------
tiempoTotalJinete :: Pista -> Jinete -> Int
tiempoTotalJinete unaPista = tiempoTotal unaPista . chocoboJinete

resultados :: Pista -> [Jinete] -> [Jinete]
resultados unaPista = quickSort $ menorSegun (tiempoTotalJinete unaPista)

podio :: Pista -> [Jinete] -> [Jinete]
podio unaPista = take 3 . resultados unaPista

---------------
--- Punto 4 ---
---------------
-- a.
tiempoTramo :: Tramo -> Jinete -> Int
tiempoTramo unTramo unJinete = tiempo (chocoboJinete unJinete) unTramo

mejorTiempo :: Tramo -> [Jinete] -> Jinete
mejorTiempo unTramo = head . quickSort (menorSegun (tiempoTramo unTramo))

elMejorDelTramo :: Tramo -> [Jinete] -> Nombre
elMejorDelTramo unTramo = nombreJinete . mejorTiempo unTramo

-- b.
jinetesConTiempoMinimo :: Tramo -> [Jinete] -> [Jinete]
jinetesConTiempoMinimo unTramo jinetes = filter (\jinete -> tiempoTramo unTramo jinete == minimoTiempo) jinetes
  where
    minimoTiempo = (minimum . map (tiempoTramo unTramo)) jinetes

mayorPeso :: [Jinete] -> Jinete
mayorPeso = head . quickSort (mayorSegun (peso . chocoboJinete))

ganoTramo :: Tramo -> Jinete -> [Jinete] -> Bool
ganoTramo unTramo unJinete jinetes = unJinete == jineteConMejorVelocidad
  where
    jinetesMinimos = jinetesConTiempoMinimo unTramo jinetes
    jineteConMejorVelocidad = mayorPeso jinetesMinimos

cantidadTramosGanados :: Pista -> [Jinete] -> Jinete -> Int
cantidadTramosGanados [] _ _ = 0
cantidadTramosGanados (tramo : tramos) jinetes unJinete
  | ganoTramo tramo unJinete jinetes = 1 + cantidadTramosGanados tramos jinetes unJinete
  | otherwise = cantidadTramosGanados tramos jinetes unJinete

masTramosGanados :: Pista -> [Jinete] -> Jinete
masTramosGanados unaPista jinetes = head $ quickSort (mayorSegun (cantidadTramosGanados unaPista jinetes)) jinetes

elMasWinner :: Pista -> [Jinete] -> Nombre
elMasWinner unaPista = nombreJinete . masTramosGanados unaPista

---------------
--- Punto 5 ---
---------------
puedeHacerlo :: Int -> Tramo -> Jinete -> Bool
puedeHacerlo tiempoMax unTramo unJinete = tiempoTramo unTramo unJinete <= tiempoMax

quienesPueden :: Tramo -> Int -> [Jinete] -> [Nombre]
quienesPueden unTramo tiempoMax = map nombreJinete . filter (puedeHacerlo tiempoMax unTramo)

---------------
--- Punto 6 ---
---------------
transformacion :: Pista -> [Jinete] -> Jinete -> (Nombre, Int, Int)
transformacion unaPista jinetes unJinete = (nombreJinete unJinete, cantidadTramosGanados unaPista jinetes unJinete, tiempoTotalJinete unaPista unJinete)

estadisticas :: Pista -> [Jinete] -> [(Nombre, Int, Int)]
estadisticas unaPista jinetes = map (transformacion unaPista jinetes) (resultados unaPista jinetes)

---------------
--- Punto 7 ---
---------------
fuePareja :: Pista -> [Jinete] -> Bool
fuePareja unaPista jinetes = all (\(tiempo1, tiempo2) -> tiempo1 <= tiempo2 * 9 `div` 10) tiemposConsecutivos
  where
    resultadosOrdenados = resultados unaPista jinetes
    tiemposTotales = map (tiempoTotalJinete unaPista) resultadosOrdenados
    tiemposConsecutivos = zip tiemposTotales (drop 1 tiemposTotales)

---------------
--- Punto 8 ---
---------------
listaDeChocobos :: [Chocobo]
listaDeChocobos = [amarillo, negro, blanco, rojo]

plateado :: Chocobo
plateado = (fuerzaMaxima, pesoMinimo, velocidadMaxima)
  where
    fuerzaMaxima = (maximum . map fuerza) listaDeChocobos
    pesoMinimo = (minimum . map peso) listaDeChocobos
    velocidadMaxima = (maximum . map velocidad) listaDeChocobos

---------------
--- Punto 9 ---
---------------
funcionHeavy :: (Ord a, Eq c) => [(a, b)] -> (c, a) -> ((a, b) -> c) -> [c]
funcionHeavy x y z
  | (fst . head) x < snd y = map z x
  | otherwise = filter (fst y ==) (map z x)