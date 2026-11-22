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

        // Evalúa si llegó al tope superior o inferior del mapa de forma dinámica
        if (tablero.esLimiteSuperior(position) or tablero.esLimiteInferior(position)) {
            direccion = direccion.opuesta()
        }
    }

    override method danio() = 35
    override method mensajeAtaque() = "¡Me descontaron 35 de vida!"
}

class Serpiente inherits Enemigo {
    method image() = "snakee.png"

    method movete() {
        movimientoRandom.mover(self)
    }

    override method danio() = 25
    override method mensajeAtaque() = "¡Una serpiente me atacó (-25 vida)!"
}

class Escorpion inherits Enemigo {
    var direccion = haciaLaIzquierda

    method image() = "scorpion.png"

    method movete() {
        movimiento.mover(self, direccion)

        // Evalúa si llegó al borde izquierdo o derecho del mapa de forma dinámica
        if (tablero.esLimiteIzquierdo(position) or tablero.esLimiteDerecho(position)) {
            direccion = direccion.opuesta()
        }
    }

    override method danio() = 50
    override method mensajeAtaque() = "¡El escorpión me picó (-50 vida)!"
}