object agricultor {
    const parcelas = []
    const cultivos = []

    method comprarParcela(unaParcela) {
        parcelas.add(unaParcela)
    }

    method sembrar(unaParcela) {
        unaParcela.aumentarCultivoEnParcela()
        cultivos.add(unaParcela.cultivo())
    }

    method cosechar(unaParcela, unosKilos) {
        unaParcela.disminuirCultivoEnParcela()
        unaParcela.subirCultivoEnSilo(unosKilos)
    }

    method vender(unaParcela, unosKilos) {
        unaParcela.bajarCultivoEnSilo(unosKilos)
    }

    method cambiarCultivo(unaParcela, nuevoCultivo) {
        unaParcela.cambiarCultivo(nuevoCultivo)
    }

    method cultivos() = cultivos.withoutDuplicates()

    method parcelaQueMasFacturoEn(fecha1, fecha2) = parcelas.max{parcela => parcela.facturacionEnRango(fecha1, fecha2)}

    method tieneAlgunaParcelaSubutilizada() = parcelas.any{parcela => parcela.estaSubutilizada()}
}