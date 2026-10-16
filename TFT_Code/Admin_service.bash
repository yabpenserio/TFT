#!/bin/bash
NAME_CONVENTION="modelo_host"
NAME_POOL="/var/lib/libvirt/"

GROUP_NAME=""
USED_ID=()
GROUP_SCHEDULE_START=()
GROUPS_SCHEDULE_END=()

#source /lib/scripts/VM_CLASS_LIBRARY.bash

#Configuracion menú
CONF_DIR="/root/VPD_CLASS"
TITULO="Administración de grupos VPD"

#Funciones auxialres menú gráfico

elegir_grupo() {
	opciones=()
	for f in "$CONF_DIR"/Grupo_*.conf; do
		opciones+=("$(basename "$f" .conf)" "")
	done
 
	whiptail --menu "Elija un grupo:" 20 40 10 "${opciones[@]}" 3>&1 1>&2 2>&3
}
 
crear_grupo() {
	whiptail --title "$TITULO" --msgbox "Aquí iría la creación del grupo." 8 50
}
 
gestionar_grupo() {
	GROUP_NAME=$(elegir_grupo) || return
	whiptail --title "$TITULO" --msgbox "Gestionando $GROUP_NAME." 8 50
}

#----------------------------------

while true; do
	opcion=$(whiptail --title "$TITULO" --menu \
		"Bienvenido al servicio de administración de los grupos de VPD.\n¿Qué desea hacer?" 15 70 3 \
		"1" "Crear nuevo grupo" \
		"2" "Gestionar grupo existente" \
		"3" "Salir" \
		3>&1 1>&2 2>&3) || break
 
	case $opcion in
		1) crear_grupo ;;
		2) gestionar_grupo ;;
		3) break ;;
	esac
done
 
clear
echo "Programa finalizado con éxito"

#----------------------------------

opciones_iniciales=("Crear nuevo grupo" "Gestionar grupo existente" "Salir")
echo "Bienvenido al servicio de administracion de los grupos de VPD. ¿Desea crear un grupo nuevo o crear uno existente?"
select opt in "${opciones_grupo[@]}";
do
	case $opt in 
		"Crear nuevo grupo")
			
			;;
		"Gestionar grupo existente")
			echo ¿Qué grupo desea gestionar?
			while True;
				do
					read -p "Introduzca número del grupo" grupo
					case $grupo in
  					 [!0-9]*) 
					 	echo "Ingrese un numero válido" 
						;;
					 [0-9]*) 
					 	if [[ -f "/root/VPD_CLASS/Grupo_$grupo.conf" ]]; 
						then
							break
						else
							echo "Grupo no encontrado, por favor ingrese un número de grupo válido."
						fi
					esac
				done
			#Recoger i
			select sub_opt1 in "Apagar VM por ID" "Encender VM por ID"  "Añadir Estudiante" "Eliminar Estudiante por ID" "Apagar Todas las VM", "Encender todas las VM" "Salir";
			do
				case $sub_opt1 in
					"Agregar ID de VM")
						read -p "Ingrese el ID de VM a agregar: " id_vm		
			
			;;
		"Salir")
			echo "Goodbye :P"
			break;;
		*)
			echo "Opción Invalida"
			;;
	esac
done

