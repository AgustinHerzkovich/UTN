// Ciudadanos.wlk
class Ciudadano {
    const property esExtorsionable
    const inclinacionPropia
    var cantidadBase

    method danioRecibible() = 4

    method inclinacionAlSobornoMayorA(unValor) = self.inclinacionAlSoborno() > unValor

    method inclinacionAlSoborno() = inclinacionPropia + cantidadBase

    method modificarCantidadBase(nuevaCantidadBase) {
        cantidadBase = nuevaCantidadBase
    }
}


class Villano inherits Ciudadano {
    const coeficienteDeMaldad
    const misiones = []

    method crueldad() = self.cantidadMisionesEncargadas() * coeficienteDeMaldad

    method cantidadMisionesEncargadas() = misiones.size()

    override method danioRecibible() = 1

    override method inclinacionAlSoborno() = 4 * super()

    method objetivosOrdenados() = self.ordenarPorOcurrencias(self.objetivos())

    method objetivos() = misiones.map{mision => mision.objetivo()}

    method ordenarPorOcurrencias(unaLista) = unaLista.sortedBy{x, y => unaLista.occurrencesOf(x) >= unaLista.occurrencesOf(y)}

    method esArchienemigoDe(unHeroe) = self.esBlancoPredilecto(unHeroe.metropolisNatal())

    method esBlancoPredilecto(unObjetivo) = unObjetivo == self.objetivosOrdenados().first()

    method ciudadConMasExitos(unaCiudad) = unaCiudad == self.objetivoMasExitoso()

    method objetivoMasExitoso() = self.ordenarPorOcurrencias(self.objetivosExitosos()).first()

    method objetivosExitosos() = self.objetivos().filter{mision => mision.seraExitosa()}
}

class Heroe inherits Ciudadano (esExtorsionable = false) {
    const property metropolisNatal
    var tieneMisionAsignada = false

    override method danioRecibible() = 8

    override method inclinacionAlSoborno() = 0

    method puedeAcudirA(unaMetropolis) = ! self.estaOcupado() || unaMetropolis == metropolisNatal || unaMetropolis.tieneEnAntecedentes(self.archienemigo())

    method estaOcupado() = ! tieneMisionAsignada

    method acudirA(unaMetropolis) {
        self.validarPoderAcudirA(unaMetropolis)
        tieneMisionAsignada = true
    }

    method validarPoderAcudirA(unaMetropolis) {
        if(! self.puedeAcudirA(unaMetropolis)) {
            throw new DomainException(message = "El héroe no puede acudir a la misión")
        }
    }

    method archienemigo() = metropolisNatal.villanoPredilecto()
}