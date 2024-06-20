--------------
-- Punto 01 --
--------------
data Nave = Nave
  { nombre :: String,
    durabilidad :: Int,
    escudo :: Int,
    ataque :: Int,
    poder :: Poder
  }

type Poder = Nave -> Nave

modificarAtaque :: (Int -> Int) -> Nave -> Nave
modificarAtaque unaOperacion unaNave = unaNave {ataque = max 0 (unaOperacion (ataque unaNave))}

modificarDurabilidad :: (Int -> Int) -> Nave -> Nave
modificarDurabilidad unaOperacion unaNave = unaNave {durabilidad = max 0 (unaOperacion (durabilidad unaNave))}

modificarEscudo :: (Int -> Int) -> Nave -> Nave
modificarEscudo unaOperacion unaNave = unaNave {escudo = max 0 (unaOperacion (escudo unaNave))}

-- Naves de ejemplo
tieFighter :: Nave
tieFighter = Nave "TIE Fighter" 200 100 50 movimientoTurbo

xWing :: Nave
xWing = Nave "X Wing" 300 150 100 reparacionEmergencia

naveDarthVader :: Nave
naveDarthVader = Nave "Nave de Darth Vader" 500 300 200 movimientoSuperTurbo

millenniumFalcon :: Nave
millenniumFalcon = Nave "Millennium Falcon" 1000 500 50 (modificarEscudo (+ 100) . reparacionEmergencia)

naveFalopa :: Nave
naveFalopa = Nave "Falopa" 250 100 150 (reparacionEmergencia . movimientoSuperTurbo . movimientoTurbo)

-- Poderes
movimientoTurbo :: Poder
movimientoTurbo = modificarAtaque (+ 25)

reparacionEmergencia :: Poder
reparacionEmergencia = modificarAtaque (+ (-30)) . modificarDurabilidad (+ 50)

movimientoSuperTurbo :: Poder
movimientoSuperTurbo = modificarDurabilidad (+ (-45)) . movimientoTurbo . movimientoTurbo . movimientoTurbo

--------------
-- Punto 02 --
--------------
type Flota = [Nave]

durabilidadTotal :: Flota -> Int
durabilidadTotal = sum . map durabilidad

--------------
-- Punto 03 --
--------------
comoQueda :: Nave -> Nave -> Nave
comoQueda naveAtacada naveAtacante
  | escudo naveAtacadaActiva > ataque naveAtacanteActiva = naveAtacadaActiva
  | otherwise = modificarDurabilidad (+ (-danioRecibido)) naveAtacadaActiva
  where
    naveAtacadaActiva = poder naveAtacante naveAtacante
    naveAtacanteActiva = poder naveAtacada naveAtacada
    danioRecibido = ataque naveAtacanteActiva - escudo naveAtacadaActiva

--------------
-- Punto 04 --
--------------
estaFueraDeCombate :: Nave -> Bool
estaFueraDeCombate = (== 0) . durabilidad

--------------
-- Punto 05 --
--------------
type Estrategia = Nave -> Bool

comoQuedaFlota :: Flota -> Estrategia -> Nave -> Flota
comoQuedaFlota flotaEnemiga unaEstrategia naveAtacante = afectarALosQueCumplen unaEstrategia (`comoQueda` naveAtacante) flotaEnemiga

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen unaCondicion unaTransformacion unaLista = (map unaTransformacion . filter unaCondicion) unaLista ++ filter (not . unaCondicion) unaLista

-- 1 --
esNaveDebil :: Estrategia
esNaveDebil = (< 200) . escudo

-- 2 --
esNavePeligrosa :: Int -> Estrategia
esNavePeligrosa nivelPeligrosidad = (> nivelPeligrosidad) . ataque

-- 3 --
quedaFueraDeCombate :: Nave -> Estrategia
quedaFueraDeCombate naveAtacante = estaFueraDeCombate . (`comoQueda` naveAtacante)

-- 4 --
nuevaEstrategia :: Estrategia
nuevaEstrategia = (< 100) . ataque

--------------
-- Punto 06 --
--------------
misionMinimizada :: Nave -> Flota -> Estrategia -> Estrategia -> Flota
misionMinimizada unaNave unaFlota estrategia1 estrategia2
  | durabilidadTotal (comoQuedaFlota unaFlota estrategia1 unaNave) < durabilidadTotal (comoQuedaFlota unaFlota estrategia2 unaNave) = comoQuedaFlota unaFlota estrategia1 unaNave
  | otherwise = comoQuedaFlota unaFlota estrategia2 unaNave

--------------
-- Punto 07 --
--------------
flotaInfinita :: Flota
flotaInfinita = repeat naveDarthVader

{-
No es posible calcular la durabilidad total de la flota infinita, ya que se estaría queriendo hacer una sumatoria
de infinitas durabilidades, y esto nunca termianría.

Por como planteé el comoQuedaFlota, no se obtendría ningún resultado ya que primero deberían filtrarse las naves que cumplen con la
estrategia y las que no, y dado que es una flota infinita de naves, nunca podrían terminarse dichos filtrados
-}