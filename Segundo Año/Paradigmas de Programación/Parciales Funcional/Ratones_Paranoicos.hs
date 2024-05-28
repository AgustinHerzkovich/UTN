{-# OPTIONS_GHC -Wno-empty-enumerations #-}
import Text.Show.Functions
import Control.Monad.Signatures (Pass)
import Data.List

isAlfa x = elem x ['a' .. 'Z']

isUpper x = elem x ['A' .. 'Z']

isDigit x = elem x ['0' .. '9']

-- devuelve los segmentos finales de una lista
-- Ej: tails "abc" == ["abc", "bc", "c",""]
-- tails :: [a] -> [[a]]

-- convierte un carácter a su código ASCII
-- fromEnum :: Char -> Int

-- convierte un código ASCII en carácter
-- toEnum :: Int -> Char

diccionario = ["aaron", "abaco", "abecedario", "baliente", "beligerante"]

---------------
--- Punto A ---
---------------
type Password = String

type Requisito = Password -> Bool

-- 1.
empiezaConLetra :: Char -> Requisito
empiezaConLetra unaLetra = (== unaLetra) . head

-- 2.
tieneAlMenosUnNumero :: Requisito
tieneAlMenosUnNumero = any isDigit

-- 3.
tieneXMayusculas :: Int -> Requisito
tieneXMayusculas x = (== x) . length . filter isUpper

-- 4.
esIndeducible :: Requisito
esIndeducible unaPassword = (not . any (contieneA unaPassword)) diccionario

empiezaCon :: String -> String -> Bool
empiezaCon _ [] = False
empiezaCon cadena subcadena = (== subcadena) . take (length subcadena) $ cadena

contieneA :: String -> String -> Bool
contieneA cadena subcadena = any (empiezaCon subcadena) (tails cadena)

---------------
--- Punto B ---
---------------
type Aplicacion = ([Usuario], [Requisito], MetodoEncriptado)

type Usuario = (Nombre, PasswordEncriptado)

type Nombre = String

type PasswordEncriptado = Password

type MetodoEncriptado = Password -> PasswordEncriptado

crearUsuario :: Nombre -> Password -> Usuario
crearUsuario unNombre unaPassword = (unNombre, unaPassword)

-- Aplicación de prueba
bancoNacion :: Aplicacion
bancoNacion = ([("juan", "sdsdiulwd"), ("robby", "sxwrhotxhlhh")], [tieneAlMenosUnNumero, esIndeducible], textoHash)

-- 1.
puedoUsar :: Password -> Aplicacion -> Bool
puedoUsar unaPassword (_, requisitos, _) = all ($ unaPassword) requisitos

-- 2.
-- a.
cesar :: Int -> MetodoEncriptado
cesar n = map (toEnum . (+ 3) . fromEnum)

-- b.
textoHash :: MetodoEncriptado
textoHash = show . sum . map fromEnum

-- 3.
registrarse :: Nombre -> Password -> Aplicacion -> Aplicacion
registrarse unNombre unaPassword (usuarios, requisitos, metodo)
    | puedoUsar unaPassword (usuarios, requisitos, metodo) = (crearUsuario unNombre (metodo unaPassword) : usuarios, requisitos, metodo)
    | otherwise = (usuarios, requisitos, metodo)

-- 4.
-- a.
paradigma :: Aplicacion
paradigma = ([], [(> 6) . length,not . empiezaConLetra 't'], cesar 4)

-- b.
facebutt :: Aplicacion
facebutt = ([("usuario " ++ show n,textoHash $ "laPasswordDificil" ++ show n) | n <- [1..]],[], id)

{-
la función puedoUsar puede utilizarse en facebutt, de hecho, siempre retornará True independientemente
de la password que se utilice, ya que esta aplicación acepta cualquier password.

la función registrarse también puede utilizarse en facebutt, sin embargo, al contener infinitos usuarios,
nunca terminará de mostrar la lista de ellos en su totalidad.
-}