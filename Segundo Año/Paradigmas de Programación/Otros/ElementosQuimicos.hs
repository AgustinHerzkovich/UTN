data Sustancia
  = Sencilla
      { elemento :: Elemento
      }
  | Compuesta{
    compuesto :: (Sust,Int),
    nombreC :: String,
    simboloQuimicoC :: String,
    especieC :: Grupo
  }

data Elemento = Elemento
  { nombreE :: String,
    simboloQuimicoE :: String,
    numeroAtomico :: Float,
    especieE :: Grupo
  }

data Sust = Elem Elemento | Compuesto

data Grupo = Metal | NoMetal | Halogeno | GasNoble

--1)
--a)
hidrogeno = Sustancia{

}

{-
Leer el texto atentamente e indicar para cada una de las frases si es:

Requerimiento Funcional
Requerimiento No Funcional
No corresponde al texto
No es un Requerimiento
Enunciado Voto Web:

El nuevo sistema de “Voto vía web”, debe permitir realizar la votación a través de internet, ingresando a la página web de la Universidad.

Se considera sufragante, a aquellos alumnos de la Facultad que ya poseen un número de legajo y un código de identificación (PIN), el cual fue obtenido en el Anexo correspondiente.

El sufragante deberá ingresar su PIN y su número de Legajo para poder efectuar su voto. El sistema validará que estos datos sean correctos. Si la validación es satisfactoria, 
el sistema mostrará en pantalla la lista de candidatos. El sufragante deberá seleccionar sus candidatos de la lista de candidatos. Para finalizar la selección, el sufragante deberá 
presionar el botón “Votar”. El sistema deberá emitir un comprobante de voto.

En caso de que la validación sea incorrecta, el sistema deberá emitir un mensaje de advertencia y no permitirá el ingreso al sistema de votación.

El sufragante, además, podrá ingresar al sistema (también ingresando su legajo y PIN), para realizar la consulta de candidatos disponibles y las propuestas de cada uno.

Con todos los votos emitidos, el Comité de votación, deberá poder generar un Registro de votos electrónicos. Además, finalizada la votación, el Comité deberá poder generar un listado 
con los ganadores de las elecciones y sus porcentajes.

-}