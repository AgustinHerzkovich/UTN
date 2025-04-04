{-# LANGUAGE OverloadedStrings #-}
import Text.Show.Functions
import Data.List

-- fibonacci
fibonacci :: Integer -> Integer
fibonacci n
  | n == 0 = 0
  | n == 1 = 1
  | n > 1 = fibonacci (n - 1) + fibonacci (n - 2)

{-
-- tipos algebraicos
data Persona = Persona
  { nombre :: String,
    edad :: Int,
    domicilio :: String,
    telefono :: String,
    fechaNacimiento :: (Int, Int, Int),
    buenaPersona :: Bool,
    plata :: Float
  }
  deriving (Show)

juan :: Persona
juan =
  Persona
    { nombre = "Juan",
      edad = 29,
      domicilio = "Ayacucho 554",
      telefono = "45232598",
      fechaNacimiento = (17, 7, 1988),
      buenaPersona = True,
      plata = 30.0
    } -- tupla que solo devuelve el nombre y edad de una persona dada

datosPrincipales :: Persona -> (String, Int)
datosPrincipales personita = (nombre personita, edad personita)

-}

factorial :: Integer -> Integer
factorial n
  | n == 0 = 1
  | n > 0 = n * factorial (n - 1)

combinatorio :: Integer -> Integer -> Integer
combinatorio n m = factorial n `div` (factorial m * factorial (n - m))

variacion :: Integer -> Integer -> Integer
variacion n m = factorial n `div` factorial (n - m)

probabilidadBinomial :: Integer -> Double -> Integer -> Double
probabilidadBinomial n p k = fromIntegral (combinatorio n k) * (p ^ k) * (1 - p) ^ (n - k)

{-
Supongamos que estás desarrollando un sistema de gestión de productos para una tienda en Haskell. Debes definir un tipo de datos Producto que represente un producto en la tienda.
Cada producto debe tener un nombre, un precio y una categoría. Además, necesitas implementar algunas funciones para trabajar con estos productos.

Define el tipo Producto con los campos nombre (String), precio (Double) y categoria (String).
Crea una función llamada crearProducto que tome como argumentos un nombre, un precio y una categoría, y devuelva un valor de tipo Producto.
Implementa una función llamada mostrarProducto que tome un producto y devuelva una cadena que muestre su nombre, precio y categoría de la siguiente manera:
"Nombre: <nombre> | Precio: <precio> | Categoría: <categoría>".
Crea una función llamada actualizarPrecio que tome un producto, un nuevo precio y devuelva un nuevo producto con el precio actualizado.
Implementa una función llamada productosDeCategoria que tome una lista de productos y una categoría, y devuelva una lista con solo los productos que pertenecen a esa categoría.
Finalmente, escribe una función principal main que demuestre el uso de las funciones anteriores creando algunos productos, mostrándolos, actualizando sus precios y filtrando por categoría.
-}
data Producto = Producto
  { nombre :: String,
    precio :: Double,
    categoria :: String
  }
  deriving (Show, Eq)

crearProducto :: String -> Double -> String -> Producto
crearProducto nuevonombre nuevoprecio nuevacategoria = Producto {nombre = nuevonombre, precio = nuevoprecio, categoria = nuevacategoria}

mostrarProducto :: Producto -> String
mostrarProducto producto = "Nombre: " ++ nombre producto ++ " | Precio: " ++ (show . precio) producto ++ " | Categoria: " ++ categoria producto

actualizarPrecio :: Producto -> Double -> Producto
actualizarPrecio producto nuevoprecio = producto {precio = nuevoprecio}

productosDeCategoria :: [Producto] -> String -> [Producto]
productosDeCategoria lista categoriax = filter (\p -> categoria p == categoriax) lista

producto1 :: Producto
producto1 = crearProducto "Laptop" 1500.0 "Electrónicos"

producto2 :: Producto
producto2 = crearProducto "Camisa" 25.0 "Ropa"

producto3 :: Producto
producto3 = crearProducto "Teléfono" 800.0 "Electrónicos"

producto4 :: Producto
producto4 = crearProducto "Pantalón" 30.0 "Ropa"

producto5 :: Producto
producto5 = crearProducto "Silla" 50.0 "Muebles"

productosAleatorios :: [Producto]
productosAleatorios = [producto1, producto2, producto3, producto4, producto5]

{-
1. Elevar al cuadrado una lista de números: Define una función que tome una lista de números y devuelva una lista con cada número elevado al cuadrado utilizando una función lambda.
-}

cuadrados :: Num a => [a] -> [a]
cuadrados = map (\numero -> numero^2) 

{-
2. Filtrar números pares: Define una función que tome una lista de números y devuelva una lista con solo los números pares utilizando una función lambda.
-}

filtrarPares :: [Int] -> [Int]
filtrarPares  = filter (\numero -> mod numero 2 == 0) 

{-
3. Convertir lista de strings a lista de sus longitudes: Define una función que tome una lista de strings y devuelva una lista con las longitudes de cada string utilizando una función 
lambda.
-}

longitudes :: [String] -> [Int]
longitudes  = map (\cadena -> length cadena) 

{-
4. Aplicar una operación a cada elemento de una lista: Define una función genérica que tome una lista y una función como argumentos y devuelva una lista donde cada elemento haya sido 
transformado por la función dada. Utiliza una función lambda para la transformación.
-}

aplicarOperacion :: (a->b) ->[a]  -> [b]
aplicarOperacion operacion = map (\x -> operacion x)

{-
5. Ordenar una lista de strings por longitud: Define una función que tome una lista de strings y devuelva la lista ordenada por longitud de strings, de menor a mayor, utilizando una 
función lambda y la función sort de Haskell.
-}

ordenarPorLongitud :: [String] -> [String]
ordenarPorLongitud = sortBy (\x y -> length x `compare` length y)