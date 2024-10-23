class Pared {
    const ancho
    const material
    method resistencia() = ancho * material.propiedad()
}

object vidrio{
    method propiedad() = 10
}

object madera{
    method propiedad() = 25
}

object piedra{
    method propiedad() = 50
}

object cerditoObrero {
    method resistencia() = 50
}

object cerditoArmado {
    const equipamiento = new Casco(resistencia = 100)

    method resistencia() = 10 * equipamiento.resistencia()
}

class Casco {
    const property resistencia
}

class Escudo{
    const property resistencia
}