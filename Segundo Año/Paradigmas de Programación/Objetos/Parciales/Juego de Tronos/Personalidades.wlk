import Casa.*

object sutil {
    method conspirarContra(unObjetivo) {
        unObjetivo.casarseCon(casaMasPobre.algunIntegranteVivoYSoltero())
    }
}

class Asesino {
    method conspirarContra(unObjetivo) {
        unObjetivo.morirse()
    }
}

object asesinoPrecavido inherits Asesino{
    override method conspirarContra(unObjetivo) {
        if (unObjetivo.estaSolo()) {
            super(unObjetivo)
        }
    }
}

class Disipado {
    const porcentaje

    method conspirarContra(unObjetivo) {
        unObjetivo.derrochar(porcentaje)
    }
}

object miedoso {
    method conspirarContra(_unObjetivo) {
        // No hace nada
    }
}