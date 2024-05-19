#!/bin/bash

origin=/home/alumno
destination=/home/alumno/backups
log_file=/home/alumno/backups/backups.log
dir_cron=/home/alumno/crony
crontab_files_by_user=/home/alumno/crony/programas.txt
recovery_file=/home/alumno/recovery



function realizar_backup() {
       echo "Menu 1"
            echo -n "direccion del directorio: "
            read directory_path

            # Check if the directory exists
        if [ ! -d "$origin/$directory_path" ]; then
                echo "Error: direccion del directorio invalido."
                echo "Error: direccion del directorio invalido $(date '+%Y/%m/%d %H:%M')  ." >> "$log_file"
                sleep 2
               continue


        else

                 echo "quieres seguir(y/n)?"
            read confirmacion

            if [ "$confirmacion" == "y" ]; then
                # Create /backups directory if it doesn't exist
                mkdir -p $destination

                # Get the base name of the directory
                dir_name=$(basename "$directory_path")

                # Generate backup file name
                backup_file="$dir_name-$(date +%y%m%d-%H%M).tgz"
                
                sleep 1 
                
                 # Perform the backup using tar
               tar cvzf "$destination/$backup_file" "$origin/$directory_path" 

                 sleep 1  
                
                # Log the backup information
                echo "directorio del backups $directory_path ha sido creado el $(date '+%Y/%m/%d %H:%M')."
                sleep 1
                echo "el fichero generado $(basename "$backup_file") y ocupa $(du -h "$destination/$backup_file" | cut -f1) bytes." >> "$log_file"
                sleep 3
                
            else 
            continue
                
            fi

        fi

           
           
}

function realizar_backup_crontab() {
  echo "Menu 2"
            echo -n "direccion absoluta del directorio: "
            read directory_path

            # Check if the directory exists
            if [ ! -d "$directory_path" ]; then
                echo "Error: direccion del directorio invalido."
                echo "Error: direccion del directorio invalido $(date '+%Y/%m/%d %H:%M') ." >> "$log_file"
                 sleep 2
                continue
            else


                echo -n "hora para el backup (0:00-23:59): "
                read backup_hour

                # Confirm backup scheduling
                echo "El backup se ejecutara a las  $backup_hour. lo aceptas? (y/n)"
                read confirmacion

                if [ "$confirmacion" == "y" ]; then
                
                mkdir -p $destination

                backup_hour_procesed=$(echo $backup_hour | sed 's/:/ /g'| awk '{print $2, $1}'  )
                






                # Get the base name of the directory
                dir_name=$(basename "$directory_path")

                # Generate backup file name
                backup_file="$dir_name-$(date +%y%m%d-%H%M).tgz"
                sleep 1 
                
                
            
               echo "$backup_hour_procesed * * * "
               sleep 1



                   # Add cron job for backup
                   mkdir -p  $dir_cron 
#                   echo  " $backup_hour_procesed * * * tar cvzf  \"\$destination/\$backup_file\"   \"\$origin/\$directory_path\"  "  >> $crontab_files_by_user
                   echo "$backup_hour_procesed * * * bash $PWD/backup_cron.sh $destination/$backup_file $origin/$directory_path  $log_file $backup_file $destination" >> "$crontab_files_by_user"
                   crontab $crontab_files_by_user
                   echo hora programada del backup 
                   sleep 5
                fi


            fi
}

function recuperar_backup() {
  echo "Menu 3"
            echo "La lista de backups son:"
            ls -1f ./backups/*.tgz | xargs -n 1 basename
            echo -n "cuales de estos quieres recuperar: "
           
            read backup_to_restore
           

            # Check if the specified backup file exists
            if [ -f "./backups/$backup_to_restore" ]; then
                # Restore the content
                
                mkdir -p $recovery_file
                
                tar xzf "./backups/$backup_to_restore" -C "/$recovery_file" --strip-components=2
                echo "recuperacion completada exitosamente."
                sleep 5
            else
                echo "Error: no se encontro el fichero del backup."
                echo "Error: no se encontro el fichero del backup $(date '+%Y/%m/%d %H:%M') ." >> "$log_file"
                sleep 5
            fi
}

function salir() {
   echo "saliendo de la herramienta. Hasta la proximaaaaaa!"
   exit 0
}

while true; do
    clear
    echo "Herramienta backups para derectorios"
    echo "---------------------------"
    echo "Menu"
    echo "1) realizar backup"
    echo "2) programar backup utilizando cron"
    echo "3) restaurar el contenido del backup"
    echo "4) salir"
    echo -n "Opcion: "
    

    read choice

    case $choice in
        1)
            realizar_backup
            ;;
        2)
            realizar_backup_crontab
            ;;
        3)
           recuperar_backup
           ;;
        4)
           
           salir
           ;;

        *)
            echo "esta opcion no existe. Porfa elija otra."
            sleep 3
            ;;
    esac
done
