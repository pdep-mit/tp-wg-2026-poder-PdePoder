import gameConfiguration.*

object movimiento{
    method mover(personajeLibre, direccion){
		const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
		personajeLibre.position(nuevaPosicion)
	}
}

object haciaArriba {

	method posicionSiguiente(posicion) {
		const nuevaPosicion = posicion.up(1)
		return if(nuevaPosicion.y() <= 9) nuevaPosicion else posicion
	} 
	
}

object haciaAbajo {
	
	method posicionSiguiente(posicion) { 
		const nuevaPosicion = posicion.down(1)
		return if(nuevaPosicion.y() >= 0) nuevaPosicion else posicion
	}
}

object haciaLaDerecha {
	
	method posicionSiguiente(posicion) { 
		const nuevaPosicion = posicion.right(1)
		return if(nuevaPosicion.x() <= 14) nuevaPosicion else posicion.left(14)
	}
}

object haciaLaIzquierda {
	
	method posicionSiguiente(posicion) {
		const nuevaPosicion = posicion.left(1)
		return if(nuevaPosicion.x() >= 0) nuevaPosicion else posicion.right(14)
	}	
}