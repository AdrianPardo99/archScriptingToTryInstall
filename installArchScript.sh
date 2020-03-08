#!/usr/bin/env bash


#echo "Cambio de distribución de teclado a español latino"
loadkeys la-latin1
echo "Actualización del sistema de archivos y repositorios"
pacman -Sy

git clone https://github.com/helmuthdu/aui.git

cd aui
echo "Ejecucion para seleccion de distribución de teclado y otras cosas"
sleep 1
./fifo
