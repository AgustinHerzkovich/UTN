import Data.List

-- fibonacci
fibonacci :: (Eq a, Num a) => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = (n - 1) + (n - 2)

{-
-- tipos algebraicos
data Persona = Persona
  { nombre :: String,
    edad :: Int,
    domicilio :: String,
    telefono :: String,
    fechaNacimiento :: (Int, Int, Int),
    buenaPersona :: Bool,
    plata :: Float
  }deriving(Show)

juan :: Persona
juan =
  Persona
    { nombre = "Juan",
      edad = 29,
      domicilio = "Ayacucho 554",
      telefono = "45232598",
      fechaNacimiento = (17, 7, 1988),
      buenaPersona = True,
      plata = 30.0
    }-- tupla que solo devuelve el nombre y edad de una persona dada
datosPrincipales :: Persona -> (String, Int)
datosPrincipales personita = (nombre personita, edad personita)
-}

data Elemento = Fuego | Psiquico | Acero deriving (Eq, Show)

data TipoPokemon = Unico {primario :: Elemento}
                  | Doble {primario :: Elemento, secundario :: Elemento}
  deriving (Show, Eq)

data Pokemon = Pokemon
  { nombre :: String,
    familia :: String,
    tipopokemon :: [TipoPokemon]
  }
  deriving (Show)

conseguirElementos :: Pokemon -> [Elemento]
conseguirElementos (Pokemon _ _ [Unico primario]) = [primario]
conseguirElementos (Pokemon _ _ [Doble primario secundario]) = [primario, secundario]

elementosComunes :: Pokemon -> Pokemon -> [Elemento]
elementosComunes pokemon1 pokemon2 = conseguirElementos pokemon1 `intersect` conseguirElementos pokemon2

sonCompatibles :: Pokemon -> Pokemon -> Bool
sonCompatibles pokemon1 = not . null . elementosComunes pokemon1

poke1 :: Pokemon
poke1 =
  Pokemon
    { nombre = "Charmander",
      familia = "Lagarto",
      tipopokemon = [Unico Fuego]
    }

poke2 :: Pokemon
poke2 =
  Pokemon
    { nombre = "Metagross",
      familia = "Acero",
      tipopokemon = [Doble Psiquico Acero]
    }

poke3 :: Pokemon
poke3 =
  Pokemon
    { nombre = "Heatran",
      familia = "Fuego",
      tipopokemon = [Unico Acero]
    }