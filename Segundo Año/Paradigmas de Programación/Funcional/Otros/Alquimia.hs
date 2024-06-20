{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

data Elemento = Elemento
  { nombreE :: String,
    simboloQuimicoE :: String,
    numeroAtomico :: Int,
    especieE :: Grupo
  }
  deriving (Eq, Show)

type Componente = (Elemento, Int)

data Sustancia
  = Sencilla
      { elemento :: Elemento
      }
  | Compuesta
      { componentes :: [Componente],
        nombreC :: String,
        -- simboloQuimicoC :: String,
        especieC :: Grupo
      }
  deriving (Eq, Show)

data Grupo = Metal | NoMetal | Halogeno | GasNoble | Alcaloide deriving (Eq, Show)

data Criterio = Calor | Electricidad deriving (Eq, Show)

carbono :: Sustancia
carbono = Sencilla (Elemento "Carbono" "C" 6 NoMetal)

nitrogeno :: Sustancia
nitrogeno = Sencilla (Elemento "Nitrogeno" "N" 7 NoMetal)

dietilamidaDeAcidoLisergico :: Sustancia
dietilamidaDeAcidoLisergico = Compuesta [(elemento carbono, 20), (elemento hidrogeno, 25), (elemento nitrogeno, 3), (elemento oxigeno, 1)] "Dietilamida de Acido Lisergico" Alcaloide

-- 1)
-- a)
hidrogeno :: Sustancia
hidrogeno = Sencilla (Elemento "Hidrogeno" "H" 1 NoMetal)

oxigeno :: Sustancia
oxigeno = Sencilla (Elemento "Oxigeno" "O" 8 NoMetal)

-- b)
agua :: Sustancia
agua = Compuesta [(elemento hidrogeno, 2), (elemento oxigeno, 1)] "Agua" NoMetal

-- 2)
grupoDe :: Sustancia -> Grupo
grupoDe (Sencilla (Elemento _ _ _ grupo)) = grupo
grupoDe (Compuesta _ _ grupo) = grupo

conduceBien :: Criterio -> Sustancia -> Bool
conduceBien _ sustancia = grupoDe sustancia == Metal
conduceBien Electricidad (Sencilla (Elemento _ _ _ GasNoble)) = True
conduceBien Calor (Compuesta _ _ Halogeno) = True
conduceBien _ _ = False

-- 3)
esVocal :: Char -> Bool
esVocal a = a `elem` "aeiouáéíóú"

nombre :: Sustancia -> String
nombre (Sencilla (Elemento nombreE _ _ _)) = nombreE
nombre (Compuesta _ nombreC _) = nombreC

-- agarra el nombre, lo da vuelta, le zapatea, le quita las vocales, lo vuelve a dar vuelta, lo marea y le suma "uro"
nombreUnion :: Sustancia -> String
nombreUnion sustancia
  | (not . esVocal . last . nombre) sustancia = nombre sustancia ++ "uro"
  | otherwise = ((++ "uro") . reverse . dropWhile esVocal . reverse . nombre) sustancia

-- 4)
combinar :: Sustancia -> Sustancia -> String
combinar primera segunda = nombreUnion primera ++ " de " ++ nombre segunda

-- 5)
componente :: Componente -> Sustancia
componente componente = Sencilla (fst componente)

mezclar :: Componente -> Componente -> Sustancia
mezclar primero segundo = Compuesta [primero, segundo] (combinar (componente primero) (componente segundo)) NoMetal

-- 6)
formula :: Sustancia -> String
formula (Sencilla (Elemento _ simbolo _ _)) = simbolo
formula (Compuesta componentes _ _) = "(" ++ concatMap representacion componentes ++ ")"

representacion :: Componente -> String
representacion componenteX
  | snd componenteX == 1 = (formula . componente) componenteX
  | otherwise = (formula . componente) componenteX ++ (show . snd) componenteX