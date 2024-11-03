class Regalo {
    const property precio
    const property destinatario
    const umbralPreciopromedio

    method regaloTeQuierenMucho() = precio > umbralPreciopromedio
}

class Tarjeta {
    const property destinatario
    const property valorAdjunto

    method precio() = 2
}

class Adorno {
    const pesoBase
    const coeficienteSuperioridad

    method importancia() = pesoBase * coeficienteSuperioridad

    method peso() = pesoBase
}

class Luz inherits Adorno {
    const cantidadLamparitas

    override method importancia() = super() * self.luminosidad()

    method luminosidad() = cantidadLamparitas
}

class FiguraElaborada inherits Adorno {
    const volumen

    override method importancia() = super() + volumen
}

class Guirnalda inherits Adorno {
    const aniodeCompra

    override method peso() = pesoBase - 100 * self.aniosEnUso()

    method aniosEnUso() = 2024 - aniodeCompra // No sé si hay alguna forma para no tener que hardcodear el año actual
}