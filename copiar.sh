#...................................................................#
#                                                                   #
#  copiar.sh versión 1.0 © 2012 Hector Alejandro Parada Blanco      #
#  Debe ser ubicado en el directorio /home/tmp.                     #
#                                                                   #
#  Crear directorio con la fecha del sistema y guardar los          #
#  backups en un disco duro portable, el cual debe ser montado      #
#  en /media/ como DDP.                                             #
#  copiar.sh versión 1.0 debe ser programado en el cron del         #
#  sistema como root.                                               #
#  Ejemplo: 01 02 * * 1-5 sh /home/tmp/copiar.sh                    #
#                                                                   #
#...................................................................#


#!/bin/bash
cd /home/tmp

#.....................................
#
#Variable fecha
#
#.....................................

fecha=`date +%Y%m%d`

#.....................................
#
#Crear directorio
#Copiar backup
#
#.....................................

mkdir /media/DDP/backup$fecha
cp -Rf /home/tmp/*.dmp /media/DDP/backup$fecha/ && cp -Rf /home/tmp/*.log /media/DDP/backup$fecha/ && cp -Rf /home/tmp/*.txt /media/DDP/backup$fecha/

#.....................................
#
#Borrar backup del equipo
#
#.....................................

rm -Rf /home/tmp/*.dmp && rm -Rf /home/tmp/*.log && rm -Rf /home/tmp/*.txt

