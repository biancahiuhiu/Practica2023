#!/bin/bash

echo "  CONFIGURARI RETEA  "
echo "1. Afisare interfete retea din sistem."
echo "2. Verificare conectivitate cu o adresa IP." 
echo "3. Adresa IP a sistemului."

read -p "Alegeti o cifra: " cifra

case $cifra in
1) adr_ip=`ip addr show`
   echo "Adresa IP a sistemului este $adr_ip." ;;
2) read -p "Scrieti o adresa IP: " adresa
   ping $adresa ;;
3) hostname -I ;;
esac
   
