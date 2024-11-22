class Emision {
    const tematicas = []
    const panelistas = #{}
    var fueEmitido = false

    method puedeEmitirse() = self.cumpleCantidadPanelistas() and self.cumpleCantidadTematicasInteresantes()

    method cumpleCantidadPanelistas() = self.cantidadDe(panelistas) >= 2

    method cumpleCantidadTematicasInteresantes() = self.cantidadDe(self.tematicasInteresantes()) >= self.cantidadDe(tematicas) / 2

    method cantidadDe(unaColeccion) = unaColeccion.size()

    method tematicasInteresantes() = tematicas.filter{tematica => tematica.esInteresante()}

    method emitirse() {
        // Podría ponerse una validación que valide si puedeEmitirse antes de emitir, pero el enunciado no lo pide.
        tematicas.forEach{tematica => self.ponerAlAire(tematica)}
        fueEmitido = true
    }

    method ponerAlAire(unaTematica) {
        panelistas.forEach{panelista => panelista.salirAlAire(unaTematica)}
    }

    method panelistaEstrella() {
        self.validarHaberSidoEmitido()
        return panelistas.max{panelista => panelista.puntosEstrella()}
    }

    method validarHaberSidoEmitido() {
        if (not fueEmitido) {
            throw new DomainException(message = "El programa aún no terminó de emitirse")
        }
    }
}