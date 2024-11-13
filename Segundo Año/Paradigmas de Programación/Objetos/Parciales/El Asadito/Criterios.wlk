object sordo {
    method atenderPedido(emisor, receptor, cosa) {
        emisor.pasarle(receptor, emisor.primerElementoAMano())
    }
}

object pasarTodo {
    method atenderPedido(emisor, receptor, cosa) {
        emisor.elementos().forEach{elemento => emisor.pasarle(receptor, elemento)}
    }
}

object cambiarPosicion {
    method atenderPedido(emisor, receptor, cosa) {
        emisor.cambiarPosicionCon(receptor)
    }
}

object pasarCosa {
    method atenderPedido(emisor, receptor, cosa) {
        emisor.pasarle(receptor, cosa)
    }
}

object vegetariano {
    method quiereComer(comida) = ! comida.esCarne()
}

object dietetico {
    method quiereComer(comida) = comida.calorias() < oms.caloriasRecomendadas()
}

object alternado {
    var alternacion = false
    method quiereComer(comida) {
        alternacion = !alternacion
        return alternacion
    }
}

object combinacionCondiciones {
    const condiciones = []
    method quiereComer(comida) = condiciones.all{condicion => condicion.cumple(comida)}
}

object oms {
    var property caloriasRecomendadas = 500
}