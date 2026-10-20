import movimientos.*
import personaje.*
import wollok.game.*

class Enemigo {

    var property position
    method teAtaca(alguien) {
        alguien.recibirDanio(self.danio())
        game.say(alguien, self.mensajeAtaque())
    }
    method agarrarLaLlave() { }
    method danio()
    method mensajeAtaque()
}

class Fantasma inherits Enemigo {
    var direccion = haciaArriba
    method image() = "ghost.png"

    method movete() {
        movimiento.mover(self, direccion)

        if (position.y() == 6) direccion = haciaAbajo
        if (position.y() == 0) direccion = haciaArriba
    }
    override method danio() = 35
    override method mensajeAtaque() = "¡Me descontaron 35 de vida!"
}

// Instancias predefinidas para fantasmas
const fantasma1 = new Fantasma(position = game.at(3, 1))
const fantasma2 = new Fantasma(position = game.at(10, 1))

class Serpiente inherits Enemigo {
    method image() = "snakee.png"

    method movete() {
        movimientoRandom.mover(self)
    }
    override method danio() = 25
    override method mensajeAtaque() = "¡Una serpiente me atacó (-25 vida)!"
}

// Instancias predefinidas para serpientes
const serpiente1 = new Serpiente(position = game.at(13, 8))
const serpiente2 = new Serpiente(position = game.at(1, 8))

class Escorpion inherits Enemigo {
    var direccion = haciaLaIzquierda
    method image() = "scorpion.png"

    method movete() {
        movimiento.mover(self, direccion)

        if (position.x() == 0) direccion = haciaLaDerecha
        if (position.x() == 14) direccion = haciaLaIzquierda
    }
    override method danio() = 50
    override method mensajeAtaque() = "¡El escorpión me picó (-50 vida)!"
}

// Instancias predefinidas para escorpiones
const escorpion1 = new Escorpion(position = game.at(10, 3))
const escorpion2 = new Escorpion(position = game.at(2, 7))