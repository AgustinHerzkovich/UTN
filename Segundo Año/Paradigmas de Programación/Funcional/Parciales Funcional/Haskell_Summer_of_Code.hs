---------------
--- Dominio ---
---------------

type Propuesta = (NombreAlumno, Proyecto, [Skills], Anios)

type Proyecto = String

type Skills = String

type NombreAlumno = String

type Anios = Int

propuestasGHC :: [Propuesta]
propuestasGHC = [("franco", "detectorDeParcialesCopiados", ["definicionDeLenguajes", "parsing", "compiladores"], 3), ("adriel", "entornoDeProgramacionHechoEnHaskell", ["programacionFuncional", "monadas", "tiposDeDatosPropios"], 2)]

type Mentor = (NombreMentor, [Proyecto], Criterio)

type Criterio = Propuesta -> Puntos

type Puntos = Int

type NombreMentor = String

mentoresGHC :: [Mentor]
mentoresGHC = [("carlono", ["detectorDeParcialesCopiados", "mejorarPerformanceDelMotor"], (\propuesta -> (length . skills) propuesta + (aniosDeExperiencia propuesta))), ("nicolas", ["entornoDeProgramacionHechoEnHaskell", "extensionesDelLenguaje"], ((3 +) . aniosDeExperiencia))]

aniosDeExperiencia :: Propuesta -> Anios
aniosDeExperiencia (_, _, _, anios) = anios

skills :: Propuesta -> [Skills]
skills (_, _, sks, _) = sks

nombreAlumno :: Propuesta -> NombreAlumno
nombreAlumno (nombre, _, _, _) = nombre

proyecto :: Propuesta -> Proyecto
proyecto (_, proyectoAlumno, _, _) = proyectoAlumno

---------------
--- Punto 1 ---
---------------
puntosSegun :: Propuesta -> Mentor -> Puntos
puntosSegun propuesta mentor
  | esDeInteres mentor propuesta = 1 + criterio mentor propuesta
  | otherwise = criterio mentor propuesta

esDeInteres :: Mentor -> Propuesta -> Bool
esDeInteres (_, proyectos, _) (_, proyecto, _, _) = proyecto `elem` proyectos

criterio :: Mentor -> Criterio
criterio (_, _, criterio) = criterio

---------------
--- Punto 2 ---
---------------
puntajeTotal :: Propuesta -> [Mentor] -> Puntos
puntajeTotal propuesta = sum . map (puntosSegun propuesta)

---------------
--- Punto 3 ---
---------------
propuestasConChances :: [Propuesta] -> [Propuesta]
propuestasConChances = filter tieneMasDe3Skills

tieneMasDe3Skills :: Propuesta -> Bool
tieneMasDe3Skills = (> 3) . length . skills

---------------
--- Punto 4 ---
---------------
type Resultado = (NombreAlumno, Proyecto, Puntos)

ranking :: [Mentor] -> [Propuesta] -> [Resultado]
ranking mentores = map (\propuesta -> (nombreAlumno propuesta, proyecto propuesta, puntajeTotal propuesta mentores))

---------------
--- Punto 5 ---
---------------
propuestasDeInteres :: Mentor -> [Propuesta] -> [Propuesta]
propuestasDeInteres mentor = filter $ esDeInteres mentor

---------------
--- Punto 6 ---
---------------
resultadoConMasVotos :: [Mentor] -> [Propuesta] -> Resultado
resultadoConMasVotos mentores = maximo . ranking mentores

maximo :: [Resultado] -> Resultado
maximo resultados = head . filter (tienePuntajeMaximo resultados) $ resultados

tienePuntajeMaximo :: [Resultado] -> Resultado -> Bool
tienePuntajeMaximo resultados resultado = puntaje resultado == maximum (map puntaje resultados)

puntaje :: Resultado -> Puntos
puntaje (_, _, puntos) = puntos

---------------
--- Punto 7 ---
---------------
nombreMentorMasInteresadoEn :: Propuesta -> [Mentor] -> NombreMentor
nombreMentorMasInteresadoEn propuesta = nombreMentor . masInteresado propuesta

masInteresado :: Propuesta -> [Mentor] -> Mentor
masInteresado propuesta mentores = head (filter (\mentor -> puntosSegun propuesta mentor == puntajeMaximo propuesta mentores) mentores)

puntajeMaximo :: Propuesta -> [Mentor] -> Puntos
puntajeMaximo propuesta = maximum . map (puntosSegun propuesta)

nombreMentor :: Mentor -> NombreMentor
nombreMentor (nombre, _, _) = nombre

---------------
--- Punto 8 ---
---------------
proyectosElegidos :: [Mentor] -> [Propuesta] -> [(NombreAlumno, NombreMentor, Proyecto)]
proyectosElegidos mentores = map (\propuesta -> (nombreAlumno propuesta, nombreMentorMasInteresadoEn propuesta mentores, proyecto propuesta)) . filter (esProyectoElegido mentores)

esProyectoElegido :: [Mentor] -> Propuesta -> Bool
esProyectoElegido mentores propuesta = (> 12) . puntajeTotal propuesta $ mentores

---------------
--- Punto 9 ---
---------------
{-
Se verían afectadas las siguientes funciones:
    aniosDeExperiencia
    skills
    nombreAlumno
    proyecto
    esDeInteres
    y todas aquellas funciones que utilicen alguna de las mencionadas.
Esta inflexibilidad podría solucionarse utilizando un Data para las Propuestas,
en lugar de utilizar una tupla, facilitando agregar campos como "tiempoRequerido"
sin tener que modificar todo el programa.
-}