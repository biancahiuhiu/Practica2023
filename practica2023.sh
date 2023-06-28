#!/bin/bash

echo "    MENIU    "
echo "Alegeti o optiune pentru testare."
select item in "Utilizatori" "Acces fisiere, permisiuni" "Verificare continut fisiere/directoare." "Diff-uri pe fisiere" "Configurari retea" "Exit"
do
	case $REPLY in 
	
	1) ./utilizatori.sh ;;
	
 	2) ./fisiere.sh ;;
	
	3) ./continut_fis.sh ;;

	4) ./diferente.sh ;;
	
	5) ./retea.sh ;;
	
	6) exit 0
	
	esac
done



























