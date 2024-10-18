// Ejercicio%202/Comederos.wlk
// Ejercicio%202/Comederos.wlk
// Ejercicio%202/Comederos.wlk
class ComederoNormal {
    const cantidadComida
    const limitePeso
    var raciones

    method puedeAtender(animal) = animal.tieneHambre() && animal.peso() < limitePeso

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            animal.comer(cantidadComida)
            raciones -= 1
        }
        else {
            throw new Exception(message = "El animal no puede ser atendido")
        }
    }

    method necesitaRecarga() = raciones < 10

    method recargar() {
        raciones += 30
    }
}

class ComederoInteligente {
    const capacidadMaximaComida
    var comidaDisponible
    
    method puedeAtender(animal) = animal.tieneHambre()

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            const comida = animal.peso() / 100
            animal.comer(comida)
            comidaDisponible -= comida
        }
        else {
            throw new Exception(message = "El animal no puede ser atendido")
        }
    }

    method necesitaRecarga() = comidaDisponible < 15000

    method recargar() {
        comidaDisponible = capacidadMaximaComida
    }
}

class Bebedero {
    var animalesAtendidos = 0
    
    method puedeAtender(animal) = animal.tieneSed()

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            animal.beber()
            animalesAtendidos += 1
        }
        else {
            throw new Exception(message = "El animal no puede ser atendido")
        }
    }

    method necesitaRecarga() = animalesAtendidos > 20

    method recargar() {
        animalesAtendidos = 0
    }
}

class Vacunatorio {
    var vacunas
    
    method puedeAtender(animal) = animal.convieneVacunar()

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            animal.vacunar()
            vacunas -= 1
        }
        else {
            throw new Exception(message = "El animal no puede ser atendido")
        }
    }

    method necesitaRecarga() = vacunas <= 0

    method recargar() {
        vacunas += 50
    }
}