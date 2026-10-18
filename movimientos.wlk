import gameConfiguration.*

object movimientoRandom {
    const direcciones = [haciaArriba, haciaAbajo, haciaLaIzquierda, haciaLaDerecha]

    method mover(personajeLibre) {
        const direccionElegida = direcciones.anyOne()
        movimiento.mover(personajeLibre, direccionElegida)
    }
}

object movimiento {
    method mover(personajeLibre, direccion) {
        const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
        personajeLibre.position(nuevaPosicion)
    }
}

object haciaArriba {
    method posicionSiguiente(posicion) {
        const nuevaPosicion = posicion.up(1)
        return if (nuevaPosicion.y() <= 9) nuevaPosicion else posicion
    } 
}

object haciaAbajo {
    method posicionSiguiente(posicion) { 
        const nuevaPosicion = posicion.down(1)
        return if (nuevaPosicion.y() >= 0) nuevaPosicion else posicion
    }
}

object haciaLaDerecha {
    method posicionSiguiente(posicion) { 
        const nuevaPosicion = posicion.right(1)
        // Límite en x = 14: si intenta avanzar más allá, se queda en la misma posición
        return if (nuevaPosicion.x() <= 14) nuevaPosicion else posicion
    }
}

object haciaLaIzquierda {
    method posicionSiguiente(posicion) {
        const nuevaPosicion = posicion.left(1)
        // Límite en x = 0: si intenta avanzar más a la izquierda, se queda en la misma posición
        return if (nuevaPosicion.x() >= 0) nuevaPosicion else posicion
    }	
}