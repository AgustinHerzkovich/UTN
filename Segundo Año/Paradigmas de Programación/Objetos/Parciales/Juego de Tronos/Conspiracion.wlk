class Conspiracion {
    const objetivo
    const complotados = []
    var ejecutada = false

    method validarConspiracion() {
        if (! objetivo.esPeligroso()) {
            throw new DomainException(message = "La conspiració no es válida")
        }
    }

    method cuantosTraidoresHay() = complotados.count{complotado => self.esTraidor(complotado)}

    method esTraidor(unComplotado) = objetivo.esAliadoDe(unComplotado)

    method ejecutar() {
        self.validarConspiracion()
        complotados.forEach{complotado => complotado.ejecutarAccionConspirativa(objetivo)}
        ejecutada = true
    }

    method fueCumplido() = ejecutada and ! objetivo.esPeligroso()
}