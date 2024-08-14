import Data.Foldable (minimumBy)

---------------
--- Punto 1 ---
---------------
data Chofer = UnChofer
  { nombreCh :: String,
    kilometraje :: Float,
    viajes :: [Viaje],
    condicionViaje :: Condicion
  }

data Viaje = UnViaje
  { fecha :: (Int, Int, Int),
    cliente :: Cliente,
    costo :: Float
  }

data Cliente = UnCliente
  { nombreCl :: String,
    zona :: String
  }

type Condicion = Viaje -> Bool

---------------
--- Punto 2 ---
---------------
ninguna :: Condicion
ninguna _ = True

costoMayorA200 :: Condicion
costoMayorA200 = (> 200) . costo

nombreMayorAN :: Int -> Condicion
nombreMayorAN n = (> n) . length . nombreCl . cliente

noViveEn :: String -> Condicion
noViveEn zonaDeterminada = (/= zonaDeterminada) . zona . cliente

---------------
--- Punto 3 ---
---------------
-- a.
lucas :: Cliente
lucas = UnCliente "Lucas" "Victoria"

-- b.
daniel :: Chofer
daniel = UnChofer "Daniel" 23500 [UnViaje (20, 04, 2017) lucas 150] (noViveEn "Olivos")

-- c.
alejandra :: Chofer
alejandra = UnChofer "Alejandra" 180000 [] ninguna

---------------
--- Punto 4 ---
---------------
puedeTomar :: Chofer -> Viaje -> Bool
puedeTomar = condicionViaje

---------------
--- Punto 5 ---
---------------
liquidacion :: Chofer -> Float
liquidacion = sum . map costo . viajes

---------------
--- Punto 6 ---
---------------
realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje unViaje = efectuarViaje unViaje . choferConMenosViajes . filter (`puedeTomar` unViaje)

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes choferes = head . filter (\chofer -> (length . viajes) chofer == minimoViajes) $ choferes
  where
    minimoViajes = minimum . map (length . viajes) $ choferes

efectuarViaje :: Viaje -> Chofer -> Chofer
efectuarViaje unViaje unChofer = unChofer {viajes = unViaje : viajes unChofer}

---------------
--- Punto 7 ---
---------------
repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

-- a.
nitoInfy :: Chofer
nitoInfy = UnChofer "Nito Infy" 70000 (repetirViaje $ UnViaje (11, 03, 2017) lucas 50) (nombreMayorAN 2)

-- b.
{-
La liquidación de Nito no puede calcularse, ya que al tener infinitos viajes nunca se terminará
de efectuar el mapeo con el costo, y por ende tampoco podrá realizarse la suma de todos sus costos, ya que
hay infinitos.
-}
-- c.
{-
Puede saberse si toma ese viaje, ya que la función puedeTomar sólo se fija si el viaje
cumple la condición impuesta por el chofer, y esta es conocida, de hecho se comprueba
el valor de retorno:
ghci> puedeTomar nitoInfy (UnViaje (2, 5, 2017) lucas 500)
ghci> True
-}

---------------
--- Punto 8 ---
---------------
gongNeng :: (Ord b) => b -> (b -> Bool) -> (a -> b) -> [a] -> b
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3

-- Razonamiento
{-
gongNeng arg1 arg2 arg3 arg4 = max arg1 . head . filter arg2 . map arg3 $ arg4

arg4 es una lista, la cual puede ser mapeada con arg3
por ende si arg4 es [a] entonces arg3 es (a -> b)
luego como resulta queda [b] , la cual es filtrada con arg2
por ende arg2 es (b -> Bool)
al filtrarse resulta una [b] filtrada, de la cual se obtiene el primer elemento, y se
compara con arg1 para saber cuál es mayor, por lo tanto arg1 es de tipo b, y para poder
compararse, b debe ser Ord.
El resultado de la función es de tipo b
-}
