data Persona = Persona{
    nombre :: String,
    apellido :: String,
    dni :: Int
}

juan :: Persona
juan = Persona "Juan" "Perez" 9823123

esMayorDeEdad :: (Persona,Int) -> Bool
esMayorDeEdad  = (>21) . snd 

{-
Definir la función esMayorDeEdad, que dada una tupla de 2 elementos (persona, edad) me devuelva True si es mayor de 21 años y False en caso contrario. Por Ej:.
Main> esMayorDeEdad (juan,18) 
False 
Nota: Definir la función utilizando aplicación parcial y composición.
-}
