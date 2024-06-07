data Serie = Serie
  { nombreSerie :: String,
    elenco :: [Actor],
    presupuestoAnual :: Float,
    temporadasEstimadas :: Int,
    ratingPromedio :: Float,
    estaCancelada :: Bool
  }
  deriving (Show)

data Actor = Actor
  { nombreActor :: String,
    sueldoAnual :: Float,
    restricciones :: [Restriccion]
  }
  deriving (Show)

type Restriccion = String

-- Ejemplo
paulRudd :: Actor
paulRudd = Actor "Paul Rudd" 41 ["no actuar en bata", "comer ensalada de rúcula todos los días"]

---------------
--- Punto 1 ---
---------------
-- a.
estaEnRojo :: Serie -> Bool
estaEnRojo = not . alcanzaElPresupuesto

alcanzaElPresupuesto :: Serie -> Bool
alcanzaElPresupuesto unaSerie = (>= presupuestoAnual unaSerie) . sum . map sueldoAnual . elenco $ unaSerie

-- b.
esProblematica :: Serie -> Bool
esProblematica = (> 3) . length . filter (restriccionesMayorA 1) . elenco

restriccionesMayorA :: Int -> Actor -> Bool
restriccionesMayorA n = (> n) . length . restricciones

---------------
--- Punto 2 ---
---------------
type Productor = Serie -> Serie

agregarActores :: [Actor] -> Serie -> Serie
agregarActores actoresNuevos unaSerie = unaSerie {elenco = actoresNuevos ++ elenco unaSerie}

eliminarNActores :: Int -> Serie -> Serie
eliminarNActores n unaSerie = unaSerie {elenco = drop n . elenco $ unaSerie}

johnnyDepp :: Actor
johnnyDepp = Actor "Johhny Depp" 20 []

helenaBonham :: Actor
helenaBonham = Actor "Helena Bonham" 15 []

agregarTemporadas :: Int -> Serie -> Serie
agregarTemporadas cantidadTemporadas unaSerie = unaSerie {temporadasEstimadas = temporadasEstimadas unaSerie + cantidadTemporadas}

cancelar :: Serie -> Serie
cancelar unaSerie = unaSerie {estaCancelada = True}

-- a.
conFavoritismos :: [Actor] -> Productor
conFavoritismos actoresFavoritos = agregarActores actoresFavoritos . eliminarNActores 2

-- b.
timBurton :: Productor
timBurton = conFavoritismos [johnnyDepp, helenaBonham]

-- c.
gatopardeitor :: Productor
gatopardeitor = id

-- d.
estireitor :: Productor
estireitor unaSerie = agregarTemporadas (temporadasEstimadas unaSerie) unaSerie

-- e.
desespereitor :: Productor -> Productor -> Productor
desespereitor unProductor otroProductor = otroProductor . unProductor

-- f.
canceleitor :: Float -> Productor
canceleitor unaCifra unaSerie
  | estaEnRojo unaSerie || ratingPromedio unaSerie < unaCifra = cancelar unaSerie
  | otherwise = unaSerie

---------------
--- Punto 3 ---
---------------
bienestarTemporadas :: Serie -> Int
bienestarTemporadas unaSerie
  | temporadasEstimadas unaSerie > 4 = 5
  | otherwise = (* 2) . (10 -) . temporadasEstimadas $ unaSerie

bienestarActores :: Serie -> Int
bienestarActores unaSerie
  | (< 10) . length . elenco $ unaSerie = 3
  | otherwise = max 2 . (10 -) . length $ elencoConRestricciones
  where
    elencoConRestricciones = filter (not . null . restricciones) . elenco $ unaSerie

bienestarSerie :: Serie -> Int
bienestarSerie unaSerie
  | estaCancelada unaSerie = 0
  | otherwise = bienestarTemporadas unaSerie + bienestarActores unaSerie

---------------
--- Punto 4 ---
---------------
aplicarProductoresMasEfectivos :: [Serie] -> [Productor] -> [Serie]
aplicarProductoresMasEfectivos series productores = map (\serie -> productorMasEfectivo serie productores serie) series

productorMasEfectivo :: Serie -> [Productor] -> Productor
productorMasEfectivo unaSerie productores = head . filter (\productor -> (bienestarSerie . productor) unaSerie == mayorBienestar) $ productores
  where
    mayorBienestar = maximum . map (bienestarSerie . ($ unaSerie)) $ productores

---------------
--- Punto 5 ---
---------------
-- a.
{-
Sí, puede aplicarse con una lista infinita de actores, ya que gatopardeitor te devuelve
la serie original sin hacerle ningún cambio, lo único que sucederá es que se imprimirá la serie
infinítamente debido a sus infinitos actores, pero no hay ningún tipo de problema, puede aplicarse.
-}
-- b.
{-
En este caso también puede aplicarse, ya que conFavoritismos elimina los 2 primeros actores de la lista, es decir drop 2,
en esto no hay ningún problema ya que el paradigma funcional maneja la idea de lazy evaluation, por lo que no necesita recorrer
la lista por completo para quitar los primeros 2 elementos, y luego se agregan los actores favoritos del productor al principio,
en esto tampoco hay problema por el mismo motivo que el anterior, los actores se agregan con el operador (:), y por ende pueden visualizarse
al principio si se imprime la serie resultante, si se hubiesen agregado con (++), nunca podrían verse los nuevos agregados, ya que para eso habría
que ir hasta el final de la lista.
En ambos casos la función puede aplicarse y muestra un resultado, infinito, pero lo muestra a fin de cuentas.
-}
---------------
--- Punto 6 ---
---------------
esControvertida :: Serie -> Bool
esControvertida = not . cobranMasQueElSiguiente . elenco

cobranMasQueElSiguiente :: [Actor] -> Bool
cobranMasQueElSiguiente = estaOrdenadaDecrecientemente . map sueldoAnual

estaOrdenadaDecrecientemente :: (Ord a) => [a] -> Bool
estaOrdenadaDecrecientemente lista = all (uncurry (>=)) (zip lista (tail lista))

---------------
--- Punto 7 ---
---------------
funcionLoca :: (Foldable t) => (Int -> Int) -> (a -> t b) -> [a] -> [Int]
funcionLoca x y = filter (even . x) . map (length . y)

-- Razonamiento
{-
funcionLoca x y z= filter (even . x) . map (length . y) $ z

:t map = (a -> b) -> [a] -> [b]
Entonces z = [a] y (length . y) = (a -> b)
"y" es la primera función que se aplica a los elementos de z, osea que y = (a ->b),
pero b debe pertenecer al dominio de length, y el dominio de length es Foldable t => t a.
Entonces si z = [a], entonces y = (a -> t b) con Foldable t, luego se mapea length y resulta una [Int].
Esta [Int] se filtra con (even . x), por lo que el tipo de (even . x) = (Int -> Bool) ,
"x" es una función que se aplica a los elementos de la lista [Int], y devuelve Int ya que su resultado
debe ser evaluado por un even, entonces x = (Int -> Int)
Por último el resultado de la función es [Int].
-}
