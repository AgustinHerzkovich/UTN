---------------
--- Punto 1 ---
---------------

data Turista = UnTurista
  { cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
  }

type Idioma = String

-- a.
ana :: Turista
ana = UnTurista 0 21 False ["español"]

-- b.
beto :: Turista
beto = UnTurista 15 15 True ["aleman"]

cathi :: Turista
cathi = UnTurista 15 15 True ["aleman", "catalan"]

---------------
--- Punto 2 ---
---------------
type Excursion = Turista -> Turista

data Marea = Fuerte | Moderada | Tranquila deriving (Eq)

-- Funciones auxiliares
bajarCansancio :: Int -> Turista -> Turista
bajarCansancio n unTurista = unTurista {cansancio = cansancio unTurista - n}

bajarStress :: Int -> Turista -> Turista
bajarStress n unTurista = unTurista {stress = stress unTurista - n}

continuarAcompañado :: Turista -> Turista
continuarAcompañado unTurista = unTurista {viajaSolo = False}

aprenderIdioma :: Idioma -> Turista -> Turista
aprenderIdioma unIdioma unTurista = unTurista {idiomas = unIdioma : idiomas unTurista}

intensidad :: Int -> Int
intensidad = (`div` 4)

-- Excursiones
irAlaPlaya :: Excursion
irAlaPlaya unTurista
  | viajaSolo unTurista = bajarCansancio 5 unTurista
  | otherwise = bajarStress 1 unTurista

apreciar :: String -> Excursion
apreciar = bajarStress . length

salirAHablar :: Idioma -> Excursion
salirAHablar unIdioma = continuarAcompañado . aprenderIdioma unIdioma

caminar :: Int -> Excursion
caminar minutos = bajarStress (intensidad minutos) . bajarCansancio (negate (intensidad minutos))

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Fuerte = bajarCansancio (-10) . bajarStress (-6)
paseoEnBarco Moderada = id
paseoEnBarco Tranquila = salirAHablar "aleman" . apreciar "mar" . caminar 10

-- a.
hacerUnaExcursion :: Excursion -> Turista -> Turista
hacerUnaExcursion unaExcursion unTurista = bajarStress (stress unTurista `div` 10) . unaExcursion $ unTurista

-- b.
deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun indice unTurista unaExcursion = deltaSegun indice (hacerUnaExcursion unaExcursion unTurista) unTurista

-- c.
esEducativa :: Turista -> Excursion -> Bool
esEducativa unTurista = (> 0) . deltaExcursionSegun stress unTurista

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes unTurista = filter (esDesestresante unTurista)

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante unTurista = (>= 3) . abs . deltaExcursionSegun stress unTurista

---------------
--- Punto 3 ---
---------------
type Tour = [Excursion]

completo :: Tour
completo = [caminar 20, apreciar "cascada", caminar 40, irAlaPlaya, salirAHablar "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB unaExcursion = [paseoEnBarco Tranquila, hacerUnaExcursion unaExcursion, caminar 120]

islaVecina :: Marea -> Tour
islaVecina mareaVecina = [paseoEnBarco mareaVecina, excursionEnIslaVecina mareaVecina, paseoEnBarco mareaVecina]

excursionEnIslaVecina :: Marea -> Excursion
excursionEnIslaVecina Fuerte = apreciar "lago"
excursionEnIslaVecina _ = irAlaPlaya

-- a.
hacerTour :: Tour -> Turista -> Turista
hacerTour unTour = bajarStress (negate . length $ unTour) . realizarExcursionesEnOrden unTour

realizarExcursionesEnOrden :: [Excursion] -> Turista -> Turista
realizarExcursionesEnOrden excursiones unTurista = foldr id unTurista excursiones

-- b.
existeAlgunoConvincente :: Turista -> [Tour] -> Bool
existeAlgunoConvincente unTurista = any (esConvincente unTurista)

esConvincente :: Turista -> Tour -> Bool
esConvincente unTurista = any (`dejaAcompaniado` unTurista) . excursionesDesestresantes unTurista

dejaAcompaniado :: Excursion -> Turista -> Bool
dejaAcompaniado unaExcursion = not . viajaSolo . hacerUnaExcursion unaExcursion

-- c.
efectividadTour :: Tour -> [Turista] -> Int
efectividadTour unTour = sum . map (espiritualidadRecibida unTour) . filter (`esConvincente` unTour)

espiritualidadRecibida :: Tour -> Turista -> Int
espiritualidadRecibida unTour unTurista = (sum . perdidasDeStress $ unTour) + (sum . perdidasDeCansancio $ unTour)
  where
    perdidasDeStress = map (deltaExcursionSegun stress unTurista)
    perdidasDeCansancio = map (deltaExcursionSegun cansancio unTurista)

---------------
--- Punto 4 ---
---------------
-- a.
tourInfinito :: [Excursion]
tourInfinito = repeat irAlaPlaya

-- b.
{-
La respuesta a si se puede saber si el tourInfinito es convincente para determinado
turista, depende del turista en sí, ya que la función esConvincente lo primero que hace es filtrar
el tour según las excursiones desestresantes para el turista, y en caso de que no haya ninguna excursión desestresante,
ese filter no podrá mostrar nada por pantalla, se quedará procesando infinitamente. Esto es lo que sucede en el caso
de Beto, ya que a Beto no le desestresa ir a la playa, por ende la lista nunca se filtrará y se quedará en bucle infinito.
En cambio, en el caso de Ana, sí le desestresa ir a la playa, por lo que el filter no mostrará un único resultado sino que
imprimirá las infinitas excursiones del tour, y luego al entrar al any, vuelve a suceder algo parecido.
Si hay alguna excursión que deje acompañado al turista retornará True, pero si no hay ninguna, no podrá determinarlo ya que debería
recorrer la lista completa para responder False, y eso nunca sucederá.
En el caso de Ana, sí se cumple la condición del any por lo que la respuesta es True, en el caso de Beto, no
arroja resultado.
-}

-- c.
{-
Sí, el único caso en que se puede conocer la efectividad del tour es cuando la lista de turistas
está vacía, ya que al no haber turistas no tiene nada que filtrar, por ende el filter devuelve [], lo mismo
sucede con el map, en una lista vacía no hay nada que mapear, por ende el map devuelve [], y luego al hacer la sumatoria de
una lista vacía, el resultado es 0, ya que ese es su caso base.
En otros casos, no arroja resultado ya que nunca terminará de filtrar la lista, tampoco terminará de mapear y mucho menos sumarla,
por ende si se quisiera saber la efectividad del tourInfinito para un grupo de turistas no vacío, se quedará procesando
infinitamente y no será capaz de mostrar resultado alguno.
-}