#!/bin/bash
#Declaración de Variables de la máquina modelo_host

NAME_HOST="modelo_host"
NUMBER_CLONES=3


#Creación de la maquina modelo_host
if [ -f "/var/lib/libvirt/images/modelo_host.qcow2" ];
then
	for i in $(seq 1 $NUMBER_CLONES);
	do
		NAME_HOST_CLONE="modelo_host_$i"
		virt-clone --original $NAME_HOST--name $NAME_HOST_CLONE --auto-clone 
	done
fi
