#!/bin/bash
# ~/bin/ediplug
# Creado 01 Dic. 2018
# v1.3

## INCLUDES ##
# Evita incluir dos veces el script de configuración.
# Sin embargo la primera vez que se ejecuta desde kodi.sh tiene que cargarlo
# La segunda vez, cuando lanza la orden 'ediplug OFF' no lo carga.
if [ -z "$CONFIGURACION" ]; then
  datos=".pi.conf";
  [[ -f $datos ]] && . $datos
  printf "Configuración: .pi.conf\n";
else
  printf "Include: $CONFIGURACION\n"
fi

#. ~/.pi.conf

## PARÁMETROS ##
# $1 = ON/OFF

## VARIABLES Y CONSTANTES ##
# No declaro esta constante porque me da un error luego al obtener el estado del enchufe en kodioff
declare -r TEXTO="Estado EDIMAX:";

## CÓDIGO ##
## -------------------------------------------------------------------------------------------------------------------
[[ -z $1 ]] && OPCION="-g" || OPCION="-s $1"
GO=`python ~/python/ediplug-py/src/ediplug/smartplug.py -H $EDIPLUG_IP -l $EDIPLUG_USUARIO -p $EDIPLUG_CLAVE $OPCION`

# $GO solo tiene valor cuando se hace una consulta del estado '-g'
[[ ! -z $1 ]] && printf "$TEXTO $1\n" && echo $1 > $EDIPLUG_ESTADO
[[ ! -z $GO ]] && printf "$TEXTO $GO\n" && echo $GO > $EDIPLUG_ESTADO