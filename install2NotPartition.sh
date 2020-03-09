#!/usr/bin/env bash

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

