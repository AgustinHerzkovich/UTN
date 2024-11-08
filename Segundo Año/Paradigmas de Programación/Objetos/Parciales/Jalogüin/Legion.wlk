class Legion {
    var ninios = #{}

    method create(unosNinios) {
        if (unosNinios.size() < 2) {
            throw new DomainException(message = "No se puede crear la legión con menos de 2 niños")
        }
        else {
            ninios = unosNinios
        }
    }

    method capacidadDeAsustar() = ninios.sum{ninio => ninio.capacidadDeAsustar()}

    method cantidadCaramelos() = ninios.sum{ninio => ninio.cantidadCaramelos()}

    method intentarAsustar(unAdulto) {
        if (unAdulto.esAsustadoPor(self)) {
            unAdulto.serAsustadoPor(self)
        }
    }

    method recibirCaramelosDe(unAdulto) {
        self.lider().recibirCaramelosDe(unAdulto)
    }

    method lider() = ninios.max{ninio => ninio.capacidadDeAsustar()}
}

// B.3: No hace falta implementar ningún cambio porque los mensajes que entienden las legiones, también los entienden los ninios, entonces se tratan polimórficamente