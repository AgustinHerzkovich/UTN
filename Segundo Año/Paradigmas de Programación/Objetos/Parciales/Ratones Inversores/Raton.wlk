class Raton {
    const inversionesPendientes = []
    const inversionesRealizadas = []
    var capital

    method costoInversionesPendientes() = inversionesPendientes.sum{inversion => inversion.costo()}

    method realizarInversion(unaInversion) {
        self.validarPoderRealizarInversion(unaInversion)
        inversionesPendientes.remove(unaInversion)
        inversionesRealizadas.add(unaInversion)
        capital -= unaInversion.costo()
    }

    method validarPoderRealizarInversion(unaInversion) {
        if (! self.puedeRealizar(unaInversion)) {
            throw new DomainException(message = "No se puede realizar la inversion")
        }
    }

    method puedeRealizar(unaInversion) = capital >= unaInversion.costo()

    method realizarInversionesPendientes() {
        inversionesPendientes.forEach{inversion => self.realizarInversion(inversion)}
    }

    method esMasRatonQue(otroRaton) = self.costoInversionesRealizadas() < otroRaton.costoInversionesRealizadas()

    method costoInversionesRealizadas() = inversionesRealizadas.sum{inversion => inversion.costo()}

    method esAmbicioso() = self.costoInversionesPendientes() > 2 * capital

    method dilapidarCapital() {
        inversionesPendientes.forEach{inversion => if (self.puedeRealizar(inversion)) {self.realizarInversion(inversion)}}
    }

    method personajePeorPago() = self.personajesPagos().min{personaje => personaje.sueldo()}

    method personajesPagos() = inversionesRealizadas.flatMap{inversion => inversion.personajesInvolucrados()}
}