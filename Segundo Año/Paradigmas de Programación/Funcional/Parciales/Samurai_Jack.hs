data Elemento = UnElemento
  { tipo :: String,
    ataque :: Personaje -> Personaje,
    defensa :: Personaje -> Personaje
  }

data Personaje = UnPersonaje
  { nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int
  }

---------------
--- Punto 1 ---
---------------
-- a.
mandarAlAnio :: Int -> Personaje -> Personaje
mandarAlAnio unAnio unPersonaje = unPersonaje {anioPresente = unAnio}

-- b.
meditar :: Personaje -> Personaje
meditar unPersonaje = sumarSalud (salud unPersonaje / 2) unPersonaje

sumarSalud :: Float -> Personaje -> Personaje
sumarSalud agregado unPersonaje = unPersonaje {salud = max 0 (salud unPersonaje + agregado)}

-- c.
causarDanio :: Float -> Personaje -> Personaje
causarDanio danio = sumarSalud (-danio)

---------------
--- Punto 2 ---
---------------
-- a.
esMalvado :: Personaje -> Bool
esMalvado = any ((== "Maldad") . tipo) . elementos

-- b.
danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce unPersonaje unElemento = salud unPersonaje - (salud . ataque unElemento) unPersonaje

-- c.
enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales unPersonaje = filter (puedeMatarConUnSoloElemento unPersonaje)

puedeMatarConUnSoloElemento :: Personaje -> Personaje -> Bool
puedeMatarConUnSoloElemento unPersonaje = any (`puedeMatar` unPersonaje) . elementos

puedeMatar :: Elemento -> Personaje -> Bool
puedeMatar unElemento = estaMuerto . ataque unElemento

estaMuerto :: Personaje -> Bool
estaMuerto = (== 0) . salud

---------------
--- Punto 3 ---
---------------
-- a.
concentracion :: Int -> Elemento
concentracion nivel = UnElemento "Magia" id (aplicarMeditarNVeces nivel)

aplicarMeditarNVeces :: Int -> Personaje -> Personaje
aplicarMeditarNVeces n unPersonaje = iterate meditar unPersonaje !! n

-- b.
esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidad = replicate cantidad esbirro

esbirro :: Elemento
esbirro = UnElemento "Maldad" (causarDanio 1) id

-- c.
jack :: Personaje
jack = UnPersonaje "Jack" 300 [concentracion 3, katanaMagica] 200

katanaMagica :: Elemento
katanaMagica = UnElemento "Magia" (causarDanio 1000) id

-- d.
aku :: Int -> Float -> Personaje
aku anioVida cantidadSalud = UnPersonaje "Aku" cantidadSalud ([concentracion 4, portalAlFuturo anioVida] ++ esbirrosMalvados (100 * anioVida)) anioVida

portalAlFuturo :: Int -> Elemento
portalAlFuturo anio = UnElemento "Magia" (mandarAlAnio anioFuturo) (aku anioFuturo .salud)
    where
        anioFuturo = anio + 2800

---------------
--- Punto 4 ---
---------------
luchar :: Personaje -> Personaje -> (Personaje, Personaje)
luchar atacante defensor
  | estaMuerto atacante = (defensor, atacante)
  | otherwise = luchar (efecto defensor $ ataques atacante) (efecto atacante $ defensas atacante)

efecto :: Personaje -> [Personaje -> Personaje] -> Personaje
efecto = foldr ($)

ataques :: Personaje -> [Personaje -> Personaje]
ataques = map ataque . elementos

defensas :: Personaje -> [Personaje -> Personaje]
defensas = map defensa . elementos

---------------
--- Punto 5 ---
---------------
f :: (Num a, Eq b) => (b -> c -> (d, d)) -> (a -> b) -> b -> [c] -> [d]
f x y z
  | y 0 == z = map (fst . x z)
  | otherwise = map (snd . x (y 0))

-- Razonamiento
{-
f x y z w
  | y 0 == z = map (fst . x z) w
  | otherwise = map (snd . x (y 0)) w

En el primer caso vemos que y se aplica con un 0, y eso brinda un resultado que puede
compararse por igualdad con z, es decir que el resultado de aplicarle un número
a y, es del mismo tipo que z, y además deben ser Eq
Deduzo entonces que y = (a -> b) con Num a ; z = b con Eq b

Por otro lado se mapea una lista w con la función (fst . x z)
map :: (t1 -> t2) -> [t1] -> [t2]

x se aplica con z, por lo que x es una función que al recibir un parámetro de tipo z
se convierte en una función susceptible de ser mapeable en la lista w
Deduzco que x = (b -> c -> d) por el momento, entonces w = [c]
la lista resultado de ese mapeo queda de tipo [d] y esta se mapea con la
función fst, por lo que d es una tupla
x = (b -> c -> (nose1,nose2)) ; w = [c] y la función retornaría [nose1]

Vemos el último caso para ver si puedo sacar alguna información más
Sabemos que y 0 es algo de tipo b, y que x recibe justamente algo de tipo b, por lo que
todo coincide. Mapeo la lista y me queda [(nose1,nose2)] , y esta la mapeo con snd
Por lo que esto me indica que nose1 es del mismo tipo que nose2, lo bautizo como d.
nose1 = nose2 = d.
Finalmente x = (b -> c -> (d , d))
y el resultado de la función es de tipo [d]
-}