class Cliente {
    const prestamosPendientes = []

    method sumaSaldosPendientes() = self.saldosPendientes().sum()

    method saldosPendientes() = prestamosPendientes.map{prestamo => prestamo.importe()}

    method registrarPrestamo(unPrestamo) {
        prestamosPendientes.add(unPrestamo)
    }

    method descontarDePrestamoMasAntiguo(unImporte) {
        self.prestamoMasAntiguo().descontar(unImporte)
        if(self.prestamoMasAntiguo().estaPagado()) {
            prestamosPendientes.remove(self.prestamoMasAntiguo())
        }
    }

    method prestamoMasAntiguo() = prestamosPendientes.min{prestamo => prestamo.fecha()}
}

class Empresa inherits Cliente {
    const organismoGarantia
    const property capitalSocial

    method prestamoMaximo() = organismoGarantia.montoAPrestar(capitalSocial)

    method capitalSocialMayorA(unMonto) = capitalSocial > unMonto
}

class OrganismoPublico inherits Cliente {
    const importeAcordado
    const tipo

    method prestamoMaximo() = importeAcordado * (1 - tipo.gastosAdministrativos())
}

// Tipos de Organismos Públicos
object poderEjecutivoNacional {
    method gastosAdministrativos() = 0.1
}

object justicia {
    method gastosAdministrativos() = 0.2
}

object enteAutarquico {
    method gastosAdministrativos() = 0.05
}

object gcba {
    method gastosAdministrativos() = 0.1
}