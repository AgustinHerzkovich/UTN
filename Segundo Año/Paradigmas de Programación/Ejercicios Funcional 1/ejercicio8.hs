fahrToCelsius :: Fractional a => a -> a
fahrToCelsius temperatura = (temperatura - 32) * 5/9

haceFrioF :: (Ord a, Fractional a) => a -> Bool
haceFrioF temperatura = fahrToCelsius temperatura < 8

{-
Definir la función haceFrioF/1, indica si una temperatura expresada en grados Fahrenheit es fría. 
Decimos que hace frío si la temperatura es menor a 8 grados Celsius. 
-}