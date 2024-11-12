object asentamiento {
    method desencadenar(persona) {
        persona.asentarTodosLosRecuerdosDelDia()
    }
}

class AsentamientoSelectivo {
    const palabraClave

    method desencadenar(persona) {
        persona.asentarRecuerdosClaves(palabraClave)
    }
}

object profundizacion {
    method desencadenar(persona) {
        persona.enviarAMemoriaLargoPlazoRecuerdosNoCentrales()
    }
}

object controlHormonal {
    method desencadenar(persona) {
        if (persona.algunPensamientoCentralEnLargoPlazo() || persona.todosLosRecuerdosConMismaEmocion()) {
            persona.producirDesequilibrioHormonal()
        }
    }
}

object restauracionCognitiva {
    method desencadenar(persona) {
        persona.restaurarFelicidad(100)
    }
}

object liberacionRecuerdosDelDia {
    method desencadenar(persona) {
        persona.liberarRecuerdosDelDia()
    }
}