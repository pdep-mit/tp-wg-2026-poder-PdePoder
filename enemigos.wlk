import movimientos.*
import personaje.*
import wollok.game.*

class Fantasma {
    var property position = game.at(2, 1)
    method image() = "ghost.png"
    var direccion = haciaArriba

    method movete() {
        movimiento.mover(self, direccion)

        if (position.y() == 6) direccion = haciaAbajo
        if (position.y() == 0) direccion = haciaArriba
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(35)
        game.say(alguien, "¡Me descontaron 35 de vida!")
    }
}

// Instancias predefinidas para fantasmas
const fantasma1 = new Fantasma(position = game.at(3, 1))
const fantasma2 = new Fantasma(position = game.at(10, 1))

class Serpiente {
    var property position = game.at(13, 8)
    method image() = "snakee.png"

    method movete() {
        movimientoRandom.mover(self)
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(25)
        game.say(alguien, "¡Una serpiente me atacó (-25 vida)!")
    }
}

// Instancias predefinidas para serpientes
const serpiente1 = new Serpiente(position = game.at(13, 8))
const serpiente2 = new Serpiente(position = game.at(1, 8))

class Escorpion {
    var property position = game.at(10, 4)
    method image() = "scorpion.png"
    var direccion = haciaLaIzquierda

    method movete() {
        movimiento.mover(self, direccion)

        if (position.x() == 0) direccion = haciaLaDerecha
        if (position.x() == 14) direccion = haciaLaIzquierda
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(50)
        game.say(alguien, "¡El escorpión me picó (-50 vida)!")
    }
}

// Instancias predefinidas para escorpiones
const escorpion1 = new Escorpion(position = game.at(10, 3))
const escorpion2 = new Escorpion(position = game.at(2, 7))