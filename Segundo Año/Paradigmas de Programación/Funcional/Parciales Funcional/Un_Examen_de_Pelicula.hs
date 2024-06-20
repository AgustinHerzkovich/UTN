import Data.List(intersect,isInfixOf)
import Data.Char (isNumber)

type Pelicula = (String,[Actor],Int,Int)
type Actor = String

taxi :: Pelicula
taxi = ("Taxi driver", ["De Niro", "Foster"], 113, 1976)
machete :: Pelicula
machete = ("Machete", ["De Niro", "Rodriguez"], 105, 2010)
hp :: Pelicula
hp = ("Harry Potter 9", ["Watson", "Radcliffe", "Grint"], 252, 2015)

--------------
-- Punto 01 --
--------------
trabajo :: Actor -> Pelicula -> Bool
trabajo unActor  = elem unActor . actores

actores :: Pelicula -> [Actor]
actores (_,a,_,_) = a

fechaEstreno :: Pelicula -> Int
fechaEstreno (_,_,_,f) = f

duracion :: Pelicula -> Int
duracion (_,_,m,_) = m

nombrePelicula :: Pelicula -> String
nombrePelicula (n,_,_,_) = n
--------------
-- Punto 02 --
--------------
type Genero = String
todosLosActores :: [(Genero, [Actor])]
todosLosActores = [("comedia", ["Carrey", "Grint", "Stiller"]),("accion", ["Stallone", "Willis","Schwarzenegger"]), ("drama", ["De Niro", "Foster"])]

esDeGenero :: Genero -> Pelicula -> Bool
esDeGenero unGenero unaPelicula =  cantidadDeActoresDeGenero unGenero unaPelicula > cantidadDeActores unaPelicula `div` 2

cantidadDeActoresDeGenero :: Genero -> Pelicula -> Int
cantidadDeActoresDeGenero unGenero unaPelicula = length . intersect (actores unaPelicula) . concatMap snd . filter ((== unGenero) . fst) $ todosLosActores

cantidadDeActores :: Pelicula -> Int
cantidadDeActores  = length . actores
--------------
-- Punto 03 --
--------------
type Premio = Pelicula -> Bool

entre :: (Ord a) => a -> a -> a -> Bool
entre cotaInferior cotaSuperior numero = numero >= cotaInferior && numero <= cotaSuperior

-- Premios
tresSonMultitud :: Premio
tresSonMultitud = (== 3) . length . actores

clasicoSetentista :: Premio
clasicoSetentista = entre 1970 1979 . fechaEstreno

plomo :: Premio
plomo = (> 180) . duracion

zaga :: Premio
zaga = isNumber . last . nombrePelicula

gano :: Premio -> Pelicula -> Bool
gano unPremio = unPremio
--------------
-- Punto 04 --
--------------
type Cine = [(Pelicula,Int)]

sumaDeEspectadores :: [(Pelicula, Int)] -> Int
sumaDeEspectadores = sum . map snd

-- a --
cuantosVieron :: Pelicula -> Cine -> Int
cuantosVieron unaPelicula = sumaDeEspectadores . filter ((== unaPelicula) . fst)

-- b --
cuantosVieronPremiadas :: Premio -> Cine -> Int
cuantosVieronPremiadas unPremio = sumaDeEspectadores . filter (gano unPremio . fst)

-- c --
cuantosVieronProtagonizadaPor :: Actor -> Cine -> Int
cuantosVieronProtagonizadaPor unActor = sumaDeEspectadores . filter (trabajo unActor . fst)
--------------
-- Punto 05 --
--------------
type Festival = [Premio]
cannes :: [Premio]
cannes = [plomo,clasicoSetentista]

festivalBerlin :: Festival
festivalBerlin = [tresSonMultitud,zaga,clasicoSetentista]
-- a --
cuantosPremiosPuedeRecibir :: Pelicula -> Festival -> Int
cuantosPremiosPuedeRecibir unaPelicula = length . filter (`gano` unaPelicula)

-- b --
festivalMarDelPlata :: Festival
festivalMarDelPlata = [plomo,zaga,clasicoSetentista,clasico 40,clasico 60]

clasico :: Int -> Premio
clasico anio = entre (1900 + anio) (1909 + anio) . fechaEstreno

-- c --
festivalActores :: [Actor] -> Festival
festivalActores unosActores = [trabajan unosActores]

festivalAvellaneda :: Festival
festivalAvellaneda = festivalActores ["Suar","Darin"]

trabajan :: [Actor] -> Pelicula -> Bool
trabajan unosActores  = not . null . intersect unosActores . actores

-- d --
nuevoFestival :: Festival
nuevoFestival = [any (\actor -> length actor > 7) . actores, \(nombre, _, duracion, _) -> duracion > 180 && "Eterna" `isInfixOf` nombre]