class ArreglarMaquina {
    const complejidad
    const herramientasRequeridas = []

    method puedeSerRealizadaPor(unEmpleado) = unEmpleado.tieneEstaminaSuficiente(complejidad) and unEmpleado.tieneHerramientas(herramientasRequeridas)

    method serRealizadaPor(unEmpleado) {
        unEmpleado.perderEstamina(complejidad)
    }

    method dificultad(_unEmpleado) = 2 * complejidad
}

class DefenderSector {
    const gradoAmenaza

    method puedeSerRealizadaPor(unEmpleado) = unEmpleado.puedeDefender() and unEmpleado.leAlcanzaLaFuerza(gradoAmenaza)

    method serRealizadaPor(unEmpleado) {
        unEmpleado.perderEstaminaPorDefensa(unEmpleado.estamina() / 2)
    }

    method dificultad(_unEmpleado) = _unEmpleado.dificultadDefensa(self)
}

class LimpiarSector {
    const dificultadSector = dificultadLimpieza
    const tamanio

    method puedeSerRealizadaPor(unEmpleado) = unEmpleado.puedeLimpiar(self)

    method cumpleRequerimiento(unEmpleado) = unEmpleado.tieneEstaminaSuficiente(tamanio.estaminaRequerida())

    method serRealizadaPor(unEmpleado) {
        unEmpleado.perderEstaminaPorLimpieza(tamanio.estaminaRequerida())
    }

    method dificultad(_unEmpleado) = dificultadSector.dificultad()
}

object dificultadLimpieza {
    method dificultad() = 10
}

object tamanioGrande {
    method estaminaRequerida() = 4
}

object otroTamanio {
    method estaminaRequerida() = 1
}