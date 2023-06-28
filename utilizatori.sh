#!/bin/bash

echo "  UTILIZATORI  "
	users=`cut -f1 -d":" /etc/passwd`
	echo "Utilizatorii existenti in acest sistem sunt: $users"
	echo "Optiuni de verificare:"
	echo "1. Verificare parola ascunsa."
	echo "2. Verificare existenta home-directory."
	echo "3. Verificare privilegii de root."
	echo "4. Daca este conectat."
	
	read -p "Alegeti o cifra: " op
	read -p "Alegeti utilizatorul: " usr
	
	case $op in
	1) tip_parola=`sudo egrep "$usr" /etc/shadow | cut -f2 -d":"`
	   if [[ "$tip_parola" != "!" ]] || [[ "$tip_parola" != "*" ]]
	   then
	   	echo "Utilizatorul $usr are parola ascunsa."
	   else
	   	echo "Utilizatorul $usr nu are parola ascunsa."
	   fi 
	   ;;
	2) home_dir=`egrep "$usr" /etc/passwd | cut -f6 -d":"`
	   if [[ $home_dir ]]
	   then
	   	echo "Exista home directory-ul utilizatorului $usr."
	   else
	   	echo "NU exista home directory-ul utilizatorului $usr."
	   fi ;;
	3) sudo_grup_utilizatori=`egrep "^sudo" /etc/group | cut -f4 -d":"`
	   IFS=',' read -ra users <<< "$sudo_grup_utilizatori"
	   for user in "${users[@]}"; do
	   if [[ $usr = $user ]]
	   then
	   	echo "Utilizatorul $usr are privilegii de root."
	   	break
	   else
	   	echo "Utilizatorul $usr nu are privilegii de root."
	   	break
	   fi 
	   done ;;
	4) user_crt=`whoami`
	   if [[ $user_crt = $usr ]]
	   then
	   	echo "Utilizatorul $usr este conectat."
	   else
	   	echo "Utilizatorul $usr NU este conectat."
	   fi ;;
	esac
