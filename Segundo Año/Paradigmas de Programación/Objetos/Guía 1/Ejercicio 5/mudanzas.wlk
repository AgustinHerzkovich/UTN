// Ejercicio%205/mudanzas.wlk
// Ejercicio%205/mudanzas.wlk
// Ejercicio%205/mudanzas.wlk
// Ejercicio%205/mudanzas.wlk
/*
// a.
Métodos comunes:
peso()
dimensiones()
es_fragil()
como_mover()

Métodos de silla:
material()
es_reclinable()
es_plegable()

Métodos de televisor:
tamanio_pantalla()

Comportamiento en común:
Ambos pueden responder a mensajes relacionados con peso, dimensiones y fragilidad, que son aspectos que una empresa de mudanzas 
necesita conocer para planificar su transporte y manipulación.

Interfaz en común:
Podría haber una interfaz en común que defina los métodos cómunes
que serían útiles para cualquier objeto que la empresa de mudanzas deba transportar. 
Luego, cada objeto (silla, televisor) puede implementar estos métodos de manera diferente según sus características específicas. 
Esto permite que la empresa de mudanzas trate a los objetos de forma polimórfica, usando una interfaz común para interactuar con diferentes tipos de objetos.

// b.
Empleado: Un empleado podría cargar, descargar o manipular tanto sillas como televisores. El empleado podría enviar mensajes como cargar() o descargar() para mover los objetos.
Caja: En el caso de televisores, es probable que necesiten ser colocados en cajas especiales para protegerlos. La caja podría enviar un mensaje como empacar() o desempacar() a los televisores.
Carretilla: La carretilla podría ser utilizada para transportar tanto sillas como televisores dentro de un edificio antes de ser cargados en el camión. Podría enviar mensajes como colocar() o retirar() para mover los objetos

Mensajes entre objetos
Camión a Silla o Televisor:
obtener_peso(): El camión necesita saber cuánto pesan las sillas y los televisores para no exceder el límite de carga.
cargar(): Para agregar un objeto al camión.
descargar(): Para remover un objeto del camión.
Empleado a Silla o Televisor:
mover(): El empleado podría enviar este mensaje para transportar un objeto.
empaquetar() o desempaquetar(): Si necesita embalar un televisor para su protección.
*/