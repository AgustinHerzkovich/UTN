import Text.Show.Functions ()

data Aspecto = UnAspecto
  { tipoDeAspecto :: String,
    grado :: Float
  }
  deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto :: Aspecto -> Aspecto -> Bool
mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto :: Aspecto -> Aspecto -> Bool
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto :: Aspecto -> [Aspecto] -> Aspecto
buscarAspecto aspectoBuscado = head . filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo :: String -> [Aspecto] -> Aspecto
buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto :: Aspecto -> [Aspecto] -> [Aspecto]
reemplazarAspecto aspectoBuscado situacion = aspectoBuscado : filter (not . mismoAspecto aspectoBuscado) situacion

tension :: Float -> Aspecto
tension = UnAspecto "tension"

incertidumbre :: Float -> Aspecto
incertidumbre = UnAspecto "incertidumbre"

peligro :: Float -> Aspecto
peligro = UnAspecto "peligro"

---------------
--- Punto 1 ---
---------------
-- a.
modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto funcion unAspecto = unAspecto {grado = funcion $ grado unAspecto}

-- b.
esMejor :: Situacion -> Situacion -> Bool
esMejor situacion1 situacion2 = all (\aspecto -> mejorAspecto aspecto (buscarAspecto aspecto situacion2)) situacion1

-- c.
modificarSituacion :: String -> (Float -> Float) -> Situacion -> Situacion
modificarSituacion tipoAspectoBuscado funcion situacion = reemplazarAspecto aspectoModificado situacion
  where
    aspectoModificado = modificarAspecto funcion aspectoEncontrado
    aspectoEncontrado = buscarAspectoDeTipo tipoAspectoBuscado situacion

---------------
--- Punto 2 ---
---------------
-- a.
data Gema = UnaGema
  { nombre :: String,
    fuerza :: Int,
    personalidad :: Personalidad
  }

type Personalidad = Situacion -> Situacion

-- b.
vidente :: Personalidad
vidente = modificarSituacion "tension" (/ 2) . modificarSituacion "incertidumbre" (restarN 10)

relajada :: Float -> Personalidad
relajada relajamiento = modificarSituacion "peligro" (restarN (-relajamiento)) . modificarSituacion "tension" (restarN 10)

restarN :: Float -> Float -> Float
restarN n num = num - n

-- c.
unaGemaVidente :: Gema
unaGemaVidente = UnaGema "gemita" 100 vidente

unaGemaDescuidada :: Gema
unaGemaDescuidada = UnaGema "descuido" 50 (relajada 200)

---------------
--- Punto 3 ---
---------------
leGana :: Gema -> Gema -> Situacion -> Bool
leGana gema1 gema2 unaSituacion = esMasFuerte gema1 gema2 && esMejor (situacionGenerada gema1 unaSituacion) (situacionGenerada gema2 unaSituacion)

esMasFuerte :: Gema -> Gema -> Bool
esMasFuerte gema1 gema2 = fuerza gema1 >= fuerza gema2

situacionGenerada :: Gema -> Situacion -> Situacion
situacionGenerada = personalidad

---------------
--- Punto 4 ---
---------------
fusion :: Situacion -> Gema -> Gema -> Gema
fusion unaSituacion gema1 gema2 = UnaGema (nombreFusionado gema1 gema2) (fuerzaFusionada gema1 gema2 unaSituacion) (personalidadFusionada gema1 gema2)

nombreFusionado :: Gema -> Gema -> String
nombreFusionado gema1 gema2
  | nombre gema1 == nombre gema2 = nombre gema1
  | otherwise = nombre gema1 ++ nombre gema2

fuerzaFusionada :: Gema -> Gema -> Situacion -> Int
fuerzaFusionada gema1 gema2 unaSituacion
  | sonCompatibles gema1 gema2 unaSituacion = (* 10) . (+ fuerza gema1) . fuerza $ gema2
  | otherwise = (* 7) . fuerza . gemaDominante gema1 gema2 $ unaSituacion

sonCompatibles :: Gema -> Gema -> Situacion -> Bool
sonCompatibles gema1 gema2 unaSituacion = esMejor situacionGeneradaPorFusion situacionGeneradPorGema1 && esMejor situacionGeneradaPorFusion situacionGeneradPorGema2
  where
    situacionGeneradaPorFusion = personalidadFusionada gema1 gema2 unaSituacion
    situacionGeneradPorGema1 = situacionGenerada gema1 unaSituacion
    situacionGeneradPorGema2 = situacionGenerada gema2 unaSituacion

gemaDominante :: Gema -> Gema -> Situacion -> Gema
gemaDominante gema1 gema2 unaSituacion
  | leGana gema1 gema2 unaSituacion = gema1
  | otherwise = gema2

personalidadFusionada :: Gema -> Gema -> Personalidad
personalidadFusionada gema1 gema2 = personalidad gema2 . personalidad gema1 . map (modificarAspecto (restarN 10))

---------------
--- Punto 5 ---
---------------
fusionGrupal :: [Gema] -> Situacion -> Gema
fusionGrupal gemas unaSituacion = foldr1 (fusion unaSituacion) gemas

---------------
--- Punto 6 ---
---------------
-- a.
-- Razonamiento
foo :: (Eq a) => c -> (c -> a) -> (b -> [a]) -> b -> Bool
foo x y z = any (== y x) . z

{-
foo x y z w = any (== y x) . z $ w

Recordemos el tipo de any
any :: (Foldable t) => (a -> Bool) -> t a -> Bool

En este caso
(== y x) = (a -> Bool) ; z w = [a]

Es decir que z es una función que recibe b y devuelve una lista para que
pueda ser evaludada con el any
Supongamos que la lista que devuelve z es de tipo [a]
Entonces: w = b y z = b -> [a]
Con esto en cuenta entonces (== y x) sería de tipo (a -> bool)
De aquí obtenemos que y es una función que recibe x y el resultado que devuelve
debe ser Eq, y además de tipo a, por lo que y = (c -> a) ; x = c

Al finalizar con un any la función retorna Bool
-}
-- b.
{-
foo 5 (+ 7) [1 ..] -- Hay error de tipo ya que el tercer parámetro que recibe foo
es de tipo (b -> [a]) y aquí se le está pasando una lista [1..]

foo 3 even (map (< 7)) -- Tipa y termina, ya que se está aplicando una función
de 4 parámetros parcialmente pasándole sólo 3 de ellos, por lo que el retorno es de tipo (b -> Bool).
Aunque se debería hacer import Text.Show.Functions() para que se pueda ver el resultado.

foo 3 even [1, 2, 3] -- Hay error de tipo ya que el tercer parámetro que recibe foo
es de tipo (b -> [a]) y aquí se le está pasando una lista [1, 2, 3]

foo [1 ..] head (take 5) [1 ..] -- Tipa y termina, lo que hace es tomar los primeros 5 de la lista [1..]
es decir agarra [1,2,3,4,5], luego pregunta si en esa lista hay algún elemento que sea igual a (head [1..]), es decir a 1
por lo que estaría preguntando es any (==1) [1,2,3,4,5], y la respuesta es True
-}
