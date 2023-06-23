#!/bin/bash

echo "    MENIU    "
echo "Alegeti o optiune pentru testare."
echo "1. Utilizatori"
echo "2. Acces fisiere, permisiuni"
echo "3. Verificare continut fisiere."
echo "4. Diff-uri pe fisiere"

read -p "Alegeti o cifra: " optiune

if [[ $optiune = 1 ]]
then
	echo "  UTILIZATORI  "
	echo "Optiuni de verificare:"
	echo "1. Verificare parola ascunsa."
	echo "2. Verificare existenta home-directory."
	echo "3. Verificare privilegii de root."
	echo "4. Daca este conectat."
	
	read -p "Alegeti o cifra: " op
	
	case $op in
	1) tip_parola=`sudo egrep "$1" /etc/shadow | cut -f2 -d":"`
	   if [[ "$tip_parola" != "x" ]] || [[ "$tip_parola" != "!" ]] || [[ "$tip_parola" != "*" ]]
	   then
	   	echo "Utilizatorul $1 are parola ascunsa."
	   else
	   	echo "Utilizatorul $1 nu are parola ascunsa."
	   fi 
	   ;;
	2) home_dir=`cut -f6 -d":" /etc/passwd`
	   if [[ $home_dir ]]
	   then
	   	echo "Exista home directory-ul utilizatorului $1."
	   else
	   	echo "NU exista home directory-ul utilizatorului $1."
	   fi ;;
	3) sudo_grup_utilizatori=`egrep "^sudo" /etc/group | cut -f4 -d":"`
	   IFS=',' read -ra users <<< "$sudo_grup_utilizatori"
	   for user in "${users[@]}"; do
	   if [[ $1 = $user ]]
	   then
	   	echo "Utilizatorul $1 are privilegii de root."
	   	break
	   else
	   	echo "Utilizatorul $1 nu are privilegii de root."
	   	break
	   fi 
	   done ;;
	4) user_crt=`whoami`
	   if [[ $user_crt = $1 ]]
	   then
	   	echo "Utilizatorul $1 este conectat."
	   else
	   	echo "Utilizatorul $1 NU este conectat."
	   fi ;;
	esac
fi





if [[ $optiune = 2 ]]
then

read -p "Tasteaza calea catre un fisier: " fisier
	
	if [[ -e "$fisier" ]]
	then
		echo "Fisierul $fisier exista."
		echo "  ACCES FISIERE  "
		echo "1. Tip fisier"
		echo "2. Permisiuni"
		echo "3. Dimensiunea fisierului"
		echo "4. Data si ora ultimei modificari"
		echo "5. Verificare daca este gol"
		echo "6. Verificare daca fisierul este executabil"
		echo "7. Verificare daca fisierul este symlink"
	
		read -p "Alegeti o cifra: " opt
		
		case $opt in 
		1) if [[ -f "$fisier" ]]
		   then
			echo "$fisier este un fisier obisnuit."
		   elif [[ -d "$fisier" ]]
		   then
			echo "$fisier este un director."
		   else
			echo "$fisier este alt tip de fisier."
		   fi ;;
		2) if [[ -r "$fisier" ]]
		   then
			echo "Fisierul $fisier are perimisiuni de citire."
		   fi
		
		   if [[ -x "$fisier" ]]
		   then
			echo "Fisierul $fisier are permisiuni de executare."
		   fi
		
		   if [[ -w "$fisier" ]]
		   then
			echo "Fisierul $fisier are perimisiuni de scriere."
		   fi
		
		   if [[ -u "$fisier" ]]
		   then
			echo "Fisierul $fisier are permisiunea SUID."
		   fi
		
		   if [[ -g "$fisier" ]]
		   then
			echo "Fisierul $fisier are permisiunea SGID."
		   fi
		
		   if [[ -O "$fisier" ]]
		   then
			echo  "Utilizatorul curent este proprietarul fisierului $fisier. "
		   fi ;;
		3) file_size=`stat -c %s "$fisier"`
		   echo "Fisierul $fisier are dimensiunea $file_size." ;;
		4) mod=`stat -c %y "$fisier"`
		   echo "Ultima modificare a fisierului a fost pe data $mod." ;;
		5) if [[ -s "$fisier" ]]
		   then
		   	echo "Fisierul nu este gol."
		   else
		   	echo "Fisierul este gol."
		   fi ;;
		6) if [[ -x "$fisier" ]]
		   then
		   	echo "Fisierul $fisier este executabil."
		   else
		   	echo "Fisierul $fisier NU este executabil."
		   fi ;;
		7) if [[ -L "$fisier" ]]
		   then
		   	echo "Fisierul $fisier este symlink."
		   else
		   	echo "Fisierul $fisier NU este symlink."
		   fi ;;
		esac
	else 
		echo "Fisierul $fisier NU exista."
	fi
	
fi





if [[ $optiune = 3 ]]
then
	read -p "Scrieti calea catre un fisier: " fis
	if [[ -e $fis ]]
	then
		echo "Fisierul $fis exista."
		echo "  CONTINUT FISIERE  "
		echo "1. Numarul de cuvinte din fisier."
		echo "2. Transformare propozitie corecta."
		echo "3. Verificare existenta numere."
		
		read -p "Alegeti o cifra: " cifra
		
		case $cifra in 
		1) nr_cuv=`wc -w < $fis`
		   echo "Fisierul contine $nr_cuv cuvinte." ;;
		2) sed -E "s/\b([a-z])([a-zA-Z]*)/\u\1\2/g" $fis ;;
		3) numere=`egrep -o "\b[0-9]*" $fis | wc -w`
		   if [[ $numere ]]
		   then 
		   	echo "Fisierul $fis contine $numere numere."
		   else
		   	echo "Fisierul $fis Nu contine numere."
		   fi
		esac
	else
		echo "Fisierul $fis NU exista." ;;
	fi
	
fi



























