class Ataque {
    const property fecha
    const property monstruos = []

    method monstruoMasPeligroso() = monstruos.max{monstruo => monstruo.peligrosidad()}

    method monstruosRapidos() = monstruos.filter{monstruo => monstruo.esRapido()}

    method fueEnSerio() = self.cantidadDeMonstruosMasMalosQueKraken() > 3

    method cantidadDeMonstruosMasMalosQueKraken() = monstruos.count{monstruo => monstruo.esMasMaloQueKraken()}

    method nivelDeDevastacionMayorA(unValor) = self.nivelDeDevastacion() > unValor

    method nivelDeDevastacion() = monstruos.sum{monstruo => monstruo.peligrosidad()}

    method participo(unMonstruo) = monstruos.contains(unMonstruo)

    method ocurrioAntesDeAlguno(ataques) = ataques.any{ataque => self.ocurrioAntesDe(ataque)}

    method ocurrioAntesDe(unAtaque) = fecha < unAtaque.fecha()

    method filtrarPateticos() = monstruos.filter{monstruo => !monstruo.esPatetico()}

    method filtrarMonstruosPeligrosidadMayorA(unValor) = monstruos.filter{monstruo => monstruo.tieneMasPeligrosidadQue(unValor)}

    method noTieneMonstruos() = monstruos.isEmpty()
}