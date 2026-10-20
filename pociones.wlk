import wollok.game.*

class Pocion {
    var property position

    method teAtaca(alguien) {
        self.interactuar(alguien)
    }
    method interactuar(alguien) {
        self.stock()
    }

    method stock() {
        generadorPociones.removerPocion(self) // Notifica al generador para liberar cupo
        game.removeVisual(self) 
    }
}

class PocionEnergizante inherits Pocion {

    method image() = "pocion_verde.png"

    override method interactuar(alguien) {
        alguien.sumarEnergia(20)
        game.say(alguien, "¡+20 de Energía!")
        super(alguien)
    }
}

class PocionCurativa inherits Pocion {

    method image() = "pocion_roja.png"

    override method interactuar(alguien) {
        alguien.curar(20)
        game.say(alguien, "¡+20 de Vida!")
        super(alguien)
        
    }
}

class PocionVenenosa inherits Pocion {

    method image() = "pocion_morada.png"

    override method interactuar(alguien) {
        alguien.recibirDanio(15)
        game.say(alguien, "¡-15 de Vida!")
        super(alguien)
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