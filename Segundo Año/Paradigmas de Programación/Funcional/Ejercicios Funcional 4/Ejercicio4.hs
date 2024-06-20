duracionLlamadas :: ((String, [Integer]), (String, [Integer]))
duracionLlamadas = (("horarioReducido", [20, 10, 25, 15]), ("horarioNormal", [10, 5, 8, 2, 9, 10]))

cuandoHabloMasMinutos :: ((String, [Integer]), (String, [Integer])) -> String
cuandoHabloMasMinutos supertupla
  | cantMinutos1 > cantMinutos2 = horario1
  | cantMinutos2 > cantMinutos1 = horario2
  | otherwise = "lo mismo en ambos"
  where
    cantMinutos1 = (sum . snd . fst) supertupla
    cantMinutos2 = (sum . snd . snd) supertupla
    horario1 = (fst . fst) supertupla
    horario2 = (fst . snd) supertupla

cuandoHizoMasLlamadas :: ((String, [Integer]), (String, [Integer])) -> String
cuandoHizoMasLlamadas supertupla
  | cantLlamadas1 > cantLlamadas2 = horario1
  | cantLlamadas2 > cantLlamadas1 = horario2
  | otherwise = "lo mismo en ambos"
  where
    cantLlamadas1 = (length . snd . fst) supertupla
    cantLlamadas2 = (length . snd . snd) supertupla
    horario1 = (fst . fst) supertupla
    horario2 = (fst . snd) supertupla

{-
Se tiene información detallada de la duración en minutos de las llamadas que se llevaron
a cabo en un período determinado, discriminadas en horario normal y horario reducido.
duracionLlamadas =
(("horarioReducido",[20,10,25,15]),(“horarioNormal”,[10,5,8,2,9,10])).
Definir la función cuandoHabloMasMinutos, devuelve en que horario se habló más cantidad de minutos, en el de tarifa normal o en el reducido.
Main> cuandoHabloMasMinutos
“horarioReducido”
Definir la función cuandoHizoMasLlamadas, devuelve en que franja horaria realizó más cantidad de llamadas, en el de tarifa normal o en el reducido.
Main> cuandoHizoMasLlamadas
“horarioNormal”
Nota: Utilizar composición en ambos casos
-}