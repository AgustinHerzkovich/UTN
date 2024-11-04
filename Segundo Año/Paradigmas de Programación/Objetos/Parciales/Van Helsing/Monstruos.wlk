class Monstruo {
    const vitalidad
    const zonasAtacadas = []

    method peligrosidad() = vitalidad * self.velocidad()

    method velocidad()

    method esRapido() = self.velocidad() > 100

    method esPatetico() = zonasAtacadas.any{zona => zona.fueDestruidaAntesDe(self)}

    method tieneMasPeligrosidadQue(unValor) = self.peligrosidad() > unValor

    method esMasMaloQueKraken()
}

class HombreLobo inherits Monstruo {
    override method velocidad() = 30 + 2 * vitalidad

    override method esMasMaloQueKraken() = vitalidad > 50
}

class Vampiro inherits Monstruo {
    var velocidad = 100

    override method velocidad() = velocidad

    method modificarVelocidad(nuevaVelocidad) {
        velocidad = nuevaVelocidad
    }

    override method esMasMaloQueKraken() = false
}

class Dragon inherits Monstruo {
    const velocidad
    const esMasMaloQueKraken

    override method esMasMaloQueKraken() = esMasMaloQueKraken

    override method velocidad() = velocidad
}

object sapoPepe inherits Monstruo(vitalidad = 999999999){ // No sé cómo poner infinito
    override method velocidad() = 150000

    override method peligrosidad() = 2000000

    override method esMasMaloQueKraken() = true

    override method esPatetico() = true
}