#!/bin/bash
#Declaración de Variables de la máquina modelo_host

NAME_HOST="modelo_host"
VCPUS_HOST=4
DISK_SIZE_HOST="size=80"
RAM_HOST=8192

   
#Creación de la maquina modelo_host
if [ -f "/iso/Fedora-Server-netinst-x86_64-43-1.6.iso" ];
then
	virt-install --name $NAME_HOST --memory $RAM_HOST --vcpus $VCPUS_HOST --disk $DISK_SIZE_HOST --location /iso/Fedora-Server-netinst-x86_64-43-1.6.iso 
fi
