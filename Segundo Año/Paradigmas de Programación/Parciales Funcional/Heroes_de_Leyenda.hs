---------------
--- Punto 1 ---
---------------
data Heroe = Heroe{
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
}

data Artefacto = Artefacto{
    nombreArtefacto :: String,
    rareza :: Int
} deriving Show
---------------
--- Punto 2 ---
---------------
cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto nuevoEpiteto unHeroe = unHeroe{epiteto = nuevoEpiteto}

añadirArtefacto :: Artefacto -> Heroe -> Heroe
añadirArtefacto nuevoArtefacto unHeroe = unHeroe{artefactos = nuevoArtefacto : artefactos unHeroe}

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza del Olimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe
    | reconocimiento unHeroe > 1000 = cambiarEpiteto "El mitico" unHeroe
    | reconocimiento unHeroe >= 500 = cambiarEpiteto "El magnifico" . añadirArtefacto lanzaDelOlimpo $ unHeroe
    | reconocimiento unHeroe > 100 = cambiarEpiteto "Hoplita" . añadirArtefacto xiphos $ unHeroe
    | otherwise = unHeroe
---------------
--- Punto 3 ---
---------------
type Tarea = Heroe -> Heroe

type Debilidad = Heroe -> Bool
data Bestia = Bestia{
    nombreBestia :: String,
    debilidad :: Debilidad
}

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "Relampago de Zeus" 500

ganarReconocimiento :: Int -> Heroe -> Heroe
ganarReconocimiento cantidad unHeroe = unHeroe{reconocimiento = reconocimiento unHeroe + cantidad}

esComun :: Artefacto -> Bool
esComun unArtefacto = rareza unArtefacto < 1000

desecharArtefactosComunes :: Heroe -> Heroe
desecharArtefactosComunes unHeroe = unHeroe{artefactos = filter (not. esComun) $ artefactos unHeroe}

triplicarRareza :: Artefacto -> Artefacto
triplicarRareza unArtefacto = unArtefacto{rareza = ((*3).rareza) unArtefacto}

triplicarRarezaArtefactos :: Heroe -> Heroe
triplicarRarezaArtefactos unHeroe = unHeroe{artefactos = map triplicarRareza $ artefactos unHeroe}

perderPrimerArtefacto :: Heroe -> Heroe
perderPrimerArtefacto unHeroe = unHeroe{artefactos = tail $ artefactos unHeroe}
encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto =  añadirArtefacto unArtefacto . ganarReconocimiento (rareza unArtefacto)

escalarElOlimpo :: Tarea
escalarElOlimpo = añadirArtefacto relampagoDeZeus . desecharArtefactosComunes . triplicarRarezaArtefactos . ganarReconocimiento 500

ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle cuadras = cambiarEpiteto ("Gros" ++ replicate cuadras 'o')

matarUnaBestia :: Bestia -> Tarea
matarUnaBestia unaBestia unHeroe
    | debilidad unaBestia unHeroe = cambiarEpiteto ("El asesino de " ++ nombreBestia unaBestia) unHeroe
    | otherwise = cambiarEpiteto "El cobarde" . perderPrimerArtefacto $ unHeroe
---------------
--- Punto 4 ---
---------------
pistola :: Artefacto
pistola = Artefacto "Fierro en la Antigua Grecia" 1000

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [pistola,relampagoDeZeus] [matarAlLeonDeNemea]
---------------
--- Punto 5 ---
---------------
epitetoMayorA20Caracteres :: Debilidad
epitetoMayorA20Caracteres = (>20).length.epiteto

leonDeNemea :: Bestia
leonDeNemea = Bestia "Leon de Nemea" epitetoMayorA20Caracteres

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea = matarUnaBestia leonDeNemea
---------------
--- Punto 6 ---
---------------
añadirTarea :: Tarea -> Heroe -> Heroe
añadirTarea unaTarea unHeroe = unHeroe{tareas = unaTarea : tareas unHeroe}

hacerUnaTarea :: Tarea -> Heroe -> Heroe
hacerUnaTarea unaTarea = añadirTarea unaTarea . unaTarea
---------------
--- Punto 7 ---
---------------
rarezasDe :: Heroe -> [Int]
rarezasDe = map rareza.artefactos

sumatoriaRarezasArtefactos :: Heroe -> Int
sumatoriaRarezasArtefactos = sum . rarezasDe

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe otroHeroe = realizarLabor $ tareas otroHeroe

gano :: Heroe -> Heroe -> Bool
gano unHeroe otroHeroe = reconocimiento unHeroe > reconocimiento otroHeroe || reconocimiento unHeroe == reconocimiento otroHeroe && sumatoriaRarezasArtefactos unHeroe > sumatoriaRarezasArtefactos otroHeroe

presumir :: Heroe -> Heroe -> (Heroe,Heroe)
presumir unHeroe otroHeroe
    | gano unHeroe otroHeroe = (unHeroe,otroHeroe)
    | gano otroHeroe unHeroe = (otroHeroe,unHeroe)
    | otherwise = presumir (realizarTareasDe otroHeroe unHeroe) (realizarTareasDe unHeroe otroHeroe)
---------------
--- Punto 8 ---
---------------
{-Hacer que presuman dos héroes con reconocimiento 100, ningún artefacto y ninguna tarea realizada
no arroja ningún resultado, ya que la función presumir se quedará en un bucle infinito
y nunca podrá decidir quién ganó, debido a que luego de llamarse recursivamente, los héroes quedan igual
a como estaban por no tener tareas ni artefactos y el mismo reconocimiento. -}
---------------
--- Punto 9 ---
---------------
realizarLabor :: [Tarea] -> Heroe -> Heroe
realizarLabor labor unHeroe = foldr hacerUnaTarea unHeroe labor
-----------------
--- Punto 10 ---
-----------------
{-Si invocamos la función anterior con una labor infinita, no podrá conocerse el estado final del héroe
debido a que el foldr nunca logrará converger a su caso base, es decir, cuando la lista de tareas
es vacía, por lo tanto se quedará procesando infinitamente sin imprimir ningún resultado por pantalla. -}