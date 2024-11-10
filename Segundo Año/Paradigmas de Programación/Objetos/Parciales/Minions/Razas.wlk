class Biclope {
    method dificultadDefensa(unaDefensa) = unaDefensa.gradoAmenaza()

    method recuperarEstamina(unEmpleado, unaCantidad) {
        unEmpleado.ganarEstamina(unaCantidad.min(unaCantidad + unEmpleado.estamina()))
    }
}

class Ciclope inherits Biclope{
    override method dificultadDefensa(unaDefensa) = super(unaDefensa) * 2

    override method recuperarEstamina(unEmpleado, unaCantidad) {
        unEmpleado.ganarEstamina(unaCantidad)
    }

    method fuerza(unaFuerzaDefault) = unaFuerzaDefault / 2
}