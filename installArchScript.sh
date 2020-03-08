#!/usr/bin/env bash


echo "Cambio de distribución de teclado a español latino"
loadkeys la-latin1
echo "Actualización del sistema de archivos y repositorios"
pacman -Sy


