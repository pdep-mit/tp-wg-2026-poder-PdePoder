import personaje.*
import movimientos.*
import pociones.*
import enemigos.*
import trampas.*
import wollok.game.*


object config{

	method configurarJuego(){
        game.title("Grupo: PdePoder | La Llave")
        self.configurarDimensiones()

        self.detallesVisuales()
        self.configurarAcciones()
        self.configurarColisiones()
        self.configurarMovimientoFantasma()
    }

    method configurarDimensiones(){
        game.height(10)
        game.width(15)
        //game.cellSize(64)
        game.boardGround("fondo1015.png")
    }

    method detallesVisuales(){
        game.addVisual(personaje)
        game.addVisual(llave)
        game.addVisual(fantasma)
        game.addVisual(serpiente1)
        game.addVisual(escorpion1)
    }


    method configurarAcciones(){
		var personajeControlado = personaje // cambiar por el nombre que corresponda
		keyboard.t().onPressDo({ personajeControlado = personaje})

		keyboard.up().onPressDo({ movimiento.mover(personajeControlado, haciaArriba) })
		keyboard.down().onPressDo({ movimiento.mover(personajeControlado, haciaAbajo) })
		keyboard.left().onPressDo({ movimiento.mover(personajeControlado, haciaLaIzquierda) })
		keyboard.right().onPressDo({ movimiento.mover(personajeControlado, haciaLaDerecha) })
	}

    method configurarMovimientoFantasma() {
    game.onTick(500, "moverFantasma", {
        fantasma.mover()
    })
}

    method configurarColisiones() {
    game.onCollideDo(fantasma, {alguien =>
    fantasma.teAtrapa(alguien, personaje)})
}

    method configurarCaerEnTrampa() {
    game.onCollideDo(pozo, {alguien =>
    pozo.teAbsorbe(alguien, personaje)})
}

}

// Logica para implementar niveles 
object nivel1{
    method iniciar() {
        
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoFantasma()
        config.configurarCaerEnTrampa()
    }
    method detallesVisuales(){
        game.addVisual(personaje)
        game.addVisual(fantasma)
        game.addVisual(pozo)
    }
}