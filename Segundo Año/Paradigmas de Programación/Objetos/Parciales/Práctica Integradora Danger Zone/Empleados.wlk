class Empleado {
    var salud
    const habilidades = []
    var puesto

    method estaIncapacitado() = salud < puesto.saludCritica()

    method puedeUsar(unaHabilidad) = ! self.estaIncapacitado() and self.posee(unaHabilidad)

    method posee(unaHabilidad) = habilidades.contains(unaHabilidad)

    method realizar(unaMision) {
        unaMision.validarCumplimientoDeRequerimientos(self)
        self.recibirDanio(unaMision.peligrosidad())
    }

    method recibirDanio(unDanio) {
        salud = salud - unDanio
    }

    method estaVivo() = salud > 0

    method registrarMision(unaMision) {
        puesto.registrarMision(unaMision, self)
    }

    method aprenderHabilidadesQueNoPosee(unaMision) {
        const habilidadesNoPoseidas = unaMision.habilidadesQueNoPosee(self)
        habilidadesNoPoseidas.forEach{habilidad => self.aprenderHabilidad(habilidad)}
    }

    method aprenderHabilidad(unaHabilidad) {
        habilidades.add(unaHabilidad)
    }

    method cambiarPuesto(unPuesto) {
        puesto = unPuesto
    }
}

class Jefe inherits Empleado {
    const subordinados = []

    override method posee(unaHabilidad) = self.algunSubordinadoPuedeUsar(unaHabilidad)

    method algunSubordinadoPuedeUsar(unaHabilidad) = subordinados.any{subordinado => subordinado.puedeUsar(unaHabilidad)}
}

class Equipo {
    const empleados = []

    method realizar(unaMision) {
        unaMision.validarEquipo(empleados)
        self.sufrirDanio(unaMision)
        self.registrarMision(unaMision)
    }

    method sufrirDanio(unaMision) {
        empleados.forEach{empleado => empleado.recibirDanio(unaMision.peligrosidad() / 3)}
    }

    method registrarMision(unaMision) {
        empleados.filter{empleado => empleado.estaVivo()}.forEach{empleado => empleado.registrarMision(unaMision)}
    }
}