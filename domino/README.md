# Dominó

En esta práctica se realizará una versión adaptada del juego del dominó que se describe a continuación

## El juego

Para jugar al dominó son necesarias 28 fichas rectangulares. Cada ficha está dividida en 2 espacios iguales en los que aparece una cifra del 0 al 6. Las fichas cubre todas las combinaciones posibles con estos números.

![Fichas dominó](https://es-static.z-dn.net/files/dc4/a8bc696806cfb43b7ac6db6dab9899ed.png)

Se puede jugar con **2, 3 ó 4 jugadores**. El **objetivo** del juego es colocar todas las fichas en la mesa antes que los contrarios y sumar puntos. El jugador que gana una ronda, suma puntos según las fichas que no han podido colocar los oponentes.La partida termina cuando al finalizar una ronda un jugador alcanza la cantidad de puntos preestablecida al inicio de la partida.

## Comienzo

Al comienzo de cada ronda cada jugador recibe **7 fichas**, si hay menos de 4 jugadores, las fichas restantes se guardan en el **pozo**. Inicia la ronda el jugador que tenga la ficha con el doble más alto (si juegan 4 personas, siempre empezará el 6 doble). En caso de no tener dobles ninguno de los jugadores, comenzará el jugador que tenga la ficha más alta. A partir de ese momento, los jugadores realizan su jugada, por turnos, siguiendo el orden inverso a las manecillas del reloj.

## Desarrollo


En su turno, cada jugador debe colocar una de sus fichas en uno de los 2 extremos abiertos, de tal forma que los puntos de uno de los lados de la ficha coincida con los puntos del extremo donde se está colocando. Los dobles se colocan de forma transversal.

Una vez que el jugador ha colocado la ficha en su lugar, su turno termina y pasa al siguiente jugador.

Si un jugador no puede jugar, debe **“robar”** del pozo tantas fichas como sean necesarias. Si no quedan fichas en el pozo, pasará el turno al siguiente jugador.

## Final de una ronda

La ronda continúa con los jugadores colocando sus fichas hasta que se presenta alguna de las situaciones siguientes:

- **Dominó**

    Cuando un jugador coloca **su última ficha en la mesa**, se dice que ese jugador dominó la ronda. El jugador que ha ganado la ronda suma los puntos de todos sus contrincantes.

- **Cierre**

    Existen casos donde ninguno de los jugadores puede continuar la partida. Esto ocurre cuando los números de los extremos ya han sido jugados 7 veces. En ese momento se dice que la partida está cerrada. Los jugadores contarán los puntos de las fichas que les quede; el jugador con menos puntos es el ganador y suma los puntos de la manera habitual. Pudiera darse el caso de tener los mismos puntos en cuyo caso se asignará a cada uno de ellos los puntos conseguidos.

## Fin de la partida

El juego termina cuando un jugador consigue la cantidad de puntos necesarios para ganar.

---

# Enunciado de la Práctica


Realizar un guión para la _Shell bash_ denominado ```domino.sh```. La ejecución del guión necesitará de un fichero de configuración ```config.cfg``` que obligatoriamente tendrá que existir antes de la invocación del mismo.

El guión podrá ejecutarse sin argumentos, o con el argumento siguiente: ```domino.sh [-g]```

Los corchetes indican que el argumento g es opcional, en caso de que el guión se invoque con dicho parámetro, se mostrarán los datos de los componentes del grupo, luego se acaba. En caso contrario, la ejecución del guión mostrará un menú con opciones igual al siguiente:

    M) MODIFICAR CONFIGURACION
    J) JUGAR
    F) CLASIFICACION
    E) ESTADISTICAS
    S) SALIR
    “Domino”. Elija una opción >>

Una vez que el usuario elija una de las opciones se ejecutará dicha opción y después se mostrará: ```Pulse INTRO para continuar.``` Luego volverá de nuevo al menú principal (menos en la opción de SALIR que acabará con el guión).

Las opciones del menú se explican a continuación:

## M) MODIFICAR CONFIGURACIÓN

Esta opción permite cambiar la configuración del juego (fichero ```config.cfg``` que estará en la misma ruta) durante la ejecución del guión. El usuario podrá cambiar la configuración de manera interactiva, no estando permitido el uso de editores para dicho cometido. Los cambios realizados en esta opción se asentarán en el fichero para que se mantengan en sucesivas ejecuciones del guión.

El formato del fichero ```config.cfg``` es el siguiente, y se debe respetar de manera exacta:

| Formato                       | Ejemplo de fichero config.cfg |
|-------------------------------|-------------------------------|
| JUGADORES=jugadores           | JUGADORES=2                   |
| PUNTOSGANADOR=puntos          | PUNTOSGANADOR=75              |
| INTELIGENCIA=inteligencia     | INTELIGENCIA=1                |      
| LOG=ficherolog                | LOG=./log/fichero.log         |

Donde:

- ```JUGADORES``` será un número mayor o igual a 2 y menor o igual que 4, e indicará el número de jugadores de la partida

- ```PUNTOS``` será un número mayor o igual a 50, e indicará la puntuación que debe alcanzar un jugador para convertirse en ganador de la partida.

- ```INTELIGENCIA``` será o 0 o 1, e indicará si los jugadores no interactivos que intervienen en la partida eligen sus fichas de manera aleatoria (si es 0) o de acuerdo a una estrategia ganadora (si es 1). Se deja libertad en la elección de la estrategia ganadora (fichas con más puntos primero, fichas dobles primero, estrategias combinadas, etc).

- ```FICHEROLOG``` será un fichero (ruta absoluta o relativa donde se escribirán los datos de cada partida).

## J) JUGAR

Desarrolla una partida completa del dominó. Se llevarán a cabo las rondas necesarias hasta que un jugador alcance la puntuación ganadora.

Se deja libertad para el desarrollo y el diseño de la interfaz del juego teniendo en cuenta las siguientes cuestiones:

- Existirá un usuario interactivo controlado por el usuario que ejecuta el guión. Todos los demás usuarios jugarán de forma automática teniendo en cuenta el parámetro ```INTELIGENCIA``` del fichero de configuración.

- Las fichas de todos los jugadores estarán visibles.

- Las fichas del pozo no deben estar visibles.

- De manera obligatoria se debe mostrar la información del progreso de la partida que es importante para el seguimiento del juego, por ejemplo, la identificación de los jugadores, el número de rondas de la partida, el turno, las fichas en mesa, número de fichas que hay en el pozo, la puntuación etc...

Una vez finalizada la partida se pasarán los datos necesarios al fichero de log y se mostrará por pantalla un mensaje indicando el jugador ganador junto a su puntuación.

**Datos del fichero de log**

En cada partida del juego se escribirá un registro de actividad en el fichero de log que nos servirá posteriormente para calcular estadísticas. El fichero NO se ha de sobrescribir en las diferentes ejecuciones del guión.

Cada línea del fichero representará una partida con el siguiente formato:

**Fecha|Hora|Jugadores|Tiempo|Rondas|Inteligencia|PuntosGanador|JugadorGanador|Puntos**

- ```Fecha``` - fecha actual (ddmmyy).

- ```Hora``` - hora al finalizar la partida.

- ```Jugadores``` - número de jugadores.

- ```Tiempo``` - duración de la partida.

- ```Rondas``` - número de rondas que se han jugado para la finalización de la partida.

- ```Inteligencia``` - parámetro   del fichero de configuración.

- ```PuntosGanador``` - parámetro   del fichero de configuración.

- ```JugadorGanador``` - Identificador del jugador que ha ganado la partida.

- ```Puntos``` - puntos obtenidos por los jugadores de la partida ordenados de manera decreciente y con el formato: puntosx-puntosy-puntosz-puntosw. Se pondrá un * en caso de no existir un jugador.


## E) ESTADISTICAS

Se mostrarán por pantalla las siguientes estadísticas del juego:

- Número total de partidas jugadas.

- Media de los puntos ganadores.

- Media de rondas de las partidas jugadas.

- Media de los tiempos de todas las partidas jugadas.

- Tiempo total invertido en todas las partidas.

- Porcentaje de partidas jugadas con inteligencia activada.

- Media de la suma de los puntos obtenidos por todos los jugadores en las partidas jugadas.

## F) CLASIFICACION

- Datos de la partida más corta.

- Datos de la partida más larga.

- Datos de la partida con más rondas.

- Datos de la partida con menos rondas.

- Datos de la partida con máximo PuntosGanador.

- Datos de la partida con más puntos obtenidos por todos los jugadores.


## S)SALIR

Sale del menú.