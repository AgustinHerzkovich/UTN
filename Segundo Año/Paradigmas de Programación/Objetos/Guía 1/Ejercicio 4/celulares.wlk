object juliana {
    var celular = samsungS21
    var servicioTelefonico = personal
    var gasto = 0

    method llamarA(persona, duracionLlamada) {
        persona.atender(self, duracionLlamada)
        celular.llamar(duracionLlamada)
        gasto += servicioTelefonico.costo(duracionLlamada)
    }

    method atender(persona, duracionLlamada) {
        celular.llamar(duracionLlamada)
        gasto += servicioTelefonico.costo(duracionLlamada)
    }

    method tieneElCelularApagado() {
        return self.celular().estaApagado()
    }

    method celular() {
        return celular
    }

    method gasto() {
        return gasto
    }
}

object catalina {
    var celular = iphone
    var servicioTelefonico = movistar
    var gasto = 0
    
    method llamarA(persona, duracionLlamada) {
        persona.atender(self, duracionLlamada)
        celular.llamar(duracionLlamada)
        gasto += servicioTelefonico.costo(duracionLlamada)
    }

    method atender(persona, duracionLlamada) {
        celular.llamar(duracionLlamada)
        gasto += servicioTelefonico.costo(duracionLlamada)
    }

    method tieneElCelularApagado() {
        return self.celular().estaApagado()
    }

    method celular() {
        return celular
    }

    method gasto() {
        return gasto
    }
}

object iphone {
    var bateria = 5

    method llamar(_duracionLlamada) {
        bateria = math.max(bateria - 0.25, 0) // iPhone consume más batería por llamada
    }

    method bateria() {
        return bateria
    }

    method estaApagado() {
        return bateria == 0
    }
}

object samsungS21 {
    var bateria = 5

    method llamar(duracionLlamada) {
        bateria = math.max(bateria - 0.001 * duracionLlamada, 0) // Samsung consume menos batería por llamada
    }

    method bateria() {
        return bateria
    }

    method estaApagado() {
        return bateria == 0
    }
}

object movistar {
    method costo(duracionLlamada) {
        return 60 * duracionLlamada
    }
}

object claro {
    method costo(duracionLlamada) {
        return 50 * duracionLlamada * 1.21
    }
}

object personal {
    method costo(duracionLlamada) {
        if(duracionLlamada <= 10) {
            return 70 * duracionLlamada
        }
        else {
            return 70 * 10 + 40 * (duracionLlamada - 10)
        }
    }
}

object math {
    method max(a, b) {
        if(a > b) {
            return a
        }
        else {
            return b
        }
    }
}