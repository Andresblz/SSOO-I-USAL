#!/bin/bash

# ========= TEXTOS ========= #
# Menu principal del programa
MENU="\nMENÚ \n\tM) MODIFICAR CONFIGURACIÓN \n\tJ) JUGAR \n\tF) CLASIFICACIÓN \n\tE) ESTADÍSTICAS \n\tS) SALIR"
# Menu de la configuración
MENU_CFG="\nCONFIGURACIÓN \n\t[1] - JUGADORES \n\t[2] - PUNTOS GANADOR \n\t[3] - INTELIGENCIA \n\t[4] - FICHERO LOG \n\t[S] - SALIR"
# Ruta del fichero 'fichero.log'
FICHEROLOG=""
# Fichero de configuración
CONFIG="config.cfg"


# ========= FUNCIONES DE TEXTO ========= #
function titulo {
    echo -e "██████   ██████  ███    ███ ██ ███    ██  ██████     ███████ ██   ██" 
    echo -e "██   ██ ██    ██ ████  ████ ██ ████   ██ ██    ██    ██      ██   ██"
    echo -e "██   ██ ██    ██ ██ ████ ██ ██ ██ ██  ██ ██    ██    ███████ ███████"
    echo -e "██   ██ ██    ██ ██  ██  ██ ██ ██  ██ ██ ██    ██         ██ ██   ██"
    echo -e "██████   ██████  ██      ██ ██ ██   ████  ██████  ██ ███████ ██   ██"
    echo -e "\n"
}

function pulseParaContinuar {
	echo -en "\n\nPulse INTRO para continuar..."
	read
	echo -e "\n"
}

function mostrarProgramadoresTrabajo {
    echo -e "\n\n--------------------------------------------------"
    echo -e "|                 PROGRAMADOR(ES)                |"
    echo -e "--------------------------------------------------"
    echo -e "|                                                |"
    echo -e "--------------------------------------------------\n\n"
}

function mostrarTextoClasificacion {
    echo -e "\n\n"
    echo -e "  ___  __      __    ___  ____  ____  ____   ___    __     ___  ____  _____  _  _ "
    echo -e " / __)(  )    /__\  / __)(_  _)( ___)(_  _) / __)  /__\   / __)(_  _)(  _  )( \( )"
    echo -e "( (__  )(__  /(__)\ \__ \ _)(_  )__)  _)(_ ( (__  /(__)\ ( (__  _)(_  )(_)(  )  ( "
    echo -e " \___)(____)(__)(__)(___/(____)(__)  (____) \___)(__)(__) \___)(____)(_____)(_)\_)"
    echo -e "\n"
}

function mostrarTextoEstadisticas {
    echo -e "\n\n"
    echo -e " ____  ___  ____    __    ____   ___  ____  ____   ___    __    ___ "
    echo -e "( ___)/ __)(_  _)  /__\  (  _ \ / __)(_  _)(_  _) / __)  /__\  / __)"
    echo -e " )__) \__ \  )(   /(__)\  )(_) )\__ \  )(   _)(_ ( (__  /(__)\ \__ \""
    echo -e "(____)(___/ (__) (__)(__)(____/ (___/ (__) (____) \___)(__)(__)(___/"
    echo -e "\n"
}


# ========= JUEGO ========= #
function juego {
    clear
    titulo

    PARTIDA_GANADA=0
    RONDA_GANADA=0
    CONTADOR_POZO=0

    if [[ $NUM_RONDA -eq 1 ]]
    then
        echo -e -n "\nIngrese su nickname >> "
        read NICKNAME
    fi

    while [[ $PARTIDA_GANADA -eq 0 ]]
    do
        FICHAS=('0|0' '0|1' '0|2' '0|3' '0|4' '0|5' '0|6'       # 0 - 6
                      '1|1' '1|2' '1|3' '1|4' '1|5' '1|6'       # 7 - 12
                            '2|2' '2|3' '2|4' '2|5' '2|5'       # 13 - 17
                                  '3|3' '3|4' '3|5' '3|6'       # 18 - 21
                                        '4|4' '4|5' '4|6'       # 22 - 24
                                              '5|5' '5|6'       # 25 - 26
                                                    '6|6')      # 27

        declare -a JUGADOR1=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
        declare -a JUGADOR2=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
        declare -a JUGADOR3=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
        declare -a JUGADOR4=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
        declare -a POZO
        declare -a ARRAYTOTAL
        declare -a PASO

        EMPIEZA_JUGADOR=-1

        repartoAleatorio
        comprobarQueJugadorEmpiezaPartida

        case $EMPIEZA_JUGADOR in
            1)
                muestraTablero
                while [[ $RONDA_GANADA -eq 0 ]]
                do
                    turnoJugador
                    muestraTablero
                    comprobarRonda
                    if [[ $JUGADORES -eq 4 ]]
                    then
                        turnoMaquina 4
                        muestraTablero
                        comprobarRonda
                        turnoMaquina 3
                        muestraTablero
                        comprobarRonda
                    elif [[ $JUGADORES -eq 3 ]]
                    then
                        turnoMaquina 3
                        muestraTablero
                        comprobarRonda
                    fi
                    turnoMaquina 2
                    muestraTablero
                    comprobarRonda
                done
                ;;
            2)
                muestraTablero
                while [[ $RONDA_GANADA -eq 0 ]]
                do
                    turnoMaquina 2
                    muestraTablero
                    comprobarRonda
                    turnoJugador
                    muestraTablero
                    comprobarRonda
                    if [[ $JUGADORES -eq 4 ]]
                    then
                        turnoMaquina 4
                        muestraTablero
                        comprobarRonda
                        turnoMaquina 3
                        muestraTablero
                        comprobarRonda
                    elif [[ $JUGADORES -eq 3 ]]
                    then
                        turnoMaquina 3
                        muestraTablero
                        comprobarRonda
                    fi
                done
                ;;
            3)
                muestraTablero
                while [[ $RONDA_GANADA -eq 0 ]]
                do
                    turnoMaquina 3
                    muestraTablero
                    comprobarRonda
                    turnoMaquina 2
                    muestraTablero
                    comprobarRonda
                    turnoJugador
                    muestraTablero
                    comprobarRonda
                    if [[ $JUGADORES -eq 4 ]]
                    then
                        turnoMaquina 4
                        muestraTablero
                        comprobarRonda
                    fi
                done
                ;;
            4)
                muestraTablero
                while [[ $RONDA_GANADA  -eq 0 ]]
                do
                    turnoMaquina 4
                    muestraTablero
                    comprobarRonda
                    turnoMaquina 3
                    muestraTablero
                    comprobarRonda
                    turnoMaquina 2
                    muestraTablero
                    comprobarRonda
                    turnoJugador
                    muestraTablero
                    comprobarRonda
                done
                ;;
            *)
                echo -e "ERROR: Empieza jugador - $EMPIEZA_JUGADOR"
                ;;
        esac
    done
    
}

function turnoJugador {
    POS_DOBLE=$(( $POS_DOBLE_J1+1 ))
    SIZE_JUGADOR=${#JUGADOR1[@]}
    SIZE_TABLERO=${#ARRAYTOTAL[@]}
    COLOCAR_FICHA=0
    
    if [[ $SIZE_TABLERO -eq 0 ]]
    then
        read -p "Ficha a colocar (1-${#JUGADOR1[@]}) >> " POSICION
        if [[ $POSICION != $POS_DOBLE ]]
        then
            echo -e "Tienes que seleccionar la ficha más alta."
            turnoJugador
        fi
        ARRAYTOTAL+=(${JUGADOR1[$POSICION-1]})
        COLOCAR_FICHA=1
    else
        # Tablero ya esté empezado (Colocamos - Robamos - Pasamos)
        read -p "Colocar [c] - Robar del pozo [r] - Pasar [p] >> " ELECCION
        case $ELECCION in
            c|C)
                read -p "Ficha a colocar (1-${#JUGADOR1[@]}) >> " POSICION
                if [[ $POSICION -lt 1 ]] && [[ $POSICION -gt ${#JUGADOR1[@]} ]]
                then
                    echo -e "Posicion invalida (1-${#JUGADOR1[@]})"
                    turnoJugador
                fi

                read -p "Izquierda [0] o Derecha [1] >> " DONDE
                if [[ $DONDE != 0 ]] && [[ $DONDE != 1 ]]
                then
                    echo -e "Dato invalido (0-1)"
                    turnoJugador
                fi
                
                comprobarSiPuedeColocarFicha JUGADOR1 $POSICION $DONDE

                if [[ $COLOCAR_FICHA -eq 0 ]]
                then
                    echo -e "ERROR: No se puede colocar la ficha ${JUGADOR1[$POSICION-1]} en el lugar seleccionado."
                    turnoJugador
                fi
                ;;
            r|R)
                if [[ ${#POZO[@]} -eq 0 ]] || [[ $CONTADOR_POZO -gt ${#POZO[@]} ]]
                then
                    echo -e "No se puede robar (pozo vacío)."
                    turnoJugador
                fi

                JUGADOR1+=("${POZO[$CONTADOR_POZO]}")
                let CONTADOR_POZO=$CONTADOR_POZO+1
                muestraTablero
                turnoJugador
                ;;
            p|P)
                if [[ $JUGADORES -eq 4 ]]
                then
                    PASO+=( 'x' )
                elif [[ $JUGADORES -eq 3 ]]
                then
                    PASO+=( 'x' 'x' )
                elif [[ $JUGADORES -eq 2 ]]
                then
                    PASO+=( 'x' 'x' 'x' )
                fi
                return 0
                ;;
            *)
                echo "ERROR: Seleccione una opcion valida [C - R - P]"
                turnoJugador
                ;;
        esac
    fi

    if [[ $COLOCAR_FICHA -eq 1 ]]
    then
        PASO=()
        POSICION=$(( $POSICION-1 ))
        JUGADOR1[$POSICION]="x"
        NUEVO_ARRAY_JUGADOR=()
        ind=0
        for (( i=0; i<${#JUGADOR1[@]}; i++ ))
        do
            if [[ ${JUGADOR1[$i]} != "x" ]]
            then
                NUEVO_ARRAY_JUGADOR[$ind]=${JUGADOR1[$i]}
                let ind=$ind+1
            fi
        done
        JUGADOR1=("${NUEVO_ARRAY_JUGADOR[@]}")
        COLOCAR_FICHA=0
    fi
}

function turnoMaquina {
    if [[ $1 -eq 2 ]]
    then
        if [[ ${#ARRAYTOTAL[@]} -eq 0 ]]
        then
            ARRAYTOTAL+=(${JUGADOR2[$POS_DOBLE_J2]})
            POSICION=$(( $POS_DOBLE_J2+1 ))
            COLOCAR_FICHA=1
        elif [[ $INTELIGENCIA -eq 0 ]]
        then
            POSICION=1
            DONDE=1

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $POSICION -lt ${#JUGADOR2[@]} ]]
            do
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR2 $POSICION $DONDE
                fi
                
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                then
                    DONDE=1
                    comprobarSiPuedeColocarFicha JUGADOR2 $POSICION $DONDE
                    if [[ $COLOCAR_FICHA -eq 0 ]]
                    then
                        let POSICION=$POSICION+1
                    fi
                fi
            done
        elif [[ $INTELIGENCIA -eq 1 ]]
        then
            ARR_INT_J2=()
            DONDE=1
            CONTADOR_ROBAR=0
            sumaArrayInteligenciaMaquina ${#JUGADOR2[@]} JUGADOR2 ARR_INT_J2

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $CONTADOR_ROBAR -lt ${#ARR_INT_J2[@]}+1 ]]
            do
                buscaValorMasAltoInteligenciaMaquina ARR_INT_J2 ${#ARR_INT_J2[@]}
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR2 $POSICION $DONDE

                    if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                    then
                        DONDE=1
                        comprobarSiPuedeColocarFicha JUGADOR2 $POSICION $DONDE
                        if [[ $COLOCAR_FICHA -eq 0 ]]
                        then
                            ARR_INT_J2[$POSICION-1]="x"
                            let CONTADOR_ROBAR=$CONTADOR_ROBAR+1
                        fi
                    fi
                fi
            done
        fi

        if [[ $COLOCAR_FICHA -eq 1 ]]
        then
            PASO=()
            POSICION=$(( $POSICION-1 ))
            JUGADOR2[$POSICION]="x"
            NUEVO_ARRAY_JUGADOR=()
            ind=0
            for (( i=0; i<${#JUGADOR2[@]}; i++ ))
            do
                if [[ ${JUGADOR2[$i]} != "x" ]]
                then
                    NUEVO_ARRAY_JUGADOR[$ind]=${JUGADOR2[$i]}
                    let ind=$ind+1
                fi
            done
            JUGADOR2=("${NUEVO_ARRAY_JUGADOR[@]}")
            COLOCAR_FICHA=0
        elif [[ $COLOCAR_FICHA -eq 0 ]] && [[ ${#POZO[@]} != 0 ]] && [[ $CONTADOR_POZO -lt ${#POZO[@]} ]]
        then
            JUGADOR2+=("${POZO[$CONTADOR_POZO]}")
            let CONTADOR_POZO=$CONTADOR_POZO+1
            COLOCAR_FICHA=0
            turnoMaquina 2
        else
            PASO+=( 'x' )
            COLOCAR_FICHA=0
            return
        fi 
    elif [[ $1 -eq 3 ]]
    then
        if [[ ${#ARRAYTOTAL[@]} -eq 0 ]]
        then
            ARRAYTOTAL+=(${JUGADOR3[$POS_DOBLE_J3]})
            POSICION=$(( $POS_DOBLE_J3+1 ))
            COLOCAR_FICHA=1
        elif [[ $INTELIGENCIA -eq 0 ]]
        then
            POSICION=1
            DONDE=1

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $POSICION -lt ${#JUGADOR3[@]} ]]
            do
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR3 $POSICION $DONDE
                fi
                
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                then
                    DONDE=1
                    comprobarSiPuedeColocarFicha JUGADOR3 $POSICION $DONDE
                    if [[ $COLOCAR_FICHA -eq 0 ]]
                    then
                        let POSICION=$POSICION+1
                    fi
                fi
            done
        elif [[ $INTELIGENCIA -eq 1 ]]
        then
            ARR_INT_J3=()
            DONDE=1
            CONTADOR_ROBAR=0
            sumaArrayInteligenciaMaquina ${#JUGADOR3[@]} JUGADOR3 ARR_INT_J3

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $CONTADOR_ROBAR -lt ${#ARR_INT_J3[@]}+1 ]]
            do
                buscaValorMasAltoInteligenciaMaquina ARR_INT_J3 ${#ARR_INT_J3[@]}
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR3 $POSICION $DONDE

                    if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                    then
                        DONDE=1
                        comprobarSiPuedeColocarFicha JUGADOR3 $POSICION $DONDE
                        if [[ $COLOCAR_FICHA -eq 0 ]]
                        then
                            ARR_INT_J3[$POSICION-1]="x"
                            let CONTADOR_ROBAR=$CONTADOR_ROBAR+1
                        fi
                    fi
                fi
            done
        fi

        if [[ $COLOCAR_FICHA -eq 1 ]]
        then
            PASO=()
            POSICION=$(( $POSICION-1 ))
            JUGADOR3[$POSICION]="x"
            NUEVO_ARRAY_JUGADOR=()
            ind=0
            for (( i=0; i<${#JUGADOR3[@]}; i++ ))
            do
                if [[ ${JUGADOR3[$i]} != "x" ]]
                then
                    NUEVO_ARRAY_JUGADOR[$ind]=${JUGADOR3[$i]}
                    let ind=$ind+1
                fi
            done
            JUGADOR3=("${NUEVO_ARRAY_JUGADOR[@]}")
            COLOCAR_FICHA=0
        elif [[ $COLOCAR_FICHA -eq 0 ]] && [[ ${#POZO[@]} != 0 ]] && [[ $CONTADOR_POZO -lt ${#POZO[@]} ]]
        then
            JUGADOR3+=("${POZO[$CONTADOR_POZO]}")
            let CONTADOR_POZO=$CONTADOR_POZO+1
            COLOCAR_FICHA=0
            turnoMaquina 3
        else
            PASO+=( 'x' )
            COLOCAR_FICHA=0
            return
        fi 
    elif [[ $1 -eq 4 ]]
    then
        if [[ ${#ARRAYTOTAL[@]} -eq 0 ]]
        then
            ARRAYTOTAL+=(${JUGADOR4[$POS_DOBLE_J4]})
            POSICION=$(( $POS_DOBLE_J4+1 ))
            COLOCAR_FICHA=1
        elif [[ $INTELIGENCIA -eq 0 ]]
        then
            POSICION=1
            DONDE=1

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $POSICION -lt ${#JUGADOR4[@]} ]]
            do
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR4 $POSICION $DONDE
                fi
                
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                then
                    DONDE=1
                    comprobarSiPuedeColocarFicha JUGADOR4 $POSICION $DONDE
                    if [[ $COLOCAR_FICHA -eq 0 ]]
                    then
                        let POSICION=$POSICION+1
                    fi
                fi
            done
        elif [[ $INTELIGENCIA -eq 1 ]]
        then
            ARR_INT_J4=()
            DONDE=1
            CONTADOR_ROBAR=0
            sumaArrayInteligenciaMaquina ${#JUGADOR4[@]} JUGADOR4 ARR_INT_J4

            while [[ $COLOCAR_FICHA -eq 0 ]] && [[ $CONTADOR_ROBAR -lt ${#ARR_INT_J4[@]}+1 ]]
            do
                buscaValorMasAltoInteligenciaMaquina ARR_INT_J4 ${#ARR_INT_J4[@]}
                if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 1 ]]
                then
                    DONDE=0
                    comprobarSiPuedeColocarFicha JUGADOR4 $POSICION $DONDE

                    if [[ $COLOCAR_FICHA -eq 0 ]] && [[ $DONDE -eq 0 ]]
                    then
                        DONDE=1
                        comprobarSiPuedeColocarFicha JUGADOR4 $POSICION $DONDE
                        if [[ $COLOCAR_FICHA -eq 0 ]]
                        then
                            ARR_INT_J4[$POSICION-1]="x"
                            let CONTADOR_ROBAR=$CONTADOR_ROBAR+1
                        fi
                    fi
                fi
            done
        fi

        if [[ $COLOCAR_FICHA -eq 1 ]]
        then
            PASO=()
            POSICION=$(( $POSICION-1 ))
            JUGADOR4[$POSICION]="x"
            NUEVO_ARRAY_JUGADOR=()
            ind=0
            for (( i=0; i<${#JUGADOR4[@]}; i++ ))
            do
                if [[ ${JUGADOR4[$i]} != "x" ]]
                then
                    NUEVO_ARRAY_JUGADOR[$ind]=${JUGADOR4[$i]}
                    let ind=$ind+1
                fi
            done
            JUGADOR4=("${NUEVO_ARRAY_JUGADOR[@]}")
            COLOCAR_FICHA=0
        elif [[ $COLOCAR_FICHA -eq 0 ]] && [[ ${#POZO[@]} != 0 ]] && [[ $CONTADOR_POZO -lt ${#POZO[@]} ]]
        then
            JUGADOR4+=("${POZO[$CONTADOR_POZO]}")
            let CONTADOR_POZO=$CONTADOR_POZO+1
            COLOCAR_FICHA=0
            turnoMaquina 4
        else
            PASO+=( 'x' )
            COLOCAR_FICHA=0
            return
        fi 
    fi
}

function sumaArrayInteligenciaMaquina {
    CUT=1
    eval ARRAY=\${$2[@]}

    for (( i=0; i<$1; i++ ))
    do
        FICHA_TEMP=$( echo $ARRAY | cut -f $CUT -d " " | tr -d "\r" )
        FICHA_SUMA[1]=$( echo $FICHA_TEMP | cut -f 1 -d "|" )
        FICHA_SUMA[2]=$( echo $FICHA_TEMP | cut -f 2 -d "|" )

        SUMA=$(( ${FICHA_SUMA[1]}+${FICHA_SUMA[2]} ))
        eval $3[$i]='$SUMA'

        let CUT=$CUT+1
    done
}

function buscaValorMasAltoInteligenciaMaquina {
    eval ARRAY=\${$1[@]}
    VALOR_MAYOR=0
    CUT=1

    for (( i=0; i<$2; i++ ))
    do
        VALOR=$( echo $ARRAY | cut -f $CUT -d " " | tr -d "\r" )
        if [[ $VALOR != "x" ]] && [[ $VALOR -gt $VALOR_MAYOR ]]
        then
            POSICION=$(( $i+1 ))
            VALOR_MAYOR=$VALOR
        fi
        let CUT=$CUT+1
    done
}

function voltearFicha {
    FICHA=$1

    IZQ_FICHA=$( echo $FICHA | cut -f 1 -d "|" )
    DCH_FICHA=$( echo $FICHA | cut -f 2 -d "|" )

    FICHA_CAMBIADA+="$DCH_FICHA"
    FICHA_CAMBIADA+="|"
    FICHA_CAMBIADA+="$IZQ_FICHA"
}

function comprobarSiPuedeColocarFicha {
    eval ARRAY=\${$1[@]}
    INDICE=$2
    POS=$3

    declare -a FICHA_CAMBIADA

    FICHA_POSICION=$( echo $ARRAY | cut -f $INDICE -d " " )
    IZQ_FICHA=$( echo $FICHA_POSICION | cut -f 1 -d "|" )
    DCH_FICHA=$( echo $FICHA_POSICION | cut -f 2 -d "|" )

    if [[ $POS -eq 0 ]]  # Izquierda
    then
        PRIMERA_FICHA_ARRAY=$( echo ${ARRAYTOTAL[@]} | cut -f 1 -d " " )
        PARTE_IZQUIERDA_FICHA=$( echo $PRIMERA_FICHA_ARRAY | cut -f 1 -d "|" )

        if [[ $PARTE_IZQUIERDA_FICHA -eq $DCH_FICHA ]]
        then
            ARRAYTOTAL=($FICHA_POSICION "${ARRAYTOTAL[@]}")
            COLOCAR_FICHA=1
        elif [[ $PARTE_IZQUIERDA_FICHA -eq $IZQ_FICHA ]]
        then
            voltearFicha $FICHA_POSICION
            ARRAYTOTAL=($FICHA_CAMBIADA "${ARRAYTOTAL[@]}")
            COLOCAR_FICHA=1
        else
            COLOCAR_FICHA=0
        fi
    else                    # Derecha
        ULTIMA_POSICION=${#ARRAYTOTAL[@]}
        ULTIMA_FICHA_ARRAY=$( echo ${ARRAYTOTAL[@]} | cut -f $ULTIMA_POSICION -d " " )
        PARTE_DERECHA_FICHA=$( echo $ULTIMA_FICHA_ARRAY | cut -f 2 -d "|" )

        if [[ $PARTE_DERECHA_FICHA -eq $IZQ_FICHA ]]
        then
            ARRAYTOTAL+=($FICHA_POSICION)
            COLOCAR_FICHA=1
        elif [[ $PARTE_DERECHA_FICHA -eq $DCH_FICHA ]]
        then
            voltearFicha $FICHA_POSICION
            ARRAYTOTAL+=($FICHA_CAMBIADA)
            COLOCAR_FICHA=1
        else
            COLOCAR_FICHA=0
        fi
    fi
}


# ========= TABLERO DE JUEGO ========= #
function muestraTablero {
    clear
    titulo
    echo -e "RONDA: $NUM_RONDA\n"
    echo -e "PUNTOS $NICKNAME: $PUNTUACIONJ1 | PUNTOS MAQUINA 1: $PUNTUACIONJ2"
    echo -e "PUNTOS MAQUINA 2: $PUNTUACIONJ3 | PUNTOS MAQUINA 3: $PUNTUACIONJ4\n"

    echo -n "POZO > "
    for (( i=$CONTADOR_POZO; i<${#POZO[@]}; i++ ))
    do
        echo -n " x|x "
    done
    echo -e "\n"

    imprimeFichasEnTablero

    echo -e "\n"
    echo -n "$NICKNAME > "
    imprimeFichasJugadorEnTablero JUGADOR1 ${#JUGADOR1[@]}

    echo -n "MAQUINA 1 > "
    imprimeFichasJugadorEnTablero JUGADOR2 ${#JUGADOR2[@]}

    if [[ $JUGADORES -eq 3 ]]
    then
        echo -n "MAQUINA 2 > "
        imprimeFichasJugadorEnTablero JUGADOR3 ${#JUGADOR3[@]}
    elif [[ $JUGADORES -eq 4 ]]
    then
        echo -n "MAQUINA 2 > "
        imprimeFichasJugadorEnTablero JUGADOR3 ${#JUGADOR3[@]}

        echo -n "MAQUINA 3 > "
        imprimeFichasJugadorEnTablero JUGADOR4 ${#JUGADOR4[@]}
    fi
}

function imprimeFichasJugadorEnTablero {
    eval ARR=\${$1[@]}
    CUT=1

    for (( i=0; i<$2; i++ ))
    do
        TEMP=$( echo $ARR | cut -f $CUT -d " ")
        echo -ne "$CUT. $TEMP  "
        let CUT=$CUT+1
    done
    echo -e "\n"
}

function guardaHorizontal {
    let CUT=$2+1
    eval ARRAY=\${$1[@]}

    FICHA=$( echo $ARRAY | cut -f $CUT -d " " )

    ARRTOTAL1+=("   ")
    ARRTOTAL2+=("$FICHA")
    ARRTOTAL3+=("   ")
}

function guardaVertical {
    let CUT=$2+1
    eval ARRAY=\${$1[@]}

    FICHA_TEMP=$( echo $ARRAY | cut -f $CUT -d " " )
    FICHA1=$( echo $FICHA_TEMP | cut -f 1 -d "|" )
    FICHA2=$( echo $FICHA_TEMP | cut -f 2 -d "|" )

    ARRTOTAL1+=(" $FICHA1 ")
    ARRTOTAL2+=("---")
    ARRTOTAL3+=(" $FICHA2 ")
}

function esDoble {
    let CUT=$2+1
    eval ARRAY=\${$1[@]}

    FICHA_TEMP=$( echo $ARRAY | cut -f $CUT -d " " )
    FICHA1=$( echo $FICHA_TEMP | cut -f 1 -d "|" )
    FICHA2=$( echo $FICHA_TEMP | cut -f 2 -d "|" )

    if [[ $FICHA1 -eq $FICHA2 ]]
    then
        DOBLE=1
    else
        DOBLE=0
    fi
}

function imprimeFichasEnTablero {
    declare -a ARRTOTAL1=()
    declare -a ARRTOTAL2=()
    declare -a ARRTOTAL3=()

    DOBLE=-1

    SIZETOTAL=${#ARRAYTOTAL[@]}

    for (( i=0; i<$SIZETOTAL; i++ ))
    do
        esDoble ARRAYTOTAL $i

        if [[ $DOBLE -eq 0 ]]
        then
            guardaHorizontal ARRAYTOTAL $i ARRTOTAL1 ARRTOTAL2 ARRTOTAL3
        elif [[ $DOBLE -eq 1 ]]
        then
            guardaVertical ARRAYTOTAL $i ARRTOTAL1 ARRTOTAL2 ARRTOTAL3
        else
            echo -e "ERROR: No se ha determinado si el valor es doble."
        fi
    done

    echo -e "${ARRTOTAL1[@]}"
    echo -e "${ARRTOTAL2[@]}"
    echo -e "${ARRTOTAL3[@]}"
}


# ========= ALEATORIEDAD FICHAS Y COMPROBACIÓN DE QUIEN INICIA ========= #
function repartoAleatorio {
    CONTADOR=0

    while [[ $CONTADOR -lt 7 ]] 
    do
        aleatorio JUGADOR1 $CONTADOR
        aleatorio JUGADOR2 $CONTADOR

        if [[ $JUGADORES -eq 3 ]]
        then
            aleatorio JUGADOR3 $CONTADOR
        elif [[ $JUGADORES -eq 4 ]]
        then
            aleatorio JUGADOR3 $CONTADOR
            aleatorio JUGADOR4 $CONTADOR
        fi
        
        let CONTADOR=$CONTADOR+1
    done

    if [[ $JUGADORES -lt 4 ]]
    then
        cargaPozo $JUGADORES
    fi
}

function aleatorio {
    temp=`echo $(($RANDOM%28))`

    while [[ ${FICHAS[temp]} = "x" ]]
    do
        temp=`echo $(($RANDOM%28))`
    done

    # eval [arg ...]
    # Los argumentos se leen y se concatenan en un único comando.
    # Si no hay argumentos, o sólo hay argumentos nulos, eval devuelve 0.
    eval $1[$2]='${FICHAS[temp]}'
    FICHAS[temp]='x'
}

function cargaPozo {
    NUMERO_TOTAL_FICHAS_POZO=$(( 28-(7*$1) ))
    CONTADOR=0

    while [[ $CONTADOR -lt $NUMERO_TOTAL_FICHAS_POZO ]]
    do
        aleatorio POZO $CONTADOR
        let CONTADOR=$CONTADOR+1
    done
}

function comprobarQueJugadorEmpiezaPartida {
    declare -a SUMA_J1=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
    POS_DOBLE_J1=-1
    VALOR_DOBLE_J1=-1
    declare -a SUMA_J2=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
    POS_DOBLE_J2=-1
    VALOR_DOBLE_J2=-1
    declare -a SUMA_J3=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
    POS_DOBLE_J3=-1
    VALOR_DOBLE_J3=-1
    declare -a SUMA_J4=( 'x' 'x' 'x' 'x' 'x' 'x' 'x' )
    POS_DOBLE_J4=-1
    VALOR_DOBLE_J4=-1

    CONTADOR=0
    while [[ $CONTADOR -lt 7 ]]
    do
        sumaFichasYGuardaValorMasAlto SUMA_J1 $CONTADOR JUGADOR1 POS_DOBLE_J1 $VALOR_DOBLE_J1 VALOR_DOBLE_J1
        sumaFichasYGuardaValorMasAlto SUMA_J2 $CONTADOR JUGADOR2 POS_DOBLE_J2 $VALOR_DOBLE_J2 VALOR_DOBLE_J2

        if [[ $JUGADORES -eq 3 ]]
        then
            sumaFichasYGuardaValorMasAlto SUMA_J3 $CONTADOR JUGADOR3 POS_DOBLE_J3 $VALOR_DOBLE_J3 VALOR_DOBLE_J3
        elif [[ $JUGADORES -eq 4 ]]
        then
            sumaFichasYGuardaValorMasAlto SUMA_J3 $CONTADOR JUGADOR3 POS_DOBLE_J3 $VALOR_DOBLE_J3 VALOR_DOBLE_J3
            sumaFichasYGuardaValorMasAlto SUMA_J4 $CONTADOR JUGADOR4 POS_DOBLE_J4 $VALOR_DOBLE_J4 VALOR_DOBLE_J4
        fi

        let CONTADOR=$CONTADOR+1
    done

    if [[ $JUGADORES -eq 4 || $VALOR_DOBLE_J1 != "-1" || $VALOR_DOBLE_J2 != "-1" || $VALOR_DOBLE_J3 != "-1" ]]
    then
        comprobacionInicioFichasDobles $VALOR_DOBLE_J1 $VALOR_DOBLE_J2 $VALOR_DOBLE_J3 $VALOR_DOBLE_J4
    else
        comprobacionInicioFichasSimples SUMA_J1 SUMA_J2 SUMA_J3
    fi
}

function sumaFichasYGuardaValorMasAlto {
    let CUT=$2+1
    eval ARRAY=\${$3[@]}

    FICHA_TEMP=$( echo $ARRAY | cut -f $CUT -d " ")
    FICHA_SUMA[1]=$( echo $FICHA_TEMP | cut -f 1 -d "|")
    FICHA_SUMA[2]=$( echo $FICHA_TEMP | cut -f 2 -d "|")

    SUMA=$(( ${FICHA_SUMA[1]}+${FICHA_SUMA[2]} ))

    eval $1[$2]='$SUMA'

    if [[ ${FICHA_SUMA[1]} = ${FICHA_SUMA[2]} ]] && [[ $SUMA -gt $5 ]]
    then
        eval $4='$2'
        eval $6='$SUMA'
    fi
}

function comprobacionInicioFichasDobles {
    if [[ $1 -gt $2 ]] && [[ $1 -gt $3 ]] && [[ $1 -gt $4 ]]
    then
        EMPIEZA_JUGADOR=1
    elif [[ $2 -gt $3 ]] && [[ $2 -gt $4 ]]
    then
        EMPIEZA_JUGADOR=2
    elif [[ $3 -gt $4 ]]
    then
        EMPIEZA_JUGADOR=3
    else
        EMPIEZA_JUGADOR=4
    fi
}

function comprobacionInicioFichasSimples {
    eval ARRJ1=\${$1[@]}
    MAXJ1=$( echo $ARRJ1 | cut -f 0 -d " ")
    eval ARRJ2=\${$2[@]}
    MAXJ2=$( echo $ARRJ2 | cut -f 0 -d " ")

    if [[ $JUGADORES -eq 3 ]]
    then
        eval ARRJ3=\${$3[@]}
        MAXJ3=$( echo $ARRJ3 | cut -f 0 -d " ")
    else
        MAXJ3=-1
    fi

    CONTADOR=1

    while [[ $CONTADOR -lt 7 ]]
    do
        TEMPJ1=$( echo $ARRJ1 | cut -f $contador -d " ")
        if [[ $TEMPJ1 -gt $MAXJ1 ]]
        then
            MAXJ1=$TEMPJ2
        fi

        TEMPJ2=$( echo $ARRJ2 | cut -f $contador -d " ")
        if [[ $TEMPJ2 -gt $MAXJ2 ]]
        then
            MAXJ2=$TEMPJ2
        fi

        TEMPJ3=$( echo $ARRJ3 | cut -f $contador -d " ")
        if [[ $JUGADORES -eq 3 ]] && [[ $TEMPJ3 -gt $MAXJ3 ]]
        then    
            MAXJ3=$TEMPJ3
        fi
    done

    if [[ $MAXJ1 -gt $MAXJ2 ]] && [[ $MAXJ1 -gt $MAXJ3 ]]
    then
        EMPIEZA_JUGADOR=1
    elif [[ $MAXJ2 -gt $MAXJ3 ]]
    then
        EMPIEZA_JUGADOR=2
    else
        EMPIEZA_JUGADOR=3
    fi
}


# ========= COMPROBACIONES RONDA Y PARTIDA ========= #
function sumaPuntosDomino {
    eval ARR1=\${$2[@]}
    eval ARR2=\${$3[@]}
    eval ARR3=\${$4[@]}
    SUMA1=0
    SUMA2=0
    SUMA3=0

    eval CONT1=$5
    eval CONT2=$6
    eval CONT3=$7
    
    CUT=1

    for (( i=0; i<$CONT1; i++ ))
    do
        FICHA=$( echo $ARR1 | cut -f $CUT -d " " )
        IZQ_FICHA=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA1=$(( $SUMA1+$IZQ_FICHA+$DCH_FICHA ))
        let CUT=$CUT+1
    done

    CUT=1

    for (( i=0; i<$CONT2; i++ ))
    do
        FICHA=$( echo $ARR2 | cut -f $CUT -d " " )
        IZQ_FICHA=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA2=$(( $SUMA2+$IZQ_FICHA+$DCH_FICHA ))
        let CUT=$CUT+1

    done

    CUT=1

    for (( i=0; i<$CONT3; i++ ))
    do
        FICHA=$( echo $ARR3 | cut -f $CUT -d " " )
        IZQ_FICHA=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA3=$(( $SUMA3+$IZQ_FICHA+$DCH_FICHA ))
        let CUT=$CUT+1
    done

    SUMA=$(( $SUMA1+$SUMA2+$SUMA3 ))

    if [[ $1 -eq 1 ]]
    then
        PUNTUACIONJ1=$(( $PUNTUACIONJ1+$SUMA ))
    elif [[ $1 -eq 2 ]]
    then
        PUNTUACIONJ2=$(( $PUNTUACIONJ2+$SUMA ))
    elif [[ $1 -eq 3 ]]
    then
        PUNTUACIONJ3=$(( $PUNTUACIONJ3+$SUMA ))
    elif [[ $1 -eq 4 ]]
    then
        PUNTUACIONJ4=$(( $PUNTUACIONJ4+$SUMA ))
    fi
}

function sumaPuntosCierre {
    eval ARR1=\${$1[@]}
    eval ARR2=\${$2[@]}
    eval ARR3=\${$3[@]}
    eval ARR4=\${$4[@]}
    SUMA1=0
    SUMA2=0
    SUMA3=0
    SUMA4=0

    CUT=1

    for (( i=0; i<$5; i++ ))
    do
        FICHA=$( echo $ARR1 | cut -f $CUT -d " " )
        IZQ_FICHA_J1=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA_J1=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA1=$(( $SUMA1+$IZQ_FICHA_J1+$DCH_FICHA_J1 ))
        let CUT=$CUT+1
    done

    CUT=1

    for (( i=0; i<$6; i++ ))
    do
        FICHA=$( echo $ARR2 | cut -f $CUT -d " " )
        IZQ_FICHA_J2=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA_J2=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA2=$(( $SUMA2+$IZQ_FICHA_J2+$DCH_FICHA_J2 ))
        let CUT=$CUT+1
    done

    CUT=1

    for (( i=0; i<$7; i++ ))
    do
        FICHA=$( echo $ARR3 | cut -f $CUT -d " " )
        IZQ_FICHA_J3=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA_J3=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA3=$(( $SUMA3+$IZQ_FICHA_J3+$DCH_FICHA_J3 ))
        let CUT=$CUT+1
    done

    CUT=1

    for (( i=0; i<$8; i++ ))
    do
        FICHA=$( echo $ARR4 | cut -f $CUT -d " " )
        IZQ_FICHA_J4=$( echo $FICHA | cut -f 1 -d "|" )
        DCH_FICHA_J4=$( echo $FICHA | cut -f 2 -d "|" )

        SUMA4=$(( $SUMA4+$IZQ_FICHA_J4+$DCH_FICHA_J4 ))
        let CUT=$CUT+1
    done

    if [[ $JUGADORES -eq 4 ]]
    then
        if [[ $SUMA1 -le $SUMA2 ]] && [[ $SUMA1 -le $SUMA3 ]] && [[ $SUMA1 -le $SUMA4 ]]
        then
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA2
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA3
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA4
            echo -e "GANA LA RONDA $NICKNAME"
        fi

        if [[ $SUMA2 -le $SUMA1 ]] && [[ $SUMA2 -le $SUMA3 ]] && [[ $SUMA2 -le $SUMA4 ]]
        then
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA1
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA3
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA4
            echo -e "GANA LA RONDA MAQUINA 1"
        fi

        if [[ $SUMA3 -le $SUMA1 ]] && [[ $SUMA3 -le $SUMA2 ]] && [[ $SUMA3 -le $SUMA4 ]]
        then
            let PUNTUACIONJ3=$PUNTUACIONJ3+$SUMA1
            let PUNTUACIONJ3=$PUNTUACIONJ3+$SUMA2
            let PUNTUACIONJ3=$PUNTUACIONJ3+$SUMA4
            echo -e "GANA LA RONDA MAQUINA 2"
        fi

        if [[ $SUMA4 -le $SUMA1 ]] && [[ $SUMA4 -le $SUMA2 ]] && [[ $SUMA4 -le $SUMA3 ]]
        then
            let PUNTUACIONJ4=$PUNTUACIONJ4+$SUMA1
            let PUNTUACIONJ4=$PUNTUACIONJ4+$SUMA2
            let PUNTUACIONJ4=$PUNTUACIONJ4+$SUMA3
            echo -e "GANA LA RONDA MAQUINA 3"
        fi

    elif [[ $JUGADORES -eq 3 ]]
    then
        if [[ $SUMA1 -le $SUMA2 ]] && [[ $SUMA1 -le $SUMA3 ]]
        then
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA2
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA3
            echo -e "GANA LA RONDA $NICKNAME"
        fi

        if [[ $SUMA2 -le $SUMA1 ]] && [[ $SUMA2 -le $SUMA3 ]]
        then
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA1
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA3
            echo -e "GANA LA RONDA MAQUINA 1"
        fi

        if [[ $SUMA3 -le $SUMA1 ]] && [[ $SUMA3 -le $SUMA2 ]]
        then
            let PUNTUACIONJ3=$PUNTUACIONJ3+$SUMA1
            let PUNTUACIONJ3=$PUNTUACIONJ3+$SUMA2
            echo -e "GANA LA RONDA MAQUINA 2"
        fi

    else
        if [[ $SUMA1 -le $SUMA2 ]] 
        then
            let PUNTUACIONJ1=$PUNTUACIONJ1+$SUMA2
            echo -e "GANA LA RONDA $NICKNAME"
        fi

        if [[ $SUMA2 -le $SUMA1 ]]
        then
            let PUNTUACIONJ2=$PUNTUACIONJ2+$SUMA1
            echo -e "GANA LA RONDA MAQUINA 1"
        fi
    fi
}

function comprobarRonda {
    if [[ ${#JUGADOR1[@]} -eq 0 ]]
    then
        sumaPuntosDomino 1 JUGADOR2 JUGADOR3 JUGADOR4 ${#JUGADOR2[@]} ${#JUGADOR3[@]} ${#JUGADOR4[@]}
        let NUM_RONDA=$NUM_RONDA+1
        echo -e "GANA LA RONDA: $NICKNAME"
        pulseParaContinuar
        comprobarPartida
    elif [[ ${#JUGADOR2[@]} -eq 0 ]]
    then
        sumaPuntosDomino 2 JUGADOR1 JUGADOR3 JUGADOR4 ${#JUGADOR1[@]} ${#JUGADOR3{@}} ${#JUGADOR4[@]}
        let NUM_RONDA=$NUM_RONDA+1
        echo -e "GANA LA RONDA: MAQUINA 1"
        pulseParaContinuar
        comprobarPartida
    elif [[ ${#JUGADOR3[@]} -eq 0 ]] && [[ $JUGADORES -eq 3 || $JUGADORES -eq 4 ]]
    then
        sumaPuntosDomino 3 JUGADOR1 JUGADOR2 JUGADOR4 ${#JUGADOR1[@]} ${#JUGADOR2[@]} ${#JUGADOR4[@]}
        let NUM_RONDA=$NUM_RONDA+1
        echo -e "GANA LA RONDA: MAQUINA 2"
        pulseParaContinuar
        comprobarPartida
    elif [[ ${#JUGADOR4[@]} -eq 0 ]] && [[ $JUGADORES -eq 4 ]]
    then
        sumaPuntosDomino 4 JUGADOR1 JUGADOR2 JUGADOR3 ${#JUGADOR1[@]} ${#JUGADOR2[@]} ${#JUGADOR3[@]}
        let NUM_RONDA=$NUM_RONDA+1
        echo -e "GANA LA RONDA: MAQUINA 3"
        pulseParaContinuar
        comprobarPartida
    elif [[ ${#PASO[@]} -eq 4 ]]
    then
        sumaPuntosCierre JUGADOR1 JUGADOR2 JUGADOR3 JUGADOR4 ${#JUGADOR1[@]} ${#JUGADOR2[@]} ${#JUGADOR3[@]} ${#JUGADOR4[@]}
        comprobarPartida
    else
        RONDA_GANADA=0
        return 0
    fi
}

function comprobarPartida {
    if [[ $PUNTUACIONJ1 -ge $PUNTOS ]]
    then
        JUGADOR_GANADOR="$NICKNAME"
        echo -e "\n\nFIN DE LA PARTIDA - GANADOR: $NICKNAME\n\n"
        cargarDatosPartidaEnFicherolog
    elif [[ $PUNTUACIONJ2 -ge $PUNTOS ]]
    then
        JUGADOR_GANADOR="MAQUINA 1"
        echo -e "\n\nFIN DE LA PARTIDA - GANADOR: MAQUINA 1\n\n"
        cargarDatosPartidaEnFicherolog
    elif [[ $PUNTUACIONJ3 -ge $PUNTOS ]]
    then
        JUGADOR_GANADOR="MAQUINA 2"
        echo -e "\n\nFIN DE LA PARTIDA - GANADOR: MAQUINA 2\n\n"
        cargarDatosPartidaEnFicherolog
    elif [[ $PUNTUACIONJ4 -ge $PUNTOS ]]
    then
        JUGADOR_GANADOR="MAQUINA 3"
        echo -e "\n\nFIN DE LA PARTIDA - GANADOR: MAQUINA 3\n\n"
        cargarDatosPartidaEnFicherolog
    else
        juego
    fi
}


# ========= CARGA DATOS DE PARTIDA EN FICHERO LOG ========= #
function cargarDatosPartidaEnFicherolog {
    # Fecha|Hora|Jugadores|Tiempo|Rondas|Inteligencia|PuntosGanador|JugadorGanador|Puntos

    PUNTOS_PARTIDA[0]=$PUNTUACIONJ1
    PUNTOS_PARTIDA[1]=$PUNTUACIONJ2
    PUNTOS_PARTIDA[2]=$PUNTUACIONJ3
    PUNTOS_PARTIDA[3]=$PUNTUACIONJ4

    if [[ $JUGADORES -eq 4 ]]
    then
        for (( i=0; i<${#PUNTOS_PARTIDA[@]}; i++ ))
        do
            for (( j=$(( $i+1 )); j<${#PUNTOS_PARTIDA[@]}; j++ ))
            do
                if [[ ${PUNTOS_PARTIDA[$i]} -lt ${PUNTOS_PARTIDA[$j]} ]]
                then
                    temp=${PUNTOS_PARTIDA[$i]}
                    PUNTOS_PARTIDA[$i]=${PUNTOS_PARTIDA[$j]}
                    PUNTOS_PARTIDA[$j]=$temp
                fi
            done
        done
        PUNTOS_PARTIDA_FINAL="${PUNTOS_PARTIDA[0]}-${PUNTOS_PARTIDA[1]}-${PUNTOS_PARTIDA[2]}-${PUNTOS_PARTIDA[3]}"
    elif [[ $JUGADORES -eq 3 ]]
    then
        for (( i=0; i<${#PUNTOS_PARTIDA[@]}; i++ ))
        do
            for (( j=$(( $i+1 )); j<${#PUNTOS_PARTIDA[@]}; j++ ))
            do
                if [[ ${PUNTOS_PARTIDA[$i]} -lt ${PUNTOS_PARTIDA[$j]} ]]
                then
                    temp=${PUNTOS_PARTIDA[$i]}
                    PUNTOS_PARTIDA[$i]=${PUNTOS_PARTIDA[$j]}
                    PUNTOS_PARTIDA[$j]=$temp
                fi
            done
        done
        PUNTOS_PARTIDA[3]="*"
        PUNTOS_PARTIDA_FINAL="${PUNTOS_PARTIDA[0]}-${PUNTOS_PARTIDA[1]}-${PUNTOS_PARTIDA[2]}-${PUNTOS_PARTIDA[3]}"
    else
        if [[ $PUNTUACIONJ1 -gt $PUNTUACIONJ2 ]]
        then
            PUNTOS_PARTIDA_FINAL="${PUNTOS_PARTIDA[0]}-${PUNTOS_PARTIDA[1]}-*-*"
        else
            PUNTOS_PARTIDA_FINAL="${PUNTOS_PARTIDA[1]}-${PUNTOS_PARTIDA[0]}-*-*"
        fi
    fi

    echo -e "FECHA            >> $(date +"%d%m%y")"
    echo -e "HORA             >> $(date +"%H:%M")"
    echo -e "JUGADORES        >> $JUGADORES"
    echo -e "TIEMPO           >> $(($SECONDS-$TIEMPO)) s"
    echo -e "RONDAS           >> $NUM_RONDAS"
    echo -e "INTELIGENCIA     >> $INTELIGENCIA"
    echo -e "PUNTOS GANADOR   >> $PUNTOS"
    echo -e "JUGADOR GANADOR  >> $JUGADOR_GANADOR"
    echo -e "PUNTOS           >> $PUNTOS_PARTIDA_FINAL"

    if ! [[ -w $FICHEROLOG ]] && [[ -a $FICHEROLOG ]]
    then
        echo -e "ERROR: No se han podido guardar los datos de la partida en $FICHEROLOG por falta de permisos.\n"
    elif ! [[ -s $FICHEROLOG ]]
    then
        echo -e -n "$(date +"%d%m%y")|$(date +"%H:%M")|$JUGADORES|$(($SECONDS-$TIEMPO))|$NUM_RONDAS|$INTELIGENCIA|$PUNTO|$JUGADOR_GANADOR|$PUNTOS_PARTIDA_FINAL" >> $FICHEROLOG
    else 
        echo -e -n "\n$(date +"%d%m%y")|$(date +"%H:%M")|$JUGADORES|$(($SECONDS-$TIEMPO))|$NUM_RONDAS|$INTELIGENCIA|$PUNTO|$JUGADOR_GANADOR|$PUNTOS_PARTIDA_FINAL" >> $FICHEROLOG
    fi

    pulseParaContinuar
    menuInicioPrograma
}


# ========= ESTADÍSTICAS ========= #
function mostrarEstadisticas {
    clear
    titulo

    # FICHERO LOG:
    # Fecha|Hora|Jugadores|Tiempo|Rondas|Inteligencia|PuntosGanador|JugadorGanador|Puntos

    if test -r $FICHEROLOG
    then
        mostrarTextoEstadisticas

        # -s -> existe y tiene tamaño mayor que cero
        if ! [[ -s $FICHEROLOG ]]
        then
            echo -e "El registro de partidas está vacío, inicia un juego para mostrar resultados."
        else
            PARTIDAS_JUGADAS_TOTAL=0   
            MEDIA_PUNTOS_GANADORES=0
            MEDIA_RONDAS_JUGADAS=0
            MEDIA_TIEMPOS_PART_JUGADAS=0
            TIEMPO_TOTAL_PART_JUGADAS=0
            PORCENTAJE=0
            MEDIA_PUNTOS_TODOS_JUGADORES=0

            declare -a SUMA_PUNTOS

            for line in $(cat $FICHEROLOG)
            do
                # Sumatorio de las partidas jugadas
                # Se podría hacer con PARTIDAS_JUGADAS_TOTAL=$(cat $FICHEROLOG | wc -l), pero no siempre funciona
                # ya que cuenta los \n existentes en el fichero y puede saltarse la última línea si no tiene
                # retorno de carro
                let PARTIDAS_JUGADAS_TOTAL=$PARTIDAS_JUGADAS_TOTAL+1

                # Sumatorio puntos maximos de las partidas
                PUNTOS_TEMP=$( echo $line | cut -f 7 -d "|")
                let MEDIA_PUNTOS_GANADORES=$MEDIA_PUNTOS_GANADORES+$PUNTOS_TEMP

                # Sumatorio rondas jugadas de las partidas
                RONDAS_TEMP=$( echo $line | cut -f 5 -d "|")
                let MEDIA_RONDAS_JUGADAS=$MEDIA_RONDAS_JUGADAS+$RONDAS_TEMP

                # Sumatorio tiempo partidas jugadas
                TIEMPO_TEMP=$( echo $line | cut -f 4 -d "|")
                let MEDIA_TIEMPOS_PART_JUGADAS=$MEDIA_TIEMPOS_PART_JUGADAS+$TIEMPO_TEMP
                let TIEMPO_TOTAL_PART_JUGADAS=$TIEMPO_TOTAL_PART_JUGADAS+$TIEMPO_TEMP

                # Sumatorio inteligencia partidas
                INTELIGENCIA_TEMP=$( echo $line | cut -f 6 -d "|")
                if [[ $INTELIGENCIA_TEMP = "1" ]]
                then
                    let PORCENTAJE=$PORCENTAJE+1
                fi

                # Sumatorio puntos de todos los jugadores
                PUNTOS_TEMP=$( echo $line | cut -f 9 -d "|")
                SUMA_PUNTOS[1]=$( echo $PUNTOS_TEMP | cut -f 1 -d "-")
                SUMA_PUNTOS[2]=$( echo $PUNTOS_TEMP | cut -f 2 -d "-")
                SUMA_PUNTOS[3]=$( echo $PUNTOS_TEMP | cut -f 3 -d "-")
                SUMA_PUNTOS[4]=$( echo $PUNTOS_TEMP | cut -f 4 -d "-" | tr -d "\r" )

                let MEDIA_PUNTOS_TODOS_JUGADORES=$MEDIA_PUNTOS_TODOS_JUGADORES+${SUMA_PUNTOS[1]}
                let MEDIA_PUNTOS_TODOS_JUGADORES=$MEDIA_PUNTOS_TODOS_JUGADORES+${SUMA_PUNTOS[2]}
                if [[ ${SUMA_PUNTOS[3]} != "*" ]]
                then
                    let MEDIA_PUNTOS_TODOS_JUGADORES=$MEDIA_PUNTOS_TODOS_JUGADORES+${SUMA_PUNTOS[3]}
                fi

                if [[ ${SUMA_PUNTOS[4]} != "*" ]]
                then
                    let MEDIA_PUNTOS_TODOS_JUGADORES=$MEDIA_PUNTOS_TODOS_JUGADORES+${SUMA_PUNTOS[4]}
                fi
            done

            ## CALCULOS
            MEDIA_PUNTOS_GANADORES=$(( $MEDIA_PUNTOS_GANADORES/$PARTIDAS_JUGADAS_TOTAL ))
            MEDIA_RONDAS_JUGADAS=$(( $MEDIA_RONDAS_JUGADAS/$PARTIDAS_JUGADAS_TOTAL ))
            MEDIA_TIEMPOS_PART_JUGADAS=$(( $MEDIA_TIEMPOS_PART_JUGADAS/$PARTIDAS_JUGADAS_TOTAL ))
            PORCENTAJE=$(( ($PORCENTAJE*100)/$PARTIDAS_JUGADAS_TOTAL ))
            MEDIA_PUNTOS_TODOS_JUGADORES=$(( $MEDIA_PUNTOS_TODOS_JUGADORES/$PARTIDAS_JUGADAS_TOTAL ))

            echo -e "Numero total de partidas jugadas                                                         >> $PARTIDAS_JUGADAS_TOTAL"
            echo -e "Media de los puntos ganadores                                                            >> $MEDIA_PUNTOS_GANADORES"
            echo -e "Media de rondas de las partidas jugadas                                                  >> $MEDIA_RONDAS_JUGADAS"
            echo -e "Media de los tiempos de todas las partidas jugadas                                       >> $MEDIA_TIEMPOS_PART_JUGADAS"
            echo -e "Tiempo total invertido en todas las partidas                                             >> $TIEMPO_TOTAL_PART_JUGADAS"
            echo -e "Porcentaje de partidas jugadas con inteligencia activada                                 >> $PORCENTAJE %"
            echo -e "Media de la suma de los puntos obtenidos por todos los jugadores en las partidas jugadas >> $MEDIA_PUNTOS_TODOS_JUGADORES"
        fi
    else
        echo -e "ERROR: No existe $FICHEROLOG o no dispone de los permisos necesarios."
    fi
}


# ========= CLASIFICACIÓN ========= #
function mostrarClasificacion {
    clear
    titulo

    # FICHERO LOG:
    # Fecha|Hora|Jugadores|Tiempo|Rondas|Inteligencia|PuntosGanador|JugadorGanador|Puntos

    if ! [[ -s $FICHEROLOG ]] || ! [[ -r $FICHEROLOG ]]
    then
        echo -e "El registro de partidas está vacío o no dispones de los permisos necesarios."
    else
        declare -a PCORTA       
        declare -a PLARGA
        declare -a MASRONDAS
        declare -a MENOSRONDAS
        declare -a MAXPUNTOSGANADOR
        declare -a MASPUNTOSTODOS

        declare -a MASPUNTOS

        mostrarTextoClasificacion

        # Inicializamos y damos valores de línea a los diferentes
        # datos mostrados dentro de 'CLASIFICACIÓN'.

        # 'head' imprimirá por defecto a la salida estándar las primeras
        # diez líneas de sus datos de entrada. Tanto las unidades de
        # impresión (líneas, bloques, bytes) como su número pueden alterarse
        # con opciones de la línea de comandos: 
        PCORTA[1]=$(head -1 $FICHEROLOG | cut -f 4 -d "|")
        PCORTA[2]=$(head -1 $FICHEROLOG)

        PLARGA[1]=$(head -1 $FICHEROLOG | cut -f 4 -d "|")
        PLARGA[2]=$(head -1 $FICHEROLOG)

        MASRONDAS[1]=$(head -1 $FICHEROLOG | cut -f 5 -d "|")
        MASRONDAS[2]=$(head -1 $FICHEROLOG)

        MENOSRONDAS[1]=$(head -1 $FICHEROLOG | cut -f 5 -d "|")
        MENOSRONDAS[2]=$(head -1 $FICHEROLOG)

        MAXPUNTOSGANADOR[1]=$(head -1 $FICHEROLOG | cut -f 7 -d "|")
        MAXPUNTOSGANADOR[2]=$(head -1 $FICHEROLOG)

        MASPUNTOSTODOS[1]=0
        MASPUNTOSTODOS[2]=$(head -1 $FICHEROLOG)

        # Recorremos cada línea del fichero
        for line in $(cat $FICHEROLOG)
        do
            CL_TIEMPO=$( echo $line | cut -f 4 -d "|")
            CL_RONDAS=$( echo $line | cut -f 5 -d "|")
            CL_MAXPUNTOS=$( echo $line | cut -f 7 -d "|")

            #
            # Partida más corta
            #
            if test $CL_TIEMPO -lt ${PCORTA[1]}
            then
                PCORTA[1]=$CL_TIEMPO
                PCORTA[2]=$line
            fi

            #
            # Partida más larga
            #
            if test $CL_TIEMPO -gt ${PLARGA[1]}
            then
                PLARGA[1]=$CL_TIEMPO
                PLARGA[2]=$line
            fi

            #
            # Partida con más rondas
            #
            if test $CL_RONDAS -gt ${MASRONDAS[1]}
            then
                MASRONDAS[1]=$CL_RONDAS
                MASRONDAS[2]=$line
            fi

            #
            # Partida menos rondas
            #
            if test $CL_RONDAS -lt ${MENOSRONDAS[1]}
            then
                MENOSRONDAS[1]=$CL_RONDAS
                MENOSRONDAS[2]=$line
            fi

            #
            # Ronda con mayor 'Puntos ganador' de configuracion
            #
            if test $CL_MAXPUNTOS -gt ${MAXPUNTOSGANADOR[1]}
            then
                MAXPUNTOSGANADOR[1]=$CL_MAXPUNTOS
                MAXPUNTOSGANADOR[2]=$line
            fi

            #
            # Calcular mas puntos hechos entre todos los jugadores
            #
            CL_PUNTOS=$( echo $line | cut -f 9 -d "|")
            MASPUNTOS[1]=$( echo $CL_PUNTOS | cut -f 1 -d "-")
            MASPUNTOS[2]=$( echo $CL_PUNTOS | cut -f 2 -d "-")
            MASPUNTOS[3]=$( echo $CL_PUNTOS | cut -f 3 -d "-")
            MASPUNTOS[4]=$( echo $CL_PUNTOS | cut -f 4 -d "-" | tr -d "\r" )

            let TOTALPUNTOS=${MASPUNTOS[1]}+${MASPUNTOS[2]}
            if [[ ${MASPUNTOS[3]} != "*" ]]
            then
                let TOTALPUNTOS=$TOTALPUNTOS+${MASPUNTOS[3]}
            fi

            if [[ ${MASPUNTOS[4]} != "*" ]]
            then
                let TOTALPUNTOS=$TOTALPUNTOS+${MASPUNTOS[4]}
            fi

            if test $TOTALPUNTOS -gt ${MASPUNTOSTODOS[1]}
            then
                MASPUNTOSTODOS[1]=$TOTALPUNTOS
                MASPUNTOSTODOS[2]=$line
            fi
        done

        # Mostramos por pantalla los resultados obtenidos
        echo -e "Partida más corta >> ${PCORTA[2]}"
        echo -e "Partida más larga >> ${PLARGA[2]}"
        echo -e "Partida con menos rondas >> ${MENOSRONDAS[2]}"
        echo -e "Partida con más rondas   >> ${MASRONDAS[2]}"
        echo -e "Partida con máximo PuntosGanador >> ${MAXPUNTOSGANADOR[2]}"
        echo -e "Partida con más puntos obtenidos por todos los jugadores >> ${MASPUNTOSTODOS[2]}"
    fi
}


# ========= CONFIGURACIÓN ========= #
function cargarFicheroConfiguracion {
    if ! test -f $CONFIG
    then
        JUGADORES=2
        PUNTOS=75
        INTELIGENCIA=1
        FICHEROLOG="./log/fichero.log"
        echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
    fi

    if test -r $CONFIG      # test 1 -eq 2 || -r -> Existe el archivo y tiene derechos de lectura 
    then
        ERROR=0

        # grep <texto-buscado> archivo a buscar
        # -f 2 -> Indicamos que queremos el segundo campo
        # -d "=" -> Delimitador del campo que queremos va precedido por =
        # tr -> translate
        # -d "\n" -> Pone un espacio en blanco donde encuentra un \n
        JUGADORES_TEMP=$(grep "^JUGADORES=" $CONFIG | cut -f 2 -d "=" | tr -d "\n" )          
        PUNTOS_TEMP=$(grep "^PUNTOSGANADOR=" $CONFIG | cut -f 2 -d "=" | tr -d "\n" )
        INTELIGENCIA_TEMP=$(grep "^INTELIGENCIA=" $CONFIG | cut -f 2 -d "=" | tr -d "\n" )
        FICHEROLOG=$(grep "^LOG=" $CONFIG | cut -f 2 -d "=")
    else
        ERROR=1
        echo -e "\nERROR: No se ha encontrado el fichero $CONFIG o no dispones de los permisos necesarios."
    fi

    if ! test -r $FICHEROLOG
    then
        ERROR=1
        echo -e "\nERROR: No se ha encontrado el fichero $FICHEROLOG o no dispones de los permisos necesarios."
    else
        FICHEROLOG="./log/fichero.log"
    fi

    if test $ERROR = 0
    then
        if [[ $JUGADORES_TEMP -lt 2 ]] || [[ $JUGADORES_TEMP -gt 4 ]]
        then
            JUGADORES=2
            echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
        else
            ERROR=0
            JUGADORES=$JUGADORES_TEMP
        fi

        if [[ $PUNTOS_TEMP -lt 50 ]]
        then
            PUNTOS=75
            echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
        else
            ERROR=0
            PUNTOS=$PUNTOS_TEMP
        fi

        if [[ $INTELIGENCIA_TEMP != 0 ]] || [[ $INTELIGENCIA_TEMP != 1 ]]
        then
            INTELIGENCIA=1
            echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
        else
            ERROR=0
            INTELIGENCIA=$INTELIGENCIA_TEMP
        fi
    fi
}

function menuCambioConfiguracion {
    SALIR_CFG=0

    while [[ $SALIR_CFG -eq 0 ]]
    do
        clear
        titulo
        echo -e "\nCONFIGURACIÓN ACTUAL"
        echo -e "\tJUGADORES: $JUGADORES"
        echo -e "\tPUNTOS GANADOR: $PUNTOS"
        echo -e "\tINTELIGENCIA: $INTELIGENCIA"
        echo -e "\tFICHERO LOG: $FICHEROLOG"

        echo -e $MENU_CFG
        echo -n "\"Configuración\". Introduzca una opción >> "
        read RESPUESTA_CFG

        case $RESPUESTA_CFG in
            1)
                cambioNumeroJugadoresConfiguracion
                ;;
            2)
                cambioPuntosGanadorConfiguracion
                ;;
            3)  
                cambioInteligenciaConfiguracion
                ;;
            4)
                cambioFicherologConfiguracion
                ;;
            s|S)
                SALIR_CFG=1
                clear
                ;;
            *)
                echo -e "\nERROR: Introduzca una opción válida."
                pulseParaContinuar
                ;;
        esac
    done
}

function cambioNumeroJugadoresConfiguracion {
    echo -e -n "\nIntroduzca nuevo valor (jugadores) >> "
    read NUEVO_JUGADORES
    if [ $NUEVO_JUGADORES -lt 2 ] || [ $NUEVO_JUGADORES -gt 4 ]
    then
        echo -e "\nERROR: Introduzca un valor dentro del rango (2-4)."
        pulseParaContinuar
    else
        JUGADORES=$NUEVO_JUGADORES
        echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
    fi
}

function cambioPuntosGanadorConfiguracion {
    echo -e -n "\nIntroduzca nuevo valor (puntos ganador) >> "
    read NUEVO_PUNTOS
    if [ $NUEVO_PUNTOS -lt 50 ]
    then
        echo -e "\nERROR: Introduzca un valor superior a 50."
        pulseParaContinuar
    else
        PUNTOS=$NUEVO_PUNTOS
        echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
    fi
}

function cambioInteligenciaConfiguracion {
    echo -e -n "\nIntroduzca nuevo valor (inteligencia) >> "
    read NUEVO_INTELIGENCIA
    if [ $NUEVO_INTELIGENCIA -lt 0 ] || [ $NUEVO_INTELIGENCIA -gt 1 ]
    then
        echo -e "\nERROR: Introduzca un valor dentro del rango (0-1)."
        pulseParaContinuar
    else
        INTELIGENCIA=$NUEVO_INTELIGENCIA
        echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
    fi
}

function cambioFicherologConfiguracion {
    echo -e -n "\nIntroduce nueva ruta fichero (fichero.log) >> "
    read NUEVO_FICHERO

    # Mediante dirname obtenemos la ruta al nuevo fichero, por ejemplo
    # dir="/from/here/to/there.txt"
    # dir="$(dirname $dir)"   -----> Obtenemos: "/from/here/to/"
    NUEVO_FICHERO_RUTA=$(dirname $NUEVO_FICHERO)
    
    if ! [[ -d $NUEVO_FICHERO_RUTA ]]
    then   
        echo -e "\nERROR: No se encontró la ruta o no dispones de los permisos necesarios."
        pulseParaContinuar
    elif ! [[ $NUEVO_FICHERO =~ ".log" ]]
    then    
        echo -e "\nERROR: El fichero debe llevar la extensión '.log'"
        pulseParaContinuar
    elif ! [[ -r $NUEVO_FICHERO ]] || ! [[ -w $NUEVO_FICHERO ]] && [[ -a $NUEVO_FICHERO ]]
    then
        echo -e "\nERROR: No dispones de permisos sobre $NUEVO_FICHERO"
        pulseParaContinuar
    else
        FICHEROLOG=$NUEVO_FICHERO
        echo -e "JUGADORES=$JUGADORES\nPUNTOSGANADOR=$PUNTOS\nINTELIGENCIA=$INTELIGENCIA\nLOG=$FICHEROLOG" > $CONFIG
    fi
}


# ========= INICIO PROGRAMA ========= #
function menuInicioPrograma {
    clear
    titulo

    cargarFicheroConfiguracion

    # Cargamos 'SALIR' con el valor 'ERROR' debido a que si se produce cualquier
    # fallo en la carga de 'config.cfg' no será necesario entrar en el menú.
    SALIR=$ERROR

    while [[ $SALIR -eq 0 ]]
    do
        clear
        titulo
        echo -e $MENU
        echo -n "\"Domino\". Elija una opción >> "
        read RESPUESTA

        case $RESPUESTA in
            m|M)
                menuCambioConfiguracion
                ;;

            j|J)
                TIEMPO=$SECONDS
                PUNTUACIONJ1=0
                PUNTUACIONJ2=0
                PUNTUACIONJ3=0
                PUNTUACIONJ4=0
                NUM_RONDA=1
                juego
                pulseParaContinuar
                ;;

            f|F)
                mostrarClasificacion
                pulseParaContinuar
                ;;

            e|E)
                mostrarEstadisticas
                pulseParaContinuar
                ;;

            s|S)
                SALIR=1
                echo -e "Saliendo..."
                pulseParaContinuar
                clear
                exit
                ;;

            *)
                echo -e "ERROR: Introduce una opción válida [M, J, F, E, S]."
                pulseParaContinuar
            esac
        done
}

function comprobarArgumentos {
    if [[ "$2" ]] || [[ "$1" && "$1" != "-g" ]]
    then
        echo -e "ERROR: Para ejecutar el programa escribe 'domino.sh [-g]'."
        exit
    elif [[ "$1" == "-g" ]]
    then
        mostrarProgramadoresTrabajo
        exit
    else 
        menuInicioPrograma
    fi
}


# EJECUTA PRIMERO
clear
titulo
comprobarArgumentos $*