object tortuga {
    method poder(_unaLegion) = 0

    method cantidadIntegrantesAdelante(_unaLegion) = 0
}

class EnCuadro {
    const cantidadIntegrantesAdelante

    method poder(unaLegion) = unaLegion.poder()

    method cantidadIntegrantesAdelante(_unaLegion) = cantidadIntegrantesAdelante
}

object frontemAllargate {
    method poder(unaLegion) = unaLegion.poder() * 1.1
    
    method cantidadIntegrantesAdelante(unaLegion) = unaLegion.cantidadIntegrantes() / 2
}