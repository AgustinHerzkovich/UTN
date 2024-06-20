-- Información que maneja el sistema
type Requisito = Depto -> Bool

type Busqueda = [Requisito]

type Depto = (Int, Int, Int, String)

type Persona = (String, [Busqueda])

-- Funciones para usar en el desarrollo
ambientes :: Depto -> Int
ambientes (a, _, _, _) = a

superficie :: Depto -> Int
superficie (_, m2, _, _) = m2

precio :: Depto -> Int
precio (_, _, p, _) = p

barrio :: Depto -> String
barrio (_, _, _, b) = b

mail :: Persona -> String
mail = fst

busquedas :: Persona -> [Busqueda]
busquedas = snd

ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x : xs) = (ordenarSegun criterio . filter (not . criterio x)) xs ++ [x] ++ (ordenarSegun criterio . filter (criterio x)) xs

between :: (Ord a) => a -> a -> a -> Bool
between x y z = x <= z && y >= z

-- Departamentos de ejemplo
deptosDeEjemplo :: [Depto]
deptosDeEjemplo = [(3, 80, 7500, "Palermo"), (1, 45, 3500, "Villa Urquiza"), (2, 50, 5000, "Palermo"), (1, 45, 5500, "Recoleta")]

---------------
--- Punto 1 ---
---------------
-- a.
mayor :: (Ord b) => (a -> b) -> a -> a -> Bool
mayor f x y = f x > f y

menor :: (Ord b) => (a -> b) -> a -> a -> Bool
menor f x y = f x < f y

-- b.

-- Ejemplo
-- ghci> ordenarSegun (mayor length) ["aaaaaaaaaa","b","cccccccccccccccccccccc"]
-- ghci> ["cccccccccccccccccccccc","aaaaaaaaaa","b"]
-- ghci> ordenarSegun (menor length) ["aaaaaaaaaa","b","cccccccccccccccccccccc"]
-- ghci> ["b","aaaaaaaaaa","cccccccccccccccccccccc"]

---------------
--- Punto 2 ---
---------------
-- a.
ubicadoEn :: [String] -> Requisito
ubicadoEn barrios = (`elem` barrios) . barrio

-- b.
cumpleRango :: (Num a, Ord a) => (Depto -> a) -> a -> a -> Requisito
cumpleRango funcion x y = between x y . funcion

---------------
--- Punto 3 ---
---------------
-- a.
cumpleBusqueda :: Busqueda -> Depto -> Bool
cumpleBusqueda unaBusqueda unDepto = all ($ unDepto) unaBusqueda

-- b.
buscar :: Busqueda -> (Depto -> Depto -> Bool) -> [Depto] -> [Depto]
buscar unaBusqueda criterio = ordenarSegun criterio . filter (cumpleBusqueda unaBusqueda)

-- c.

-- Ejemplo
-- ghci> buscar [ubicadoEn ["Recoleta","Palermo"],cumpleRango ambientes 1 2,((<6000).precio)] (mayor superficie) deptosDeEjemplo
-- ghci> [(2,50,5000,"Palermo"),(1,45,5500,"Recoleta")]

---------------
--- Punto 4 ---
---------------
mailsDePersonasInteresadas :: Depto -> [Persona] -> [String]
mailsDePersonasInteresadas unDepto = map mail . filter (interesadaEn unDepto)

interesadaEn :: Depto -> Persona -> Bool
interesadaEn unDepto = any (`cumpleBusqueda` unDepto) . busquedas

---------------
--- Punto 5 ---
---------------
f :: (Ord b) => (a -> b) -> ((a -> Bool) -> c) -> [(Int, a)] -> c
f x y = y . head . map (\(_, z) -> menor x z) . filter (even . fst)

-- Razonamiento
{-
f x y z :: (a -> b) -> (a-> Bool -> b) -> [(Int,a)] ->  b
f x y z = y . head . map (\(_, z) -> menor x z) . filter (even . fst) $ z
y es una función que recibe la cabeza de una lista y le hace algo
z es una lista de tuplas, de las cuales el primer elemento puede ser par
z :: [(Int,nose)]
se filtra la lista quedando sólo las tuplas con primer elemento par

luego se mapea esa lista con una función lambda que dada una tupla
me devuelve una aplicación parcial de la función menor, donde x es
la función, y el segundo elemento de la tupla es el primer parámetro,
por lo tanto me queda una función que espera otro elemento del mismo
tipo que el anterior y devuelve Bool.
como resultado del mapeo, obtengo una lista de funciones de tipo (a -> Bool)
de aquí concluyo que x :: (a -> b) donde b debe ser Ord
y además z :: [(Int,a)]

ahora a esa lista le saco la cabeza, osea que me queda un elemento
que es una función a -> Bool, y eso se aplica en y, entonces, y es una
función de orden superior que recibe un (a -> Bool) y devuelve algo, donde
ese algo es el tipo del resultado final de la función f
y :: ((a -> Bool) -> c)
-}