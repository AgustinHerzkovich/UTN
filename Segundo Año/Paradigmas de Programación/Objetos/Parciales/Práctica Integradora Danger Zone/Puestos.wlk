object espia {
    method saludCritica() = 15

    method registrarMision(unaMision, unEmpleado) {
        unEmpleado.aprenderHabilidadesQueNoPosee(unaMision)
    }
}

class Oficinista {
    var cantidadEstrellas

    method saludCritica() = 40 - 5 * cantidadEstrellas

    method registrarMision(_unaMision, unEmpleado) {
        self.agregarEstrella()
        if(cantidadEstrellas >= 3) {
            unEmpleado.cambiarPuesto(espia)
        }
    }

    method agregarEstrella() {
        cantidadEstrellas +=  1
    }
}