import wollok.game.*

class PocionEnergizante {
    var property position

    method image() = "pocion_verde.png"

    method interactuar(alguien) {
        alguien.sumarEnergia(20)
        game.say(alguien, "¡+20 de Energía!")
        generadorPociones.removerPocion(self) // Notifica al generador para liberar cupo
        game.removeVisual(self)
    }

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
        generadorPociones.removerPocion(self) // Notifica al generador para liberar cupo
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
        generadorPociones.removerPocion(self) // Notifica al generador para liberar cupo
        game.removeVisual(self)
    }

    method teAtaca(alguien) {
        self.interactuar(alguien)
    }
}

// Objeto generador de pociones con límite máximo de 4 en pantalla
object generadorPociones {
    const pocionesActivas = [] // Lista para llevar el control de cuántas hay en pantalla

    method limiteAlcanzado() = pocionesActivas.size() >= 4

    method intentarGenerarPocion() {
        if (not self.limiteAlcanzado()) {
            const nuevaPocion = self.crearPocionAleatoria()
            pocionesActivas.add(nuevaPocion)
            game.addVisual(nuevaPocion)
        }
    }

    method crearPocionAleatoria() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        const pos = game.at(x, y)

        const tipo = (1..3).anyOne()

        return if (tipo == 1) new PocionEnergizante(position = pos)
               else if (tipo == 2) new PocionCurativa(position = pos)
               else new PocionVenenosa(position = pos)
    }

    method removerPocion(pocion) {
        pocionesActivas.remove(pocion)
    }

    method reiniciar() {
        pocionesActivas.clear()
    }
}