# Explicaciones teóricas

El polimorfismo se aplicó en la parte de colisiones, donde se envía el mensaje teAtaca() y cada elemento responde de manera diferente.
- enemigos --> reducen la vida de Lionel
- trampas -->  se aplican distintos efectos según el tipo de trampa
- pociones --> benefician o perjudican a Lionel

La herencia se utilizó para que la clase fantasma, serpiente y escorpión hereden de la clase Enemigo; y para que las distintas pociones hereden de la clase Pocion. Tambien se aplicó el override para especializar cada comportamiento.

Las colecciones se utilizaron para emplear listas de enemigos, trampas, niveles y pociones activas. Un ejemplo de un buen uso es en el movimientoRandom que utiliza la serpiente, ya que
en base a una lista de movimientos direccionales se aplica la funcion anyOne() para elegir un proximo movimiento aleatorio de la misma.
# Diagramas

![diagrama](Diagrama.png)