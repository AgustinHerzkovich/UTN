class Persona {
    var estaFueraDeCombate = false
    var resistencia
    var fuerza
    
    method poder() = fuerza * resistencia

    method recibirDanio(unaCantidad) {
        resistencia -= 0.max(resistencia - unaCantidad)
        if (resistencia == 0) {
            estaFueraDeCombate = true
        }
    }

    method estaFueraDeCombate() = estaFueraDeCombate

    method tomarPocionMagica(unaPocion) {
        unaPocion.aplicarEfecto(self)
    }

    method aumentarFuerza(unaCantidad) {
        fuerza += unaCantidad
    }

    method aumentarResistencia(unaCantidad) {
        resistencia += unaCantidad
    }

    method disminuirResistencia(unaCantidad) {
        resistencia -= unaCantidad
    }

    method disminuirResistenciaALaMitad() {
        self.disminuirResistencia(resistencia / 2)
    }

    method duplicarResistencia() {
        self.aumentarResistencia(resistencia)
    }

    method esMasPoderosoQue(otraPersona) = self.poder() > otraPersona.poder()
}