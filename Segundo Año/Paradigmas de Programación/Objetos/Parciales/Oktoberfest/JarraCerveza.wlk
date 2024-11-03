class JarraDeCerveza {
    const capacidad
    const marca

    method litrosAlcoholAportados () = capacidad * marca.graduacionAlcoholica()

    method esDe1Litro () = capacidad == 1   
}

// Marcas
object hofbrau {
    method graduacionAlcoholica () = 0.08
}