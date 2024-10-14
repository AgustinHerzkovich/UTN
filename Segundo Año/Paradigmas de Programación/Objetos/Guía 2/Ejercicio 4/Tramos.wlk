// Ejercicio%204/Tramos.wlk
// Ejercicio%204/Tramos.wlk
// Ejercicio%204/Tramos.wlk
// Ejercicio%204/Tramos.wlk
class Tunel {
    const property longitud
    const salida

    method pasar(bolita) {
        bolita.demorar(longitud / bolita.velocidad())
        bolita.pasar(salida)
    }

    method estaBienConfigurado() = true
}

class DesvioLisaNoLisa {
    const salida1
    const salida2

    method pasar(bolita) {
        if (bolita.lisa()) {
            bolita.pasar(salida1)
        } else {
            bolita.pasar(salida2)
        }
    }

    method estaBienConfigurado() = salida1 != null && salida2 != null
}

class DesvioPeso {
    const salida1
    const salida2
    const pesoMaximo

    method pasar(bolita) {
        if (bolita.peso() > pesoMaximo) {
            bolita.pasar(salida1)
        } else {
            bolita.pasar(salida2)
        }
    }

    method estaBienConfigurado() = salida1 != null && salida2 != null
}

class Detencion {
    const tiempoDetencion
    const salida

    method pasar(bolita) {
        bolita.demorar(tiempoDetencion)
        bolita.pasar(salida)
    }

    method estaBienConfigurado() = true
}

class Acelerador {
    const salida

    method pasar(bolita) {
        bolita.demorar(10)
        bolita.acelerar(3)
        bolita.demorar(2)
        bolita.pasar(salida)
    }

    method estaBienConfigurado() = true
}

class Circuito {
    const tramos

    method pasar(bolita) {
        tramos.forEach{tramo => bolita.pasar(tramo)}
    }
}