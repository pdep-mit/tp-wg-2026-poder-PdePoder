import wollok.game.*

object personaje{
    var property vida = 100
    var property energia = 50
    var property position = game.origin()

    method image() = "player.png" // Nota: tanto player como personaje falta darle identidad 

    method recibirDanio() {
    vida -= 25 // falta implementar logica de restar esa vida al personaje si colisiona con el fantasma por ahora esta para que reinicie desde 0 
    }
    method tomar(pocion) {
      // falta implementar logica
    }
}