

# Verificar la cantidad correcta de argumentos
if [ "$#" -ne 5 ]; then
    echo "Error: Se requieren cinco argumentos $(date '+%Y/%m/%d %H:%M') ." >> "$log_file"
    echo "Uso: $0 destino origen log_file backup_file destino $(date '+%Y/%m/%d %H:%M') ." >> "$log_file"
    exit 1
fi


destino=$1
origen=$2
log_file=$3
backup_file=$4
destino2=$5


if [ -z "$destino" ] || [ -z "$origen" ] || [ -z "$log_file" ] || [ -z "$backup_file" ] || [ -z "$destino2" ]; then
    echo "Error: Al menos una de las variables de entrada está vacía $(date '+%Y/%m/%d %H:%M') ." >> "$log_file"
    exit 1
    
    
else

tar cvzf "$destino" "$origen" 


echo "el fichero generado $(basename $backup_file) y ocupa $(du -h "$destino2/$backup_file" | cut -f1) bytes." >> "$log_file"
fi






