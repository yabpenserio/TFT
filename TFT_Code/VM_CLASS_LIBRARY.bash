#!/bin/bash
NAME_CONVENTION="modelo_host"
NAME_POOL="/var/lib/libvirt/images/"
EXECUTION_MONTH=$(date +%m)
EXECUTION_DAY_HOUR=$(date +%A_%H_%M)
EXECUTION_DATE=$(date +%d_%m)
#Los siguientes arrays serán almacenados en archivos de configuración para que puedan ser modificados sin necesidad de modificar el script 
FESTIVE_DAYS=("01_01" "06_01" "19_03" "01_05" "15_08" "12_10" "01_11" "06_12" "08_12" "25_12")
CANCELED_DAYS=()
GROUPS_SCHEDULE_START=("Monday_08_30" "Tuesday_08_30" "Tuesday_11_30" "Friday_10_30" "Wednesday_11_30")
GROUPS_SCHEDULE_END=("Monday_11_29" "Tuesday_11_29" "Tuesday_14_29" "Friday_13_29" "Wednesday_14_29")

function shutdown_all_vms() {
	for disk in $(ls "$NAME_POOL" | grep $NAME_CONVENTION*); 
	do
		virsh shutdown $disk
	done
}
function shutdown_vms_with_id() {
	for id in "$@"
	do
		if [ -f "/var/lib/libvirt/images/$NAME_CONVENTION_$id.qcow2" ]; then
			virsh shutdown $NAME_CONVENTION_$id.qcow2 
		fi
	done
}
function shutdown_all_except() {
	for disk in $(ls "$NAME_POOL" | grep $NAME_CONVENTION*); 
	do
		if [[ ! " $@ " =~ " $disk " ]]; then
			virsh shutdown $disk
		fi
	done
}
function start_all_vms() {
	for disk in $(ls "$NAME_POOL" | grep $NAME_CONVENTION*); 
	do
		virsh start $disk
	done
}
function start_vms_with_id() {
	for id in "$@"
	do
		if [ -f "/var/lib/libvirt/images/$NAME_CONVENTION_$id.qcow2" ]; then
			virsh start $NAME_CONVENTION_$id.qcow2 
		fi
	done
}
function start_all_except() {
	for disk in $(ls "$NAME_POOL" | grep $NAME_CONVENTION*); 
	do
		if [[ ! " $@ " =~ " $disk " ]]; then
			virsh start $disk
		fi
	done
}
function add_canceled_day() {
	CANCELED_DAYS+=("$1")
}
function remove_canceled_day() {
	CANCELED_DAYS=("${CANCELED_DAYS[@]/$1}")
}

if [ -f "/var/lib/libvirt/images/$NAME_CONVENTION.qcow2" ];
then
	if [[ ! "$EXECUTION_MONTH" -eq "06" && ! "$EXECUTION_MONTH" -eq "07" && ! "$EXECUTION_MONTH" -eq "08" ]]; 
	then
		if [[ ! " ${FESTIVE_DAYS[@]} " =~ " ${EXECUTION_DATE} " || ! " ${CANCELED_DAYS[@]} " =~ " ${EXECUTION_DATE} " &&  " ${GROUPS_SCHEDULE_START[@]} " =~ " ${EXECUTION_DAY_HOUR} "]]; 
		then
				for group in "${GROUPS_SCHEDULE_START[@]}";
				do
					if [[ "$group" == "$EXECUTION_DAY_HOUR" ]];
					then
						read -t 720 -a ids -p "Se van a iniciar las máquinas virtuales de los estudiantes, introduzca las ID´s de las máquinas de aquellos estudiantes que hayan faltado (separados por espacios): " ids
						start_all_except ("${ids[@]}")
						exit 0
					fi
				done
			
		fi
		else if [[ ! " ${FESTIVE_DAYS[@]} " =~ " ${EXECUTION_DATE} " || ! " ${CANCELED_DAYS[@]} " =~ " ${EXECUTION_DATE} " && " ${GROUPS_SCHEDULE_END[@]} " =~ " ${EXECUTION_DAY_HOUR} " ]]; 
		then
				for group in "${GROUPS_SCHEDULE_END[@]}";
				do
					if [[ "$group" == "$EXECUTION_DAY_HOUR" ]];
					then
						read -t 720 -a ids -p "Se van a apagar las máquinas virtuales de los estudiantes, introduzca las ID´s de las máquinas de aquellos estudiantes que hayan faltado (separados por espacios): " ids
						shutdown_all_except ("${ids[@]}")
						exit 0
					fi
				done
			
		fi
	fi
	
fi
