class Capataz{
    const parcela

    method vender(cultivo, cantidadKilos, comprador, fecha) {
        parcela.registrarVenta(new Date(day = fecha.dia(), month = fecha.mes(), year = fecha.anio()), cultivo, cantidadKilos, comprador) 
        parcela.bajarCultivoEnSilo(cantidadKilos)
    }

    method precioVenta(cultivo, cantidadKilos, comprador) = cantidadKilos * cultivo.precioPorKg() * comprador.coeficienteDeAjuste(cantidadKilos, cultivo)
}

class Venta{
    const property fecha
    const property cultivo
    const property cantidadKilos
    const property comprador    
}