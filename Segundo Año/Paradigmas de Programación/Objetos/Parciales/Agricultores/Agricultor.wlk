object agricultor {
    var parcela = null

    method comprarParcela(unaParcela) {
        parcela = unaParcela
    }

    method sembrar() {
        parcela.aumentarCultivoEnParcela()
    }

    method cosechar(unosKilos) {
        parcela.disminuirCultivoEnParcela()
        parcela.subirCultivoEnSilo(unosKilos)
    }

    method vender(unosKilos) {
        parcela.bajarCultivoEnSilo(unosKilos)
    }

    method cambiarCultivo(nuevoCultivo) {
        parcela.cambiarCultivo(nuevoCultivo)
    }

}