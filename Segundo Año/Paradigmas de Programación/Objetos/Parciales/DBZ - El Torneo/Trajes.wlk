class Traje {
    var nivelDesgaste = 0

    method defender(guerrero, potencial) {
        if (self.estaGastado()) {
            throw new DomainException(message = "No puedo proteger al guerrero, estoy gastado jefe")
        }
        else {
            nivelDesgaste += 5
        }
    }

    method estaGastado() = nivelDesgaste == 100

    method cantidadElementos() = 1
}


class Comun inherits Traje {
    const porcentaje

    override method defender(guerrero, potencial) {
        super(guerrero, potencial)
        guerrero.sufrirDanio(potencial * porcentaje / 100)
    }
}

object entrenamiento inherits Traje {
    var porcentaje = 100

    method cambiarPorcentaje(nuevoPorcentaje) {
        porcentaje = nuevoPorcentaje
    }

    override method defender(guerrero, potencial) {
        super(guerrero, potencial)
        guerrero.sufrirDanio(potencial)
        guerrero.aumentarExperiencia(porcentaje)
    }
}

class Modularizado inherits Traje{
    const piezas = []

    override method defender(guerrero, potencial) {
        super(guerrero, potencial)
        guerrero.sufrirDanio(potencial * (1 - self.resistenciaPiezasNoGastadas() / 100))
        guerrero.aumentarExperiencia(self.porcentajePiezasNoGastadas())
    }

    method resistenciaPiezasNoGastadas() = self.piezasNoGastadas().sum{pieza => pieza.porcentajeResistencia()}

    method piezasNoGastadas() = piezas.filter{pieza => ! pieza.estaGastada()}

    override method estaGastado() = piezas.all{pieza => pieza.estaGastada()}

    method porcentajePiezasNoGastadas() = 100 * self.cantidadPiezasNoGastadas() / self.cantidadPiezas()

    method cantidadPiezasNoGastadas() = self.piezasNoGastadas().size()

    method cantidadPiezas() = piezas.size()

    override method cantidadElementos() = self.cantidadPiezas()
}

class Pieza {
    const property porcentajeResistencia
    const desgaste

    method estaGastada() = desgaste >= 20
}