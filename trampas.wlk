import movimientos.*
import personaje.*
import wollok.game.*

object pozo {
    var property position = game.at(7, 5)
    method image() = "trampa.png"

    method teAbsorbe(personaje) {
        personaje.position(game.origin())
    }

    method teAtaca(personaje) {
        self.teAbsorbe(personaje)
    }
}

class TrampaOso {
    var property position = game.at(4, 3)
    method image() = "trampaOso.png"

    method teAtaca(personaje) {
        personaje.recibirDanio(90)
        game.say(personaje, "¡Caí en una trampa de oso! (-90 vida)")
    }
}

// Instancias fijas de trampas para organizar los niveles
const trampaOso1 = new TrampaOso(position = game.at(6, 3))
const trampaOso2 = new TrampaOso(position = game.at(11, 6))