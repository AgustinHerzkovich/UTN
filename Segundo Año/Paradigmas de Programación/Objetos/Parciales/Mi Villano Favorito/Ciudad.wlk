class Ciudad {
    var temperatura
    const items = []

    method disminuirTemperatura(unaCantidad) {
        temperatura -= unaCantidad
    }

    method perderItem(unItem) {
        items.remove(unItem)
    }
}