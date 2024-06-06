data Animal = Animal
  { nombre :: String,
    tipo :: String,
    peso :: Float,
    edad :: Int,
    estaEnfermo :: Bool,
    visitasMedicas :: [VisitaMedica]
  }
  deriving (Show)

type VisitaMedica = (DiasRecuperacion, Costo)

type DiasRecuperacion = Int

type Costo = Float

diasDeRecuperacion :: VisitaMedica -> DiasRecuperacion
diasDeRecuperacion = fst

costoAtencion :: VisitaMedica -> Costo
costoAtencion = snd

---------------
--- Punto 1 ---
---------------
laPasoMal :: Animal -> Bool
laPasoMal = any ((> 30) . diasDeRecuperacion) . visitasMedicas

tieneNombreFalopa :: Animal -> Bool
tieneNombreFalopa = (== 'i') . last . nombre

---------------
--- Punto 2 ---
---------------
type Actividad = Animal -> Animal

-- Funciones auxiliares
aumentarPeso :: Float -> Animal -> Animal
aumentarPeso kilos unAnimal = unAnimal {peso = peso unAnimal + kilos}

registrarVisita :: VisitaMedica -> Animal -> Animal
registrarVisita unaVisita unAnimal = unAnimal {visitasMedicas = unaVisita : visitasMedicas unAnimal}

agregarAnios :: Int -> Animal -> Animal
agregarAnios anios unAnimal = unAnimal {edad = edad unAnimal + anios}

modificarEstado :: Bool -> Animal -> Animal
modificarEstado estadoSalud unAnimal = unAnimal {estaEnfermo = estadoSalud}

-- Actividades
engorde :: Float -> Actividad
engorde kilosAlimentoBalanceado = aumentarPeso . min 5 $ (kilosAlimentoBalanceado / 2)

revisacion :: VisitaMedica -> Actividad
revisacion unaVisita unAnimal
  | estaEnfermo unAnimal = engorde 2 . registrarVisita unaVisita $ unAnimal
  | otherwise = unAnimal

festejoCumple :: Actividad
festejoCumple = aumentarPeso (-1) . agregarAnios 1

chequeoDePeso :: Float -> Actividad
chequeoDePeso pesoX unAnimal
  | peso unAnimal > pesoX = unAnimal
  | otherwise = modificarEstado False unAnimal

---------------
--- Punto 3 ---
---------------
type Proceso = [Actividad]

proceso :: Animal -> Proceso -> Animal
proceso = foldl (flip ($))

-- Ejemplo
-- ghci> proceso unAnimal [engorde kilos,revisacion unaVisita,festejoCumple,chequeoDePeso pesoMinimo]
---------------
--- Punto 4 ---
---------------
mejora :: Proceso -> Animal -> Bool
mejora [actividad] unAnimal = (peso . actividad) unAnimal - peso unAnimal <= 3
mejora (actividad1 : actividad2 : actividades) unAnimal = (peso . actividad1) unAnimal <= (peso . actividad2 . actividad1) unAnimal && ((peso . actividad1) unAnimal - peso unAnimal <= 3) && mejora (actividad2 : actividades) (actividad1 unAnimal)

---------------
--- Punto 5 ---
---------------
-- a.
tresFaloperos :: [Animal] -> [Animal]
tresFaloperos = take 3 . filter tieneNombreFalopa

-- b.
{-
No sería posible obtener un resultado, ya que para tomar los primeros tres con nombre falopa,
primero se debe filtrar la lista con aquellos que efectivamente tienen nombre de este tipo,
y el filter nunca llegará a terminarse, debido a que no converge a su caso base (cuando la lista es []),
por lo tanto la función se quedará procesando infinitamente el filter tieneNombreFalopa y nunca mostrará un
resultado por pantalla.
-}