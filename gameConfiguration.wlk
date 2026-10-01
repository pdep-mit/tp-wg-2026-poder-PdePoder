import personaje.*
import movimientos.*
import pociones.*
import enemigos.*
import wollok.game.*


object config{
    method alturaMaxima() = 16
	method anchoMaximo() = 16
	

	method configurarJuego(){
        self.detallesVisuales()
        self.configurarAcciones()
        self.configurarColisiones()
        self.configurarMovimientoFantasma()
}

    method detallesVisuales(){
        game.addVisual(personaje)
        game.addVisual(fantasma)
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


}