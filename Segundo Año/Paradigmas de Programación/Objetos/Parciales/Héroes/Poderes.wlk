class SuperFuerza {
    var potencia

    method potencia(_unHeroe) = potencia

    method aumentarHabilidades(_vencido) {
        potencia += 1
    }

    method esDignoDeConfianza(_unHeroe) = potencia <= 100
}

object sabiduria {
    method potencia(unHeroe) = 3 * unHeroe.cantidadPeleas() 

    method aumentarHabilidades(_vencido) {
        // No hace nada
    }

    method esDignoDeConfianza(unHeroe) = unHeroe.realizoMasDeNPeleas(20)
}

class PoderMistico {
    const poderes = []

    method potencia(_unHeroe) = poderes.sum{poder => poder.potencia(_unHeroe)}

    method aumentarHabilidades(vencido) {
        poderes.add(vencido.poderOtorgado())
    }

    method esDignoDeConfianza(_unHeroe) = false
}