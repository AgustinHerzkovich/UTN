class Mision {
    const property peligrosidad
    const habilidadesRequeridas = []

    method validarCumplimientoDeRequerimientos(unEmpleado) {
        if(! self.cumpleTodosLosRequerimientos(unEmpleado)) {
            throw new DomainException(message = "No cumple con los requerimientos")
        }
    }

    method cumpleTodosLosRequerimientos(unEmpleado) = habilidadesRequeridas.all{habilidad => unEmpleado.posee(habilidad)}

    method validarEquipo(unosEmpleados) {
        if(! self.alMenosUnoCumpleLosRequerimientos(unosEmpleados)) {
            throw new DomainException(message = "No cumple con los requerimientos")
        }
    }

    method alMenosUnoCumpleLosRequerimientos(unosEmpleados) = unosEmpleados.any{empleado => self.cumpleTodosLosRequerimientos(empleado)}

    method habildadesQueNoPosee(unEmpleado) = habilidadesRequeridas.filter{habilidad => ! unEmpleado.posee(habilidad)}
}