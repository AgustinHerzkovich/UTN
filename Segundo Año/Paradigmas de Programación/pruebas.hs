-- fibonacci
fibonacci :: (Eq a, Num a) => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = (n - 1) + (n - 2)

-- tipos algebraicos
data Persona = Persona
  { nombre :: String,
    edad :: Int,
    domicilio :: String,
    telefono :: String,
    fechaNacimiento :: (Int, Int, Int),
    buenaPersona :: Bool,
    plata :: Float
  }deriving(Show)

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
    }-- tupla que solo devuelve el nombre y edad de una persona dada
datosPrincipales :: Persona -> (String, Int)
datosPrincipales personita = (nombre personita, edad personita)
