import wollok.game.*

class PocionEnergizante {
    var property position

    method image() = "pocion_verde.png"

    method interactuar(alguien) {
        alguien.sumarEnergia(20)
        game.say(alguien, "¡+20 de Energía!")
        game.removeVisual(self) // Se remueve del mapa al usarla
    }

    // Método de resguardo si colisiona mediante teAtaca
    method teAtaca(alguien) {
        self.interactuar(alguien)
    }
}

class PocionCurativa {
    var property position

    method image() = "pocion_roja.png"

    method interactuar(alguien) {
        alguien.curar(20)
        game.say(alguien, "¡+20 de Vida!")
        game.removeVisual(self)
    }

    method teAtaca(alguien) {
        self.interactuar(alguien)
    }
}

class PocionVenenosa {
    var property position

    method image() = "pocion_morada.png"

    method interactuar(alguien) {
        alguien.recibirDanio(15)
        game.say(alguien, "¡Poción venenosa! -15 de Vida")
        game.removeVisual(self)
    }

    method teAtaca(alguien) {
        self.interactuar(alguien)
    }
}

// Objeto generador de pociones aleatorias
object generadorPociones {
    method crearPocionAleatoria() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        const pos = game.at(x, y)

        const tipo = (1..3).anyOne() // Elige un número al azar entre 1 y 3

        return if (tipo == 1) new PocionEnergizante(position = pos)
               else if (tipo == 2) new PocionCurativa(position = pos)
               else new PocionVenenosa(position = pos)
    }
}