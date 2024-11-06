object companiaFinanciera {

    method montoMaximoDePrestamo(unCliente) = unCliente.prestamoMaximo() - unCliente.sumaSaldosPendientes()

    method otorgarPrestamo(unCliente) {
        unCliente.registrarPrestamo(new Prestamo(fecha = calendar.today(), importe = self.montoMaximoDePrestamo(unCliente)))
    }

    method cobrar(unCliente, unImporte) {
        unCliente.descontarDePrestamoMasAntiguo(unImporte)
    }
}

class Prestamo {
    const property fecha
    var importe

    method importe() = importe

    method descontar(unMonto) {
        importe -= unMonto
    }

    method estaPagado() = importe == 0
}