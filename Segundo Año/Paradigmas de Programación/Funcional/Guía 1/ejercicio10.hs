dia1 :: Integer
dia1 = 322

dia2 :: Integer
dia2 = 283

dia3 :: Integer
dia3 = 294

maxEx :: Ord a => a -> a -> a -> a
maxEx a b c = max a b `max` c

minEx :: Ord a => a -> a -> a -> a
minEx a b c = min a b `min` c

dispersion :: (Num a, Ord a) => a -> a -> a -> a
dispersion medicion1 medicion2 medicion3 = maxEx medicion1 medicion2 medicion3 - minEx medicion1 medicion2 medicion3

diasParejos :: (Num a, Ord a) => a -> a -> a -> Bool
diasParejos medicion1 medicion2 medicion3 = dispersion medicion1 medicion2 medicion3 < 30

diasLocos :: (Num a, Ord a) => a -> a -> a -> Bool
diasLocos  medicion1 medicion2 medicion3 = dispersion medicion1 medicion2 medicion3 > 100

diasNormales :: (Num a, Ord a) => a -> a -> a -> Bool
diasNormales medicion1 medicion2 medicion3 = not (diasParejos medicion1 medicion2 medicion3 || diasLocos medicion1 medicion2 medicion3)

{-
Dispersión
Trabajamos con tres números que imaginamos como el nivel del río Paraná a la altura de Corrientes medido en tres días consecutivos; 
cada medición es un entero que representa una cantidad de cm. 
P.ej. medí los días 1, 2 y 3, las mediciones son: 322 cm, 283 cm, y 294 cm. 
A partir de estos tres números, podemos obtener algunas conclusiones. 
Definir estas funciones: 

dispersion, que toma los tres valores y devuelve la diferencia entre el más alto y el más bajo. Ayuda: extender max y min a tres argumentos, 
usando las versiones de dos elementos. De esa forma se puede definir dispersión sin escribir ninguna guarda (las guardas están en max y min, que estamos usando). 

diasParejos, diasLocos y diasNormales reciben los valores de los tres días. Se dice que son días parejos si la dispersión es chica, 
que son días locos si la dispersión es grande, y que son días normales si no son ni parejos ni locos. Una dispersión se considera chica si es de menos de 30 cm,
 y grande si es de más de un metro. 
Nota: Definir diasNormales a partir de las otras dos, no volver a hacer las cuentas.
-}