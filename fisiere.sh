#!/bin/bash

read -p "Tasteaza calea catre un fisier: " fisier
	
	if [[ -e "$fisier" ]]
	then
		echo "Fisierul $fisier exista."
		echo "  ACCES FISIERE  "
		echo "1. Tip fisier"
		echo "2. Permisiuni"
		echo "3. Dimensiunea fisierului"
		echo "4. Data si ora ultimei modificari"
		echo "5. Verificare daca fisierul este symlink"
		echo "6. Verificare grup proprietar."
	
		read -p "Alegeti o cifra: " opt
		
		case $opt in 
		1) if [[ -f "$fisier" ]]
		   then
			echo "$fisier este un fisier obisnuit."
		   elif [[ -d "$fisier" ]]
		   then
			echo "$fisier este un director."
			echo "Doriti sa aflati numarul de fisiere din director? "
			read -p "Alegeti da sau nu : " alegere
			if [[ $alegere = "da" ]]
			then
				nr=`ls -l "$fisier" |  wc -l`
				echo "Contine $nr fisiere."
			fi
		   else
			echo "$fisier este alt tip de fisier."
		   fi ;;
		2) ls -l $fisier | cut -f1 -d" "
		
		   drept_citire_u=`ls -l $fisier | cut -c2`
		   if [[ $drept_citire_u = "r" ]]
		   then
			echo "Fisierul $fisier are perimisiuni de citire pentru utilizator."
		   fi
		   
		   drept_citire_g=`ls -l $fisier | cut -c5`
		    if [[ $drept_citire_g = "r" ]]
		   then
			echo "Fisierul $fisier are perimisiuni de citire pentru grup."
		   fi
		   
		   drept_citire_o=`ls -l $fisier | cut -c8`
		    if [[ $drept_citire_o = "r" ]]
		   then
			echo "Fisierul $fisier are perimisiuni de citire pentru altii."
		   fi
		
		   drept_scriere_u=`ls -l $fisier | cut -c3`
		   if [[ $drept_scriere_u = "w" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de scriere pentru utilizator."
		   fi
		   
		    drept_scriere_g=`ls -l $fisier | cut -c6`
		   if [[ $drept_scriere_g = "w" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de scriere pentru grup."
		   fi
		   
		    drept_scriere_o=`ls -l $fisier | cut -c9`
		   if [[ $drept_scriere_o = "w" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de scriere pentru altii."
		   fi
		   
		    drept_executie_u=`ls -l $fisier | cut -c4`
		   if [[ $drept_executie_u = "x" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de executie pentru utilizator."
		   fi
		   
		    drept_executie_g=`ls -l $fisier | cut -c7`
		   if [[ $drept_executie_g = "x" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de executie pentru grup."
		   fi
		   
		    drept_executie_o=`ls -l $fisier | cut -c10`
		   if [[ $drept_executie_o = "x" ]]
		   then
		   	echo "Fisierul $fisier are perimisiuni de executie pentru altii."
		   fi
		   
		
		   if [[ -u "$fisier" ]]
		   then
			echo "Fisierul $fisier are permisiunea SUID."
		   fi
		
		   if [[ -g "$fisier" ]]
		   then
			echo "Fisierul $fisier are permisiunea SGID."
		   fi
		
		   usr=`ls -l $fisier | cut -f3 -d" "`
		   crt=`whoami`
		   if [[ $usr = $crt ]]
		   then
		   	echo "Utilizatorul curent $crt este proprietarul fisierului $fisier."
		   fi ;;
		3) file_size=`stat -c %s "$fisier"`
		   echo "Fisierul $fisier are dimensiunea $file_size." ;;
		4) mod=`stat -c %y "$fisier"`
		   echo "Ultima modificare a fisierului a fost pe data $mod." ;;
		5) if [[ -L "$fisier" ]]
		   then
		   	echo "Fisierul $fisier este symlink."
		   else
		   	echo "Fisierul $fisier NU este symlink."
		   fi ;;
		6) grup_prop=`stat -c %G $fisier`
		   echo "Grupul proprietar al fisierului $fisier este $grup_prop."
		esac
	else 
		echo "Fisierul $fisier NU exista."
	fi
	
