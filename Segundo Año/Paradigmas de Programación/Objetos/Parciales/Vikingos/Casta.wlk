class Casta {
    method permiteSubir(_vikingo) = true
}

object jarl inherits Casta {
    override method permiteSubir(vikingo) = ! vikingo.tieneArmas()

    method ascender(vikingo) {
        vikingo.cambiarCasta(karl)
        vikingo.bonificarAscenso()
    }
}

object karl inherits Casta {
    method ascender(vikingo) {
        vikingo.cambiarCasta(thrall)
    }
}

object thrall inherits Casta {
    method ascender(vikingo) {
        // No asciende más
    }
}