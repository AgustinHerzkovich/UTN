class Capataz{
    method vender(cultivo, cantidadKilos, comprador, fecha, parcela) {
        parcela.registrarVenta(new Date(day = fecha.dia(), month = fecha.mes(), year = fecha.anio()), cultivo, cantidadKilos, comprador, self.precioVenta(cultivo, cantidadKilos, comprador)) 
    }

    method precioVenta(cultivo, cantidadKilos, comprador) = cantidadKilos * cultivo.precioPorKg() * comprador.coeficienteDeAjuste(cantidadKilos, cultivo)
}

class Venta{
    const fecha
    const property cultivo
    const property cantidadKilos
    const property comprador
    const property precio


    method estaEntre(fecha1, fecha2) = fecha.between(fecha1, fecha2)  
}