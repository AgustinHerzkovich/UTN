class Empleado {
    var estamina
    const property herramientas = []
    const tareasRealizadas = []
    const raza

    method estamina() = estamina

    method comerFruta(unaFruta) {
        unaFruta.serComidaPor(self)
    }

    method recuperarEstamina(unaCantidad) {
        raza.recuperarEstamina(self, unaCantidad)
    }

    method ganarEstamina(unaCantidad) {
        estamina += unaCantidad
    }

    method perderEstamina(unaCantidad) {
        estamina -= unaCantidad
    }

    method experiencia() = self.cantidadTareasRealizadas() * self.sumatoriaDificultadesTareas()

    method realizarTarea(unaTarea) {
        self.verificarRequerimientos(unaTarea)
        unaTarea.serRealizadaPor(self)
        tareasRealizadas.add(unaTarea)
    }

    method puedeRealizar(unaTarea) = unaTarea.puedeSerRealizadaPor(self)

    method cantidadTareasRealizadas() = tareasRealizadas.size()

    method sumatoriaDificultadesTareas() = tareasRealizadas.sum{tarea => tarea.dificultad(self)}

    method verificarRequerimientos(unaTarea) {
        if (! self.puedeRealizar(unaTarea)) {
            throw new DomainException(message = "No puedo realizar la tarea pedida")
        }
    }

    method tieneEstaminaSuficiente(unaEstamina) = estamina >= unaEstamina

    method tieneHerramientas(unasHerramientas) = unasHerramientas.all{herramienta => self.tieneHerramienta(herramienta)}

    method tieneHerramienta(unaHerramienta) = self.herramientas().contains(unaHerramienta)

    method leAlcanzaLaFuerza(unaCantidad) {
        self.fuerza() >= unaCantidad
    }

    method fuerza() = raza.fuerza(self.fuerzaDefault())

    method fuerzaDefault() = 2 + estamina / 2

    method perderEstaminaPorDefensa(unaCantidad) {
        estamina -= unaCantidad
    }

    method perderEstaminaPorLimpieza(unaCantidad) {
        estamina -= unaCantidad
    }

    method puedeLimpiar(unSector) = unSector.cumpleRequerimiento(self) 

    method dificultadDefensa(unaDefensa) = raza.dificultadDefensa(unaDefensa)

    method puedeDefender() = true
}

class Soldado inherits Empleado {
    const arma

    override method fuerzaDefault() = super() + self.danioExtraPractica()

    override method perderEstaminaPorDefensa(_unaCantidad) {
        arma.incrementarDanio(2)
    }

    method danioExtraPractica() = arma.danio()

    method cambiarRol() = arma.reiniciarPractica()
}

class Obrero inherits Empleado {
    const cinturon = []

    override method herramientas() = cinturon
}

class Mucama inherits Empleado {
    override method puedeLimpiar(_unSector) = true

    override method puedeDefender() = false

}

class Capataz inherits Empleado {
    const empleados = #{}

    override method realizarTarea(unaTarea) {
        if (self.algunEmpleadoPuedeHacer(unaTarea)) {
            self.subordinadoMasExperimentadoPara(unaTarea).realizarTarea(unaTarea)
        }
        else {
            super(unaTarea)
        }
    }

    method algunEmpleadoPuedeHacer(unaTarea) = empleados.any{empleado => empleado.puedeRealizar(unaTarea)}

    method subordinadoMasExperimentadoPara(unaTarea) = empleados.filter{empleado => empleado.puedeRealizar(unaTarea)}.max{empleado => empleado.experiencia()}
}