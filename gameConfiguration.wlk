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
        nivel1.iniciar()
        //self.detallesVisuales()
        //self.configurarAcciones()
        //self.configurarColisiones()
        //self.configurarMovimientoFantasma()
    }

    method configurarDimensiones(){
        game.height(10)
        game.width(15)
        //game.cellSize(64)
        game.boardGround("fondo1015.png")
    }


    method configurarAcciones(){
		var personajeControlado = personaje // cambiar por el nombre que corresponda
		keyboard.t().onPressDo({ personajeControlado = personaje})

		keyboard.up().onPressDo({ movimiento.mover(personajeControlado, haciaArriba) })
		keyboard.down().onPressDo({ movimiento.mover(personajeControlado, haciaAbajo) })
		keyboard.left().onPressDo({ movimiento.mover(personajeControlado, haciaLaIzquierda) })
		keyboard.right().onPressDo({ movimiento.mover(personajeControlado, haciaLaDerecha) })
	}

    // =========== Tick de los enemigos ==========
    method configurarMovimientoFantasma() {
        game.onTick(500, "moverFantasma", {
            fantasma.movete()
        })
    }
    method configurarMovimientoSerpiente() {
        game.onTick(2000, "moverSerpiente", {
            serpiente1.movete()
        })
    }

    // =========== Colisiones ==========
    // Cuando el fantasma colisione con el personaje, el fantasma le baja la vida al personaje(una cierta cantidad)¿?
    method configurarColisiones() {
        game.onCollideDo(fantasma, {alguien => 
            fantasma.teAtaca(alguien)
        })
    }

    // Cuando el pozo colisione con el personaje, lo debe mandar al nivel anterior o a su posición inicial
    method configurarCaerEnTrampa() {
        game.onCollideDo(pozo, {alguien =>
            pozo.teAbsorbe(alguien, personaje)
        })
    }

    // Cuando la llave colisione con el personaje, el personaje termina el nivel
    method configurarTomarLlave() {
        game.onCollideDo(llave, {alguien =>
            alguien.vida(100)
            game.say(alguien, "¡La tengo!")
        })
    }
}

// Logica para implementar niveles 
object nivel1{

    method iniciar() {    
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoFantasma()
        config.configurarMovimientoSerpiente()
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
    }

    method detallesVisuales(){
        game.addVisual(personaje)
        game.addVisual(llave)
        game.addVisual(fantasma)
        game.addVisual(pozo)
        game.addVisual(serpiente1)
        game.addVisual(escorpion1)
    }
}