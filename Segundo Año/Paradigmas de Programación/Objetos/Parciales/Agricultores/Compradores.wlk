object compradorNacional {
    method coeficienteDeAjuste(cantidadAComprar, _cultivo) = if (cantidadAComprar > 500) 0.1 else 1
}

class CompradorExtranjero {
    const coeficienteDeAjuste

    method coeficienteDeAjuste(_cantidadAComprar, _cultivo) = coeficienteDeAjuste
}

class CompradorEspecial {
    const cultivoEspecial

    method coeficienteDeAjuste(_cantidadAComprar, cultivo) = if (cultivo != cultivoEspecial) 0.05 else 1
}