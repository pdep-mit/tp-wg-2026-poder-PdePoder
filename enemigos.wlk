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
const fantasma1 = new Fantasma()

class Serpiente {
    var property position = game.center()
    method image() = "snakee.png"

    method movete() {
        movimientoRandom.mover(self)
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(25)
        game.say(alguien, "¡Una serpiente me atacó (-25 vida)!")
    }
}

const serpiente1 = new Serpiente()

class Escorpion {
    var property position = game.at(10, 4)
    method image() = "scorpion.png"

    method movete() {
        // Ejemplo de movimiento para el escorpión
        movimiento.mover(self, haciaLaIzquierda)
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(50)
        game.say(alguien, "¡El escorpión me picó (-50 vida)!")
    }
}

const escorpion1 = new Escorpion()