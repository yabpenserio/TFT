#!/bin/bash
#Declaración de Variables de la máquina modelo_host

NAME_HOST="modelo_host"
NUMBER_CLONES=3
PRACTISE_NUMBER="2"
# Aquí se realizara la consulta de la práctica por medio de comandos de bash
echo "Ingrese el número de la práctica que desea realizar (1-7):"
while true; do
	read -N 1 -p "Número de práctica: " PRACTISE_NUMBER
	echo  # Nueva línea después de la entrada
	if [[ $PRACTISE_NUMBER =~ ^[1-7]$ ]]; then
		break
	else
		echo "Número de práctica inválido. Por favor, ingrese un número del 1 al 7."
	fi
done

# Case en bash para saber que p´ractica se va a realizar para reajustar la RAM y las VCPUS
if [ -f "/var/lib/libvirt/images/modelo_host.qcow2" ];
then
	case $PRACTISE_NUMBER in
		"1")
			# Reajuste para práctica 1
			;;
		"2")
			# Reajuste para práctica 2
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 6 --current
				virsh setmaxmem $disk 8192M --current
			done
			;;
		"3")
			# Reajuste para práctica 3
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 2 --current
				virsh setmaxmem $disk 4092M --current
			done

			;;
		"4")
			# Reajuste para práctica 4
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 2 --current
				virsh setmaxmem $disk 4092M --current
			done
			;;
		"5")
			# Reajuste para práctica 5
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 2 --current
				virsh setmaxmem $disk 4092M --current
			done
			;;
		"6")
			# Reajuste para práctica 6
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 6 --current
				virsh setmaxmem $disk 8192M --current
			done
			;;
		"7")
			# Reajuste para práctica 7
			for disk in $(ls /var/lib/libvirt/images/ | grep modelo*); 
			do
				virsh setvcpus $disk 6 --current
				virsh setmaxmem $disk 8192M --current
			done
			;;
		
		*)
			echo "Práctica no reconocida"
			;;
	esac
fi
