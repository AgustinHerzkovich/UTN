class Barco {
    var mision
    const capacidadMaxima
    const tripulacion = []

    method puedeFormarParteDeLaTripulacion(unPirata) = self.tieneEspacioDisponible() && unPirata.esUtilPara(mision)

    method tieneEspacioDisponible() = self.cantidadTripulantes() < capacidadMaxima

    method cantidadTripulantes() = tripulacion.size()

    method cambiarMision(nuevaMision) {
        mision = nuevaMision
        self.echarTripulantesInutiles(nuevaMision)
    }

    method incorporarALaTripulacion(unPirata) {
        self.verificarSiPuedeFormarParte(unPirata)
        tripulacion.add(unPirata)
    }

    method verificarSiPuedeFormarParte(unPirata) {
        if(! self.puedeFormarParteDeLaTripulacion(unPirata)) {
            throw new DomainException(message = "El pirata no puede formar parte de la tripulación de este barco")
        }
    }

    method echarTripulantesInutiles(unaMision) {
        tripulacion.removeAllSuchThat{tripulante => ! tripulante.esUtilPara(unaMision)}
    }

    method pirataMasEbrio() = tripulacion.max{tripulante => tripulante.nivelEbriedad()}

    method anclarEn(ciudadCostera) {
        self.todosTomanTragoDeGrogXD()
        self.perderTripulanteEn(self.pirataMasEbrio(), ciudadCostera)
    }

    method todosTomanTragoDeGrogXD() {
        tripulacion.forEach{tripulante => tripulante.tomarTragoDeGrogXD()}
    }

    method perderTripulanteEn(unTripulante, unaCiudad) {
        tripulacion.remove(unTripulante)
        unaCiudad.agregarHabitante(unTripulante)
    }

    method esVulnerableA(unBarco) = self.cantidadTripulantes() <= unBarco.cantidadTripulantes() / 2

    method puedeSerSaqueadoPor(unPirata) = unPirata.estaPasadoDeGrogXD()

    method cantidadTripulantesMayorOIgualA(unaCantidad) = self.cantidadTripulantes() >= unaCantidad

    method tieneSuficienteTripulacion() = self.cantidadTripulantesMayorOIgualA(self.cantidadTripulantes() * 0.9)

    method estanTodosPasadosDeGrogXD() = tripulacion.all{tripulante => tripulante.estaPasadoDeGrogXD()}

    method esTemible() = mision.puedeSerSaqueadoPor(self)

    method cuantosEstanPasadosDeGrogXD() = self.tripulantesPasadosDeGrogXD().size()

    method tripulantesPasadosDeGrogXD() = tripulacion.filter{tripulante => tripulante.estaPasadoDeGrogXD()}

    method cantidadItemsDistintosDePasadosDeGrogXD() = self.cantidadItemsDistintos(self.tripulantesPasadosDeGrogXD())

    method cantidadItemsDistintos(unosTripulantes) = self.cantidadSinRepetir(unosTripulantes.map{tripulante => tripulante.items()})

    method cantidadSinRepetir(items) = items.unique().size()

    method tripulantePasadoDeGrogXDMasAdinerado() = self.masAdinerado(self.tripulantesPasadosDeGrogXD())

    method masAdinerado(unosTripulantes) = unosTripulantes.max{tripulante => tripulante.dinero()}

    method mejorAnfitrion() = tripulacion.max{tripulante => self.cantidadInvitaciones(tripulante)}

    method cantidadInvitaciones(unInvitante) = self.invitaciones().occurrencesOf(unInvitante)

    method invitaciones() = tripulacion.map{tripulante => tripulante.invitante()}
}