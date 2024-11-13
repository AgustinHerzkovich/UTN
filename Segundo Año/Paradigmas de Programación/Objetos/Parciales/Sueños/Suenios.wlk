class Suenio {
    var cumplido = false
    const property felicidonios

    method cumplir(persona) {
        self.validar(persona)
        self.realizar(persona)
        self.cumplir()
        persona.sumarFelicidad(felicidonios)
    }

    method cumplir() {
        cumplido = true
    }

    method validar(persona)

    method realizar(persona)

    method estaPendiente() = ! cumplido
}

class AdoptarHijo inherits Suenio {
    const hijos

    override method validar(persona) {
        if (persona.tieneHijos()) {
            throw new DomainException(message = "No puede adoptar un hijo porque ya tiene")
        }
    }

    override method realizar(persona) {
        persona.agregarHijos(hijos)
    }
}

class Viajar inherits Suenio {
    const lugar

    override method validar(persona) {
        // No valida nada, siempre se cumple
    }

    override method realizar(persona) {
        persona.viajarA(lugar)
    }
}


class RecibirseDe inherits Suenio {
    const carrera

    override method validar(persona) {
        if (persona.seRecibioDe(carrera)|| ! persona.quiereEstudiar(carrera)) {
            throw new DomainException(message = "No puede recibirse de una carrera que ya se recibió o no quiere estudiar")
        }
    }

    override method realizar(persona) {
        persona.completarCarrera(carrera)
    }
}

class ConseguirLaburo inherits Suenio {
    const sueldo

    override method validar(persona) {
        if (persona.quiereGanarMas(sueldo)) {
            throw new DomainException(message = "Este trabajo no paga lo suficiente")
        }
    }

    override method realizar(persona) {
        persona.ganarPlata(sueldo)
    }
}

class SuenioMultiple inherits Suenio {
    const suenios = []

    override method validar(persona) {
        suenios.forEach{suenio => suenio.validar(persona)}
    }

    override method realizar(persona) {
        suenios.forEach{suenio => suenio.realizar(persona)}
    }
}
