// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
// Ejercicio%206/muebler%C3%ADa.wlk
/*
Comportamiento y características importantes para el vendedor

Estado de disponibilidad: Un vendedor necesita saber si el artículo está disponible para la venta o está reservado.
Mensaje: estaDisponible().

Reservar: Es necesario permitir que un cliente reserve un artículo para su compra futura.
Mensaje: reservar(cliente).

Vender: El vendedor debe poder ejecutar la venta de un artículo.
Mensaje: vender(cliente, cuotas, descuento, fechaEntrega).

Características del artículo: Información básica como tipo de artículo, nombre, o cantidad en stock.
Mensaje: obtenerDescripcion(), obtenerStock().

Objeto adicional para la venta
Además de los artículos (silla, mesa, televisor), necesitamos el concepto de Venta y Cliente. Estos son esenciales para poder llevar a cabo la acción de vender o reservar un artículo, así como para personalizar la venta con cuotas, descuentos, etc.

Cliente: Representa al cliente que compra o reserva el artículo.
Venta: Es el acto de vender un artículo, incluyendo los detalles como cliente, cuotas, descuentos y fecha de entrega.

Colaboraciones
Silla, Mesa, y Televisor colaboran con un Cliente al ser vendidos o reservados.
Venta colabora con un Cliente y un Artículo para ejecutar la venta o la reserva.

*/

// Definimos un objeto para el cliente
object cliente1 {
  var nombre = "Juan Perez"
}

// Definimos una silla con su comportamiento
object silla {
  var nombre = "Silla"
  var stock = 10
  var reservadoPor = null

  method estaDisponible() {
    return self.stock > 0 && self.reservadoPor == null
  }

  method reservar(cliente) {
    if (self.estaDisponible()) {
      self.reservadoPor = cliente
      return "Artículo reservado para " + cliente.nombre
    } else {
      return "El artículo no está disponible para reservar"
    }
  }

  method vender(cliente, cuotas, descuento, fechaEntrega) {
    if (self.stock > 0 && self.reservadoPor == cliente) {
      self.stock -= 1
      self.reservadoPor = null
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else if (self.estaDisponible()) {
      self.stock -= 1
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else {
      return "El artículo no está disponible para la venta"
    }
  }

  method obtenerDescripcion() {
    return "Artículo: " + self.nombre + ", Stock: " + self.stock
  }
}

// Definimos una mesa con su comportamiento
object mesa {
  var nombre = "Mesa"
  var stock = 5
  var reservadoPor = null

  method estaDisponible() {
    return self.stock > 0 && self.reservadoPor == null
  }

  method reservar(cliente) {
    if (self.estaDisponible()) {
      self.reservadoPor = cliente
      return "Artículo reservado para " + cliente.nombre
    } else {
      return "El artículo no está disponible para reservar"
    }
  }

  method vender(cliente, cuotas, descuento, fechaEntrega) {
    if (self.stock > 0 && self.reservadoPor == cliente) {
      self.stock -= 1
      self.reservadoPor = null
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else if (self.estaDisponible()) {
      self.stock -= 1
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else {
      return "El artículo no está disponible para la venta"
    }
  }

  method obtenerDescripcion() {
    return "Artículo: " + self.nombre + ", Stock: " + self.stock
  }
}

// Definimos un televisor con su comportamiento
object televisor {
  var nombre = "Televisor"
  var stock = 2
  var reservadoPor = null

  method estaDisponible() {
    return self.stock > 0 && self.reservadoPor == null
  }

  method reservar(cliente) {
    if (self.estaDisponible()) {
      self.reservadoPor = cliente
      return "Artículo reservado para " + cliente.nombre
    } else {
      return "El artículo no está disponible para reservar"
    }
  }

  method vender(cliente, cuotas, descuento, fechaEntrega) {
    if (self.stock > 0 && self.reservadoPor == cliente) {
      self.stock -= 1
      self.reservadoPor = null
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else if (self.estaDisponible()) {
      self.stock -= 1
      return "Artículo vendido a " + cliente.nombre + " en " + cuotas + " cuotas, con " + descuento + "% de descuento, entrega: " + fechaEntrega
    } else {
      return "El artículo no está disponible para la venta"
    }
  }

  method obtenerDescripcion() {
    return "Artículo: " + self.nombre + ", Stock: " + self.stock
  }
}