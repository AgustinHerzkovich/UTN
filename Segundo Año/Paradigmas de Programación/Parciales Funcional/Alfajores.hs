import Data.List (isInfixOf)

-------------
-- Parte 1 --
-------------
data Alfajor = Alfajor
  { capasDeRelleno :: [Relleno],
    peso :: Float,
    dulzorInnato :: Float,
    nombre :: String
  }

data Relleno = DulceDeLeche | Mousse | Fruta deriving (Eq)

precioRelleno :: Relleno -> Float
precioRelleno DulceDeLeche = 12
precioRelleno Mousse = 15
precioRelleno Fruta = 10

-- a.i --
jorgito :: Alfajor
jorgito = Alfajor [DulceDeLeche] 80 8 "Jorgito"

-- a.ii --
havanna :: Alfajor
havanna = Alfajor [Mousse, Mousse] 60 12 "Havanna"

-- a.iii --
capitanDelEspacio :: Alfajor
capitanDelEspacio = Alfajor [DulceDeLeche] 40 12 "Capitán del espacio"

-- b.i --
coeficienteDulzor :: Alfajor -> Float
coeficienteDulzor unAlfajor = dulzorInnato unAlfajor / peso unAlfajor

-- b.ii --
precio :: Alfajor -> Float
precio unAlfajor = 2 * peso unAlfajor + (sum . map precioRelleno . capasDeRelleno) unAlfajor

-- b.iii --
esPotable :: Alfajor -> Bool
esPotable unAlfajor = (not . null . capasDeRelleno) unAlfajor && (all (== (head . capasDeRelleno $ unAlfajor)) . capasDeRelleno) unAlfajor && ((>= 0.1) . coeficienteDulzor) unAlfajor

-------------
-- Parte 2 --
-------------
type Modificacion = Alfajor -> Alfajor

modificarDulzor :: (Float -> Float) -> Alfajor -> Alfajor
modificarDulzor unaOperacion unAlfajor = unAlfajor {dulzorInnato = unaOperacion (dulzorInnato unAlfajor)}

modificarPeso :: (Float -> Float) -> Alfajor -> Alfajor
modificarPeso unaOperacion unAlfajor = unAlfajor {peso = unaOperacion (peso unAlfajor)}

-- a --
abaratar :: Modificacion
abaratar = modificarDulzor (+ (-7)) . modificarPeso (+ (-10))

-- b --
renombrar :: String -> Modificacion
renombrar nuevoNombre unAlfajor = unAlfajor {nombre = nuevoNombre}

-- c --
agregarCapa :: Relleno -> Modificacion
agregarCapa unRelleno unAlfajor = unAlfajor {capasDeRelleno = unRelleno : capasDeRelleno unAlfajor}

-- d --hacerPremium :: Modificacion
hacerPremium unAlfajor
  | esPotable unAlfajor = renombrar (nombre unAlfajor ++ " premium") . agregarCapa (head . capasDeRelleno $ unAlfajor) $ unAlfajor
  | otherwise = unAlfajor

-- e --
premiumDeGrado :: Int -> Alfajor -> Alfajor
premiumDeGrado unGrado = last . take unGrado . iterate hacerPremium

-- f.i --
jorgitito :: Alfajor
jorgitito = renombrar "Jorgitito" . abaratar $ jorgito

-- f.ii --
jorgelin :: Alfajor
jorgelin = renombrar "Jorgelín" . agregarCapa DulceDeLeche $ jorgito

-- f.iii --
capitanCosta :: Alfajor
capitanCosta = renombrar "Capitán del espacio de costa a costa" . premiumDeGrado 4 . abaratar $ capitanDelEspacio

-------------
-- Parte 3 --
-------------
data Cliente = Cliente
  { dinero :: Float,
    alfajoresComprados :: [Alfajor],
    criteriosAlfajores :: [Criterio]
  }

type Criterio = Alfajor -> Bool

leGusta :: Alfajor -> Cliente -> Bool
leGusta unAlfajor = all ($ unAlfajor) . criteriosAlfajores

buscaMarca :: String -> Criterio
buscaMarca unaMarca = isInfixOf unaMarca . nombre

pretencioso :: Criterio
pretencioso = buscaMarca "premium"

dulcero :: Criterio
dulcero = (> 0.15) . coeficienteDulzor

antiElemento :: Relleno -> Criterio
antiElemento unElemento = notElem unElemento . capasDeRelleno

extranio :: Criterio
extranio = not . esPotable

-- a.i --
emi :: Cliente
emi = Cliente 120 [] [buscaMarca "Capitán del espacio"]

-- a.ii --
tomi :: Cliente
tomi = Cliente 100 [] [pretencioso, dulcero]

-- a.iii --
dante :: Cliente
dante = Cliente 200 [] [antiElemento DulceDeLeche, extranio]

-- a.iv --
juan :: Cliente
juan = Cliente 500 [] [dulcero, buscaMarca "Jorgito", pretencioso, antiElemento Mousse]

-- b --
cualesLeGustan :: Cliente -> [Alfajor] -> [Alfajor]
cualesLeGustan unCliente = filter (`leGusta` unCliente)

-- c --
comprarAlfajor :: Alfajor -> Cliente -> Cliente
comprarAlfajor unAlfajor unCliente
  | puedePagar unAlfajor unCliente = gastarDinero (precio unAlfajor) . agregarAlfajor unAlfajor $ unCliente
  | otherwise = unCliente

puedePagar :: Alfajor -> Cliente -> Bool
puedePagar unAlfajor = (>= precio unAlfajor) . dinero

gastarDinero :: Float -> Cliente -> Cliente
gastarDinero cantidad unCliente = unCliente {dinero = dinero unCliente - cantidad}

agregarAlfajor :: Alfajor -> Cliente -> Cliente
agregarAlfajor unAlfajor unCliente = unCliente {alfajoresComprados = unAlfajor : alfajoresComprados unCliente}

-- d --
comprarLosQueLeGustan :: Cliente -> [Alfajor] -> Cliente
comprarLosQueLeGustan unCliente = foldr comprarAlfajor unCliente . cualesLeGustan unCliente