--------------
-- Punto 01 --
--------------
-- A --
data Postre = Postre
  { sabores :: [Sabor],
    peso :: Float,
    temperatura :: Float
  }
  deriving (Eq)

type Sabor = String

bizcochoBorracho :: Postre
bizcochoBorracho = Postre ["fruta", "crema"] 100 25

-- B --
type Hechizo = Postre -> Postre

-- Funciones auxiliares
perderPeso :: Float -> Postre -> Postre
perderPeso porcentaje unPostre = unPostre {peso = peso unPostre * (1 - porcentaje / 100)}

calentar :: Float -> Postre -> Postre
calentar grados unPostre = unPostre {temperatura = temperatura unPostre + grados}

agregarSabor :: Sabor -> Postre -> Postre
agregarSabor unSabor unPostre = unPostre {sabores = unSabor : sabores unPostre}

perderSabores :: Postre -> Postre
perderSabores unPostre = unPostre {sabores = []}

-- Hechizos
incendio :: Hechizo
incendio = perderPeso 5 . calentar 1

immobulus :: Hechizo
immobulus unPostre = calentar (negate . temperatura $ unPostre) unPostre

wingardiumLeviosa :: Hechizo
wingardiumLeviosa = perderPeso 10 . agregarSabor "concentrado"

diffindo :: Float -> Postre -> Postre
diffindo = perderPeso

riddikulus :: Sabor -> Postre -> Postre
riddikulus unSabor = agregarSabor (reverse unSabor)

avadaKedavra :: Postre -> Postre
avadaKedavra = perderSabores . immobulus

-- C --
losDejaListos :: Hechizo -> [Postre] -> Bool
losDejaListos unHechizo = all (estaListo . unHechizo)

estaListo :: Postre -> Bool
estaListo unPostre = peso unPostre > 0 && (not . null . sabores) unPostre && (not . estaCongelado) unPostre

estaCongelado :: Postre -> Bool
estaCongelado = (== 0) . temperatura

-- D --
pesoPromedioPostresListos :: [Postre] -> Float
pesoPromedioPostresListos unosPostres = (/ total) . sum . map peso . filter estaListo $ unosPostres
  where
    total = fromIntegral . length . filter estaListo $ unosPostres

--------------
-- Punto 02 --
--------------
data Mago = Mago
  { hechizosAprendidos :: [Hechizo],
    cantidadHorrorcruxes :: Int
  }

-- A --
practicar :: Hechizo -> Postre -> Mago -> Mago
practicar unHechizo unPostre unMago
  | unHechizo unPostre == avadaKedavra unPostre = sumarHorrocrux 1 . agregarHechizo unHechizo $ unMago
  | otherwise = agregarHechizo unHechizo unMago

agregarHechizo :: Hechizo -> Mago -> Mago
agregarHechizo unHechizo unMago = unMago {hechizosAprendidos = unHechizo : hechizosAprendidos unMago}

sumarHorrocrux :: Int -> Mago -> Mago
sumarHorrocrux cantidad unMago = unMago {cantidadHorrorcruxes = cantidadHorrorcruxes unMago + cantidad}

-- B --
mejorHechizo :: Postre -> Mago -> Hechizo
mejorHechizo unPostre unMago = head . filter (\hechizo -> (length . sabores . hechizo) unPostre == maximaCantidadSabores) . hechizosAprendidos $ unMago
  where
    maximaCantidadSabores = maximum . map (length . sabores . ($ unPostre)) . hechizosAprendidos $ unMago

--------------
-- Punto 03 --
--------------
-- A --
postresInfinitos :: [Postre]
postresInfinitos = repeat (Postre ["frutilla", "crema"] 40 25)

magoPoderoso :: Mago
magoPoderoso = Mago (repeat incendio) 30

-- B --
{-
En caso de True:
No es posible saber si algún hechizo los deja listos, ya que para saberlo debería verificarse
que todos los postres, tras realizar el hechizo, queden listos, y nunca se podrá llegar a saber ya que
debería verificarse con un all estaListo sobre la lista de postres tras el hechizo, y el all nunca podrá terminar
de recorrer la lista infinita.

En caso de False:
Sí es posible saberlo, ya que con que encuentre por lo menos un postre que no haya quedado listo
tras el hechizo, basta para devolver False, gracias a la evaluación diferida del paradigma funcional, por lo que
no se necesitaría recorrer la lista completa.
-}

-- C --
{-
En este caso, no es posible, ya que para ello deberían aplicarse los infinitos hechizos sobre el postre para luego
evaluar cuál es el que lo deja con mayor cantidad de sabores, para esto es necesario que se apliquen todos, lo cual nunca podrá ocurrir,
por ello, no es posible encontrar al mejor hechizo.
-}