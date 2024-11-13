class Persona {
    const property elementos = []
    var criterio = null
    var property posicion = 0
    var criterioEleccionComida = null
    const comidas = []

    method pedir(persona, cosa) {
        persona.atenderPedido(self, cosa)
    }

    method atenderPedido(persona, cosa) {
        self.validarPoderPasar(cosa)
        criterio.atenderPedido(self, persona, cosa)
    }

    method validarPoderPasar(cosa) {
        if (! elementos.contains(cosa)) {
            throw new DomainException(message = "No te puedo alcanzar esa cosa")
        }
    }

    method pasarle(persona, cosa) {
        persona.recibir(cosa)
        elementos.remove(cosa)
    }

    method recibir(cosa) {
        elementos.add(cosa)
    }

    method cambiarCriterio(nuevoCriterio) {
        criterio = nuevoCriterio
    }

    method cambiarCriterioEleccionComida(nuevoCriterio) {
        criterioEleccionComida = nuevoCriterio
    }

    method primerElementoAMano() = elementos.first()

    method cambiarPosicionCon(persona) {
        const posicionPropia = posicion
        self.posicion(persona.posicion())
        persona.posicion(posicionPropia)
    }

    method quiereComer(comida) = criterioEleccionComida.quiereComer(comida)

    method comer(comida) {
        if (self.quiereComer(comida)) {
            comidas.add(comida)
        }
    }

    method estaPipon() = comidas.any{comida => comida.calorias() > 500}

    method laEstaPasandoBien() = self.comioAlgo()

    method comioAlgo() = ! comidas.isEmpty()

    method comioCarne() = comidas.any{comida => comida.esCarne()}

    method tieneMenosDe3ElementosCerca() = elementos.size() < 3
}

object moni inherits Persona {
    override method laEstaPasandoBien() = super() and posicion == 1
}

object facu inherits Persona {
    override method laEstaPasandoBien() = super() and self.comioCarne()
}

object vero inherits Persona {
    override method laEstaPasandoBien() = super() and self.tieneMenosDe3ElementosCerca()
}