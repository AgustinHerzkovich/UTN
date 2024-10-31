class Pais {
    const localidades = []

    method poblacionTotal() = localidades.sum{localidad => localidad.poblacion()}

    method localidadesDeMenosDe500Habitantes() = localidades.filter{localidad => localidad.tieneMenosDe500Habitantes()}

    method porcentajeClaseMedia() = 100 * self.poblacionClaseMedia() / self.poblacionTotal()

    method poblacionClaseMedia() = localidades.sum{localidad => localidad.poblacionClaseMedia()}

    method indiceHacinamientoNacional() = self.cantidadViviendasHacinadas() / self.cantidadViviendasSinHacinar()

    method cantidadViviendasHacinadas() = localidades.sum{localidad => localidad.cantidadViviendasHacinadas()}
    
    method cantidadViviendasSinHacinar() = localidades.sum{localidad => localidad.cantidadViviendasSinHacinar()}

    method viviendaQueMasTardoEnCensarDe(unaLocalidad) = unaLocalidad.viviendaQueMasTardoEnCensar()
}

class Localidad {
    const formularios = []

    method poblacion() = formularios.sum{formulario => formulario.cantidadHabitantes()}

    method tieneMenosDe500Habitantes() = self.poblacion() < 500

    method poblacionClaseMedia() = formularios.filter{formulario => formulario.claseMedia()}.size()

    method cantidadFormulariosHacinados() = formularios.count{formulario => formulario.estaHacinado()}

    method cantidadFormulariosSinHacinar() = formularios.size() - self.cantidadFormulariosHacinados()

    method viviendaQueMasTardoEnCensar() = formularios.max{formulario => formulario.tiempoCensado()}.vivienda()
}