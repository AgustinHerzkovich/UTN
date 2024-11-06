class FondoDeGarantia {
    const importeReferencia

    method montoAPrestar(capitalSocial) = 2 * importeReferencia.min(capitalSocial)
}

class PoolDeEmpresas {
    const empresas = []

    method montoAPrestar(capitalSocial) = self.empresasConCapitalSocialMayorA(capitalSocial).sum{empresa => empresa.capitalSocial()}

    method empresasConCapitalSocialMayorA(unMonto) = empresas.filter{empresa => empresa.capitalSocialMayorA(unMonto)}
}