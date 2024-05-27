data Chico = Chico
  { nombreChico :: String,
    edad :: Int,
    habilidadesChico :: [Habilidad],
    deseos :: [Deseo]
  }

type Habilidad = String

type Deseo = Chico -> Chico

---------------
--- Punto A ---
---------------
-- 1.
-- a.
aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades habilidades unChico = unChico {habilidadesChico = habilidades ++ habilidadesChico unChico}

-- b.
serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = aprenderHabilidades ["jugar need for speed " ++ show n | n <- [1 ..]]

-- c.
modificarEdad :: Int -> Chico -> Chico
modificarEdad nuevaEdad unChico = unChico {edad = nuevaEdad}

serMayor :: Deseo
serMayor = modificarEdad 18

-- 2.
-- a.
quitarDeLaLista :: (Eq a) => a -> [a] -> [a]
quitarDeLaLista _ [] = []
quitarDeLaLista elemento (x : xs)
  | elemento == x = xs
  | otherwise = x : quitarDeLaLista elemento xs

cumplirDeseo :: Deseo -> Chico -> Chico
cumplirDeseo unDeseo = unDeseo

aumentarEdad :: Int -> Chico -> Chico
aumentarEdad aumento unChico = unChico {edad = edad unChico + aumento}

madurar :: Deseo
madurar = aumentarEdad 1

wanda :: Chico -> Chico
wanda unChico = (madurar . cumplirDeseo (head . deseos $ unChico)) unChico

-- b .
cosmo :: Chico -> Chico
cosmo unChico = unChico {edad = edad unChico `div` 2}

-- c.
muffinMagico :: Chico -> Chico
muffinMagico unChico = foldr cumplirDeseo unChico $ deseos unChico

---------------
--- Punto B ---
---------------
