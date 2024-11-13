class Vikingo {
    var casta
    var dinero

    method puedeSubirAUnaExpedicion() = self.esProductivo() and casta.permiteSubir(self)

    method esProductivo()

    method escalarSocialmente() {
        casta.ascender(self)
    }
    
    method cambiarCasta(nuevaCasta) {
        casta = nuevaCasta
    }

    method ganarBotin(botin) {
        dinero += botin
    }
}

class Soldado inherits Vikingo {
    var kills
    var armas
    
    override method esProductivo() = self.cobroMasDe20Vidas() and self.tieneArmas()

    method tieneArmas() = armas > 0

    method cobroMasDe20Vidas() = kills > 20

    method bonificarAscenso() {
        armas += 10
    }

    method cobrarVida() {
        kills += 1
    }

    method ganarArmas(cantidad) {
        armas += cantidad
    }
}

class Granjero inherits Vikingo {
    var hijos
    var hectareas

    override method esProductivo() = hectareas * 2 >= hijos

    method tieneArmas() = false

    method cobrarVida() {
        // No hace nada
    }

    method bonificarAscenso() {
        hectareas += 2
        hijos += 2
    }
}