#!/bin/bash

read -p "Scrieti calea catre un fisier: " fis
	if [[ -e $fis ]]
	then
	echo "Fisierul $fis exista."
		if [[ -f $fis ]]
		then
		echo "Este un fisier regulat."
			echo "  CONTINUT FISIERE  "
			echo "1. Numarul de cuvinte din fisier."
			echo "2. Verificare daca fisierul este gol."
			echo "3. Verificare existenta numere."
			
			read -p "Alegeti o cifra: " cifra
			
			case $cifra in 
			1) nr_cuv=`wc -w < $fis`
			   echo "Fisierul contine $nr_cuv cuvinte." ;;
			2) if [[ -s "$fisier" ]]
			   then
			   	echo "Fisierul este gol."
			   else
			   	echo "Fisierul nu este gol."
			   fi ;;
			3) numere=`egrep -o "\b[0-9]*" $fis | wc -w`
			   if [[ $numere ]]
			   then 
			   	echo "Fisierul $fis contine $numere numere."
			   else
			   	echo "Fisierul $fis Nu contine numere."
			   fi ;;
			esac
		fi
		
		if [[ -d $fis ]]
		then
			echo "Este un director."
			echo "  CONTINUT DIRECTOARE  "
			echo "1. Verificare daca este gol."
			echo "2. Numarul de fisiere din director."
			echo "3. Numarul de inode-uri."
			echo "4. Numarul de legaturi."
			echo "5. Data cand a fost creat directorul."
			
			read -p "Alegeti o cifra: " cifra
			
			case $cifra in 
			1) if [[ -z $fis ]]
			   then
			   	echo "Directorul $fis este gol."
			   else
			   	echo "Directorul $fis nu este gol."
			   fi ;;
			2) nr=`ls -l $fis | wc -l`
			   nr_fis=$((nr-1))
			   echo "Directorul $fis are $nr_fis fisiere." ;;
			3) inodes=`ls -lid $fis | cut -f1 -d" "` 
			   echo "Directorul are $inodes inode-uri." ;;
			4) legaturi=`ls -lid $fis | cut -f3 -d" "`
			   echo "Directorul are $legaturi legaturi." ;;
			5) data=`stat -c %w $fis`
			   echo "Directorul $fis a fost creat $data." ;;
			esac
		fi
	else
		echo "Fisierul $fis NU exista." 
	fi
	
