class Moto {
    method velocidadMaxima() = cilindrada / 5

    method gastoCada100Km() = 5 + cilindrada / 200

    method cantidadPasajeros() {
        if (cilindrada <= 150) {
            return 1
        }
        else {
            return 2
        }
    }
}