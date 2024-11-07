import Actividades.*

class Filosofo {
    const nombre
    var edad
    const honorificos = #{}
    var nivelIluminacion
    const actividades = []
    var diasEnvejecimiento = 0
    
    method presentate() = "Hola soy " + nombre + ", mis honoríficos son: " + honorificos.join(",")

    method estaEnLoCorrecto() = nivelIluminacion > 1000

    method vivirUnDia() {
        self.realizarTodasSusActividades()
        self.envejecer()
    }

    method realizarTodasSusActividades() {
        actividades.forEach{actividad => self.realizarActividad(actividad)}
    }
    
    method realizarActividad(unaActividad) {
        unaActividad.serRealizadaPor(self)
    }

    method disminuirNivelIluminacion(unaCantidad) {
        nivelIluminacion -= unaCantidad
    }

    method agregarHonorifico(unHonorifico) {
        honorificos.add(unHonorifico)
    }

    method aumentarIluminacion(unaCantidad) {
        nivelIluminacion += unaCantidad
    }

    method nivelIluminacion() = nivelIluminacion

    method envejecer() {
        diasEnvejecimiento += 1
        self.verificarEnvejecimiento()
    }

    method verificarEnvejecimiento() {
        if (diasEnvejecimiento == 365) {
            self.cumplirUnAnio()
            self.aumentarIluminacion(10)
            diasEnvejecimiento = 0
        }
    }

    method rejuvenecer(unosDias) {
        diasEnvejecimiento -= unosDias
    }

    method cumplirUnAnio() {
        edad += 1
        self.verificarCumplimientoDeAnio()
        
    }

    method verificarCumplimientoDeAnio() {
        if (edad == 60) {
            self.agregarHonorifico("el sabio")
        }
    }

    method amaAdmirarElPaisaje() = actividades.contains(admirarElPaisaje)
}

class FilosofoContemporaneo inherits Filosofo {
    override method presentate() = "Hola"

    override method nivelIluminacion() = if (self.amaAdmirarElPaisaje()) nivelIluminacion * 5 else super()
}