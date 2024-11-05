class Compania {
    const property individuos = []

    method oponentesMasPoderososEnfrentados() = individuos.map{individuo => individuo.oponenteMasPoderosoEnfrentado()}

    method potenciaTotal() = self.individuosDeConfianza().sum{individuo => individuo.potencia()}

    method individuosDeConfianza() = individuos.filter{individuo => individuo.esDignoDeConfianza()}

    method puedeDestruirA(otraCompania) = self.alMenosUnoLeGanaA(otraCompania.individuos())

    method alMenosUnoLeGanaA(unosIndividuos) = unosIndividuos.all{individuo => self.algunoLeGanaA(individuo) and self.algunoTieneMasPeleasQue(individuo)}

    method algunoLeGanaA(unIndividuo) = individuos.any{otroIndividuo => otroIndividuo.puedeGanarleA(unIndividuo)}

    method algunoTieneMasPeleasQue(unIndividuo) = individuos.any{otroIndividuo => otroIndividuo.tieneMasPeleasQue(unIndividuo)}
}