#!/bin/bash

read -p "Scrieti primul fisier: " fis1
	read -p "Scrieti al doilea fisier: " fis2
	echo "Diferentele dintre fisierele $fis1 si $fis2 sunt: "
	diff -u $fis1 $fis2
