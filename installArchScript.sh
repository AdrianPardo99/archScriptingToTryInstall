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

pacstrap /mnt base base-devel git vim

echo "Configuración de sistema particiones"

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
echo "Zona horaria México"

ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime

echo "Sincronización del reloj"
hwclock --systohc --utc

date
echo "Configuracion de idioma y geolocalización"
echo "es_MX.UTF-8 UTF-8"
locale-gen
echo "LANG=es_MX.UTF-8" > /etc/locale.conf
export LANG=es_MX.UTF-8
echo "Escribe el hostname (es decir el nombre de la maquina)"
read hostName
echo $hostName > /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.0.1 \t${hostName}.localdomain\t${hostName}" > /etc/hosts

ip link

echo "Ingresa el nombre completo de la interfaz de red que coincide con enp*"
read interfaz

echo -e "[Match]\nname=en*\n[Network]\nDHCP=yes" > /etc/systemd/network/$interfaz.network

systemctl restart systemd-networkd
systemctl enable systemd-networkd
echo "Probando ping 8.8.8.8"
ping -c 1 8.8.8.8
echo "Instalación de grub"
yes | pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "Añadiendo carpeta de home"
mkdir /home

echo "Cambiando contraseña de root"

passwd

echo "Verificando y actualizando todo "

yes | pacman -Syu


echo "Instalación terminada.."

