import Text.Show.Functions()

type Bien = (Float, String)

cantidadBien :: Bien -> Float
cantidadBien = fst

descripcionBien :: Bien -> String
descripcionBien = snd

data Personaje = UnPersonaje
  {
    nombre :: String,
    bienes :: [Bien],
    cantidadTrabajos :: Int,
    estiloChoreo :: Estilo
  } deriving(Show)

-- Personajes de ejemplo
capoFifa :: Personaje
capoFifa = UnPersonaje "joseph" [(100000, "euros"), (40, "contactos"), (10, "cuenta secreta")] 500 estafa

jefeBostero :: Personaje
jefeBostero = UnPersonaje "rafa" [(10000, "pesos"), (5, "victima")] 100 ratero

--------------
-- Punto 01 --
--------------
-- a --
definirPersonaje :: String -> [Bien] -> Int -> Estilo -> Personaje
definirPersonaje = UnPersonaje

-- b --
cantidadDe :: String -> Personaje -> Float
cantidadDe descripcion = cantidadBien . head . filter ((== descripcion) . descripcionBien) . bienes

-- c --
apropiar :: Bien -> Personaje -> Personaje
apropiar unBien unPersonaje
  | tiene (descripcionBien unBien) unPersonaje = acumularBien unBien unPersonaje
  | otherwise = agregarBien unBien unPersonaje

tiene :: String -> Personaje -> Bool
tiene unBien = elem unBien . map descripcionBien . bienes

acumularBien :: Bien -> Personaje -> Personaje
acumularBien unBien unPersonaje = unPersonaje {bienes = afectarALosQueCumplen (coincideCon unBien) (sumarCantidad (cantidadBien unBien)) (bienes unPersonaje)}

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen _ _ [] = []
afectarALosQueCumplen condicion funcion (x : xs)
  | condicion x = funcion x : afectarALosQueCumplen condicion funcion xs
  | otherwise = x : afectarALosQueCumplen condicion funcion xs

coincideCon :: Bien -> Bien -> Bool
coincideCon unBien otroBien = descripcionBien unBien == descripcionBien otroBien

sumarCantidad :: Float -> Bien -> Bien
sumarCantidad x (cantidad, descripcion) = (cantidad + x, descripcion)

agregarBien :: Bien -> Personaje -> Personaje
agregarBien unBien unPersonaje = unPersonaje {bienes = unBien : bienes unPersonaje}

--------------
-- Punto 02 --
--------------
data Objetivo = UnObjetivo
  { descripcion :: String,
    botin :: [Bien]
  } deriving (Eq)

-- Objetivos de ejemplo
convenio :: Objetivo
convenio = UnObjetivo "convenio de televisación" [(5000,"euros"),(2,"contactos")]
enfrentamiento :: Objetivo
enfrentamiento = UnObjetivo "enfrentamiento con la barra de chacarita" [(2,"victima")]
galeon :: Objetivo
galeon = UnObjetivo "galeon español cargado" [(300,"monedas de oro"),(5,"cofres"), (1,"corazon de Davy Jones")]

type Estilo = Objetivo -> Personaje -> Personaje

tienePocasUnidades :: Bien -> Bool
tienePocasUnidades = (< 10) . cantidadBien

-- Estilos
ratero :: Estilo
ratero = apropiar . head . botin

express :: Estilo
express unObjetivo = express objetivoFiltrado
    where
        objetivoFiltrado = unObjetivo{botin = filter tienePocasUnidades . botin $ unObjetivo}

estafa :: Estilo
estafa unObjetivo unPersonaje = foldl (flip apropiar) unPersonaje . botin $ unObjetivo

hacerTrabajo :: Objetivo -> Personaje -> Personaje
hacerTrabajo unObjetivo unPersonaje = estiloChoreo unPersonaje unObjetivo unPersonaje
--------------
-- Punto 03 --
--------------
type Carcel = Personaje -> Personaje

sustituirEstilo :: Estilo -> Personaje -> Personaje
sustituirEstilo unEstilo unPersonaje = unPersonaje{estiloChoreo = unEstilo}

aplicarDosVeces :: Estilo -> Estilo
aplicarDosVeces unEstilo unObjetivo = unEstilo unObjetivo . unEstilo unObjetivo

reducirPrimeroALaMitad :: [Bien] -> [Bien]
reducirPrimeroALaMitad [] = []
reducirPrimeroALaMitad (x : xs) = reducirCantidad x : xs

reducirCantidad :: Bien -> Bien
reducirCantidad (cantidad, descripcion) = (cantidad / 2, descripcion)

disminuirALaMitad :: Personaje -> Personaje
disminuirALaMitad unPersonaje = unPersonaje {bienes = reducirPrimeroALaMitad (bienes unPersonaje)}

-- a --
-- Cárceles
alcatraz :: Carcel
alcatraz = sustituirEstilo estafa

sierraChica :: Carcel
sierraChica unPersonaje = sustituirEstilo (aplicarDosVeces (estiloChoreo unPersonaje)) unPersonaje

institutoCarcelarioModelo :: Carcel
institutoCarcelarioModelo = disminuirALaMitad . sustituirEstilo ratero

-- b --
-- hacerTrabajo unObjetivo . alcatraz . sierraChica . institutoCarcelarioModelo $ unPersonaje

--------------
-- Punto 04 --
--------------
raid :: [Personaje -> Personaje] -> Personaje -> Personaje
raid trabajos unPersonaje = foldr id unPersonaje trabajos

{-
Podría hacerse un raid infinito, sin embargo nunca terminaría, ya que para retornar algo debe realizar
todos los trabajos que componen la lista de trabajos, y esto no terminaría jamás.
El caso base de foldr se da cuando la lista es vacía, y en este caso, nunca llegaría, por lo tanto diverge.
-}

--------------
-- Punto 05 --
--------------
seEncuentra :: Objetivo -> [Objetivo] -> Bool
seEncuentra unObjetivo = elem (descripcion unObjetivo) . map descripcion