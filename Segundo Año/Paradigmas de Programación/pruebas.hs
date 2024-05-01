{-# LANGUAGE OverloadedStrings #-}


-- fibonacci
fibonacci :: (Eq a, Num a) => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = (n - 1) + (n - 2)

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

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

combinatorio :: (Integral a) => a -> a -> a
combinatorio n m = factorial n `div` (factorial m * factorial (n - m))

variacion :: Int -> Int -> Int
variacion n m = factorial n `div` factorial (n - m)

probabilidadBinomial :: (Integral a, Fractional b) => a -> b -> a -> b
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
  deriving (Show,Eq)

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
