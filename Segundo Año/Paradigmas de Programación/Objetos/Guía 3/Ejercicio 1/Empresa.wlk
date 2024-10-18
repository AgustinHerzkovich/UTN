class Empresa {
    const vehiculos

    method vehiculosConVelocidadMayorA(velocidad) = vehiculos.filter{vehiculo => vehiculo.velocidadMaxima() > velocidad}

    method vehiculosConMenorGastoQue(gasto) = vehiculos.filter{vehiculo => vehiculo.gastoCada100Km() < gasto}

    method vehiculoDeMayorCoeficienteDeEficiencia() = vehiculos.maxBy{vehiculo => self.eficiencia(vehiculo)}

    method eficiencia(vehiculo) = vehiculo.cantidadPasajeros() * vehiculo.velocidadMaxima() / vehiculo.gastoCada100Km()

    method pasajerosACiertaVelocidad(velocidad) = self.vehiculosConVelocidadMayorA(velocidad).map{vehiculo => vehiculo.cantidadPasajeros()}.sum()
}