import wollok.game.*

object personaje {
    var property vida = 100
    var property energia = 50
    var property position = game.origin()

    method estaMuerto() = vida <= 0
    method estaVivo() = vida > 0

    method image() = if (self.estaVivo()) "lionel10.png" else "Tumba.png"

    method recibirDanio(cantidad) {
        if (self.estaVivo()) {
            vida = (vida - cantidad).max(0)
            if (self.estaMuerto()) {
                game.say(self, "Game over! Presione R para reiniciar")
            }
        }
    }

    method curar(cantidad) {
        if (self.estaVivo()) {
            vida = (vida + cantidad).min(100)
        }
    }

    method sumarEnergia(cantidad) {
        if (self.estaVivo()) {
            energia = (energia + cantidad).min(50)
        }
    }

    method reiniciar() {
        vida = 100
        energia = 50
        position = game.origin()
    }
}

// Visual para el ícono de corazón/vida
object iconoVida {
    method position() = game.at(0, 9) // Volvemos a la casilla superior
    method image() = "corazon.png"
}

// Visual para el texto del contador de vida (se superpone sobre el corazón)
object contadorVida {
    method position() = game.at(0, 9) // Misma posición para quedar centrado sobre el corazón
    method text() = personaje.vida().toString()
    method textColor() = "FFFFFFFF" // Texto blanco
}
object llave {
    var property position = game.at(14, 8)
    method image() = "llave.png"
}