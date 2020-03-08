#!/usr/bin/env bash

echo "Cambio de distribución de teclado a español latino"
loadkeys la-latin1
echo "Actualización del sistema de archivos y repositorios"
pacman -Sy
echo "Comencemos a particionar el disco"
fdisk -l 
echo "Visualiza la información en /dev/sd# para crear tus particiones, por favor ingresa la ruta, nota crea particiones de tal forma que la 1 sea para filesystem y la 2 sea el área de intercambio (swap)"
read ruta
fdisk $ruta

echo "Formateando primer partición /dev/sda1"
mkfs.ext4 /dev/sda1
echo "Formateando área swap"
mkswap /dev/sda2
swapon /dev/sda2

echo "Montando particion /dev/sda1"

mount /dev/sda1 /mnt

echo "Mostrando particion montada en /mnt"
df -h
echo "Intalación de paquetes base de arch"

pacstrap /mnt base base-level

echo "Configuración de sistema particiones"

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
echo "Zona horaria"




