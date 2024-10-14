class EstacionDeServicio {
    const dispositivo1
    const dispositivo2
    const dispositivo3

    method puedeAtender(animal) = dispositivo1.puedeAtender(animal) || dispositivo2.puedeAtender(animal) || dispositivo3.puedeAtender(animal)

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            self.elegirDispositivo(animal).atender(animal)
        }
        else {
            self.error("El animal no puede ser atendido")
        }
    }

    method elegirDispositivo(animal) {
        if (dispositivo1.puedeAtender(animal)) {
            return dispositivo1
        }
        else if (dispositivo2.puedeAtender(animal)) {
            return dispositivo2
        }
        else {
            return dispositivo3
        }
    }

    method recargar() {
        if (dispositivo1.necesitaRecarga()) {
            dispositivo1.recargar()
        }
        if (dispositivo2.necesitaRecarga()) {
            dispositivo2.recargar()
        }
        if (dispositivo3.necesitaRecarga()) {
            dispositivo3.recargar()
        }
    }
}