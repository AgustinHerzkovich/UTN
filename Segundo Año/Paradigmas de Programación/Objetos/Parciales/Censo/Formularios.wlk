import Personas.*
import Viviendas.*

class Formulario {
    const property vivienda
    const censista

    method estiloConstruccion() = vivienda.estiloConstruccion()

    method cantidadHabitantes() = vivienda.cantidadHabitantes()

    method claseMedia() = self.estiloConstruccion() == material

    method estaHacinado() = vivienda.estaHacinada()

    method tiempoCensado() = vivienda.tiempoCensado(censista)
}

class FormularioViviendaSimple inherits Formulario {
    const formulariosPorPersona
    
    method cantidadAmbientes() = vivienda.cantidadAmbientes()

    method tieneArtefacto(unArtefacto) = vivienda.tieneArtefacto(unArtefacto)

    method edades() = formulariosPorPersona.map{formulario => formulario.edad()}

    method nivelesDeEstudios() = formulariosPorPersona.map{formulario => formulario.nivelDeEstudios()}

    method algunMayorDeEdadResponsable() = formulariosPorPersona.any{formulario => formulario.mayorDeEdadResponsable()}

    override method claseMedia() = super() && self.tieneArtefacto(computadora) && self.algunMayorDeEdadResponsable()

    override method tiempoCensado() = super() + formulariosPorPersona.sum{formulario => censista.tiempoFormularioReducido(formulario) + censista.tiempoFormularioExtendido(formulario)}
}

class FormularioViviendaColectiva inherits Formulario {
    method superficie() = vivienda.superficie()

    method tipoVivienda() = vivienda.tipo()

    override method claseMedia()= super() && self.superficie() > 100 && (self.tipoVivienda() == geriatrico || self.tipoVivienda() == hotel)
}

// Formularios por persona
class FormularioReducido {
    const persona

    method edad() = persona.edad()

    method nivelDeEstudios() = persona.nivelDeEstudios()

    method mayorDeEdadResponsable() = self.edad() >= 18 && self.nivelDeEstudios() == universitario
}

class FormularioExtendido inherits FormularioReducido {
    method trabaja() = persona.trabaja()

    method esDescendenteDe(unPueblo) = persona.esDescendenteDe(unPueblo)

    override method mayorDeEdadResponsable() = super() && self.trabaja()
}
