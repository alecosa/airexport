#..........................................................................#
#                                                                          #
#  airexport.sh versión 1.0 © 2012 Hector Alejandro Parada Blanco          #
#  Debe ser ubicado en el directorio /home/tmp.                            #
#                                                                          #
#  Genera backups y tiempo que tardan en generarse para                    #
#  bases de datos ORACLE, basándose en un archivo plano                    #
#  llamado /home/tmp/listadb el cual contiene los nombres                  #
#  de las bases de datos a salvaguardar, separadas por                     #
#  saltos de lineas.                                                       #
#                                                                          #
#  airexport.sh versión 1.0 debe ser programado en el cron del             #
#  sistema operativo GNU/Linux como usuario oracle o root.                 #
#  Ejemplo oracle: 01 01 * * 1-5 sh /home/tmp/airexport.sh                 #
#  Ejemplo root: 01 01 * * 1-5 su - oracle -c 'sh /home/tmp/airexport.sh'  #
#                                                                          #
#..........................................................................#


#!/bin/bash
cd /home/tmp

#.............................................
#
#Verificar la existencia de /home/tmp/listadb
#
#.............................................

fichero="/home/tmp/listadb"
if [ -f $fichero ]; then

#.............
#
#Leer fichero
#
#.............

while read line
do
  for x in $line
  do
  inicio=`date +%s`

  #.....................................
  #
  #Generar Backups y crear log de tiempo
  #Nota: cambie k68sat12sl por la clave 
  #de su usuario system.
  #
  #.....................................

  expdp system/k68sat12sl schemas=$x directory=TMPDIR dumpfile=$x.dmp logfile=$x.log
  fin=`date +%s`
  let tiempototal=$fin-$inicio
  echo "$x ha tardado $tiempototal segundos en generarse" >> db_saving$(date +%Y%m%d).txt
  done
done<$fichero
else
echo "No se encontro $fichero" >>db_error$(date +%Y%m%d).txt
fi
