object tomarVino {
    method serRealizadaPor(unFilosofo) {
        unFilosofo.disminuirNivelIluminacion(10)
        unFilosofo.agregarHonorifico("el borracho")
    }
}

class JuntarseEnElAgora {
    const otroFilosofo

    method serRealizadaPor(unFilosofo) {
        unFilosofo.aumentarIluminacion(otroFilosofo.nivelIluminacion() / 10)
    }
}

object admirarElPaisaje {
    method serRealizadPor(_unFilosofo) {
        // No hace nada
    }
}

class MeditarBajoUnaCascada {
    const metros

    method serRealizadaPor(unFilosofo) {
        unFilosofo.aumentarIluminacion(10 * metros)
    }
}

class PracticarUnDeporte {
    const deporte

    method serRealizadaPor(unFilosofo) {
        unFilosofo.rejuvenecer(deporte.diasDeRejuvenecimiento())
    }
}