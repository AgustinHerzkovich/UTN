type Cancion = [Nota]

data Nota = Nota
  { tono :: Float, -- Frecuencia medida en Hz
    volumen :: Float, -- Volumen de reproducción medido en Db
    duracion :: Float -- Tiempo de reproducción medido en segundos
  }
  deriving (Eq, Show)

-- FUNCIONES AUXILIARES
cambiarVolumen :: (Float -> Float) -> Nota -> Nota
-- Dada una función transformación y una nota retorna una copia de la
-- nota con el volumen igual al resultado de aplicar la transformación a
-- su volumen actual.

cambiarVolumen delta nota = nota {volumen = delta (volumen nota)}

cambiarTono :: (Float -> Float) -> Nota -> Nota
-- Dada una función transformación y una nota retorna una copia de la
-- nota con el tono igual al resultado de aplicar la transformación a
-- su tono actual.
cambiarTono delta nota = nota {tono = delta (tono nota)}

cambiarDuracion :: (Float -> Float) -> Nota -> Nota
-- Dada una función transformación y una nota retorna una copia de la
-- nota con la duración igual al resultado de aplicar la transformación a
-- su duración actual.
cambiarDuracion delta nota = nota {duracion = delta (duracion nota)}

promedio :: [Float] -> Float
-- Dada una lista de números retorna el valor promedio
promedio lista = sum lista / fromIntegral (length lista)

--------------
-- Punto 01 --
--------------
-- a --
esAudible :: Nota -> Bool
esAudible unaNota = estaEntre 20 20000 (tono unaNota) && volumen unaNota > 10

estaEntre :: Float -> Float -> Float -> Bool
estaEntre cotaInferior cotaSuperior numero = numero >= cotaInferior && numero <= cotaSuperior

-- b --
esMolesta :: Nota -> Bool
esMolesta unaNota = (esAudible unaNota && tono unaNota < 250 && volumen unaNota > 85) || (esAudible unaNota && tono unaNota >= 250 && volumen unaNota > 55)

--------------
-- Punto 02 --
--------------
-- a --
silencioTotal :: Cancion -> Float
silencioTotal = sum . map duracion . filter (not . esAudible)

-- b --
sinInterrupciones :: Cancion -> Bool
sinInterrupciones = all esAudible . filter ((> 0.1) . duracion)

-- c --
peorMomento :: Cancion -> Float
peorMomento = maximum . map volumen . filter esMolesta

--------------
-- Punto 03 --
--------------
type Filtro = Cancion -> Cancion

-- a --
trasponer :: Float -> Filtro
trasponer numero = map (cambiarTono (* numero))

-- b --
acotarVolumen :: Float -> Float -> Filtro
acotarVolumen volumenMaximo volumenMinimo = map ajustarVolumen
  where
    ajustarVolumen nota
      | volumen nota < volumenMinimo = cambiarVolumen (const volumenMinimo) nota
      | volumen nota > volumenMaximo = cambiarVolumen (const volumenMaximo) nota
      | otherwise = nota

-- c --
normalizar :: Filtro
normalizar unaCancion = map (cambiarVolumen (const volumenPromedio)) $ unaCancion
  where
    volumenPromedio = promedio . map volumen $ unaCancion

--------------
-- Punto 04 --
--------------
-- a --
f :: (a -> b -> Bool) -> [a -> a] -> a -> b -> Bool
f g [] y z = g y z
f g (x : xs) y z = g (x y) z || f g xs y z

{-
primer parámetro: g es una función que recibe dos parámetros y devuelve algo, recibe "y" y "z"
por ende g :: (a -> b -> c), y :: a, z :: b

segundo parámetro: lista de elementos que se pueden a aplicar a "y"
llamemos "x" a la lista => x :: [a -> a]

El || me da la pista de que la función devuelve Bool, entonces c = Bool
-}

-- b --
infringeCopyright :: [Filtro] -> Cancion -> Cancion -> Bool
infringeCopyright = f (==)

-- c --
{-
En términos de expresividad, la función no es muy expresiva ya que utiliza nombres como
g, x, y, z, podrían reemplazar por comparador, listaTransformaciones, parametroOriginal , parametroBuscado o algo
por el estilo.
En términos de declaratividad podría eliminarse la recursividad y utilizar foldr, de la siguiente manera:
f g xs y z = foldr (\x -> (||) (g (x y) z)) (g y z) xs
-}

--------------
-- Punto 05 --
--------------
tunear :: [Filtro] -> Cancion -> Cancion
tunear unosFiltros unaCancion = normalizar . foldl (flip ($)) unaCancion $ unosFiltros