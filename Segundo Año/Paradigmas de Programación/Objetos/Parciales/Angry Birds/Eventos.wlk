// Eventos.wlk
object sesionManejoIraMatilda {
    method suceder(isla) {
        isla.pajaros().forEach{pajaro => pajaro.tranquilizarse()}
    }
}

object invasionCerditos {
    const cantidadCerditos = 100

    method suceder(isla) {
        (cantidadCerditos/100).floor().times{self.enojarPajaros(isla)}
    }

    method enojarPajaros(isla) {
        isla.pajaros().forEach{pajaro => pajaro.enojarse()}
    }
}

object fiestaSorpresa {
    method suceder(isla) {
        isla.pajarosHomenajeados().forEach{homenajeado => homenajeado.enojarse()}
    }
}

object serieEventosDesafortunados {
    const eventos = [sesionManejoIraMatilda, invasionCerditos, fiestaSorpresa]

    method suceder(isla) {
        eventos.forEach{evento => evento.suceder(isla)}
    }
}