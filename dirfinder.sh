#!/bin/bash

display_help() {
	echo -e "\nUso: $0 -u [URL] -w [WORDLIST]\n"
	echo "   -u           Url alvo"
	echo "   -w           Wordlist de diretórios"
	exit 1
}

dirscan() {
	echo -ne "----------------- Ataque em Andamento: -----------------\n"
	for words in $(cat $argw)
	do
	resp=$(curl -s -o /dev/null -w "%{http_code}" $argu/$words/)
	echo -ne "Testando Diretório: $argu/$words/\033[K\r"
		if [ $resp == "200" ]
                then
		echo "Diretório Encontrado --> $argu/$words/"
		fi
        done
}

OPTSTRING=":hu:w:"

while getopts ${OPTSTRING} opt;
do
	case ${opt} in
		u)
			argu=${OPTARG}
			;;
		w)
			argw=${OPTARG}
			dirscan
			;;
		h)
			display_help
			exit 0
			;;
		:)
			echo "Opção -${OPTARG} precisa de um argumento."
			display_help
			exit 1
			;;
		?)
			echo "Opção Inválida: -${OPTARG}"
			exit 1
			;;
	esac
done
