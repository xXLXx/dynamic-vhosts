#!/bin/sh

if [ "$1" == "delete" ]; then
	sudo sed -i.bak '/127.0.0.1 .* # Added by xXLXx/d' /etc/hosts
else
	hostsData=""

	sudo sed -i.bak '/127.0.0.1 .* # Added by xXLXx/d' /etc/hosts

	for folder in /Applications/MAMP/htdocs/*; do
		[ -d ${folder} ] || continue

		folderName=$(echo ${folder} | sed -e "s/\/Applications\/MAMP\/htdocs\///g")
		host="127.0.0.1 dev.${folderName}.com"
		if ! grep -r "${host}" /etc/hosts &>/dev/null; then
			hostsData+="${host} # Added by xXLXx\n"
		fi

	done
	if [ "$hostsData" ]; then
		if ! [ -z "$(tail -c 1 "/etc/hosts")" ]; then
			hostsData="\n${hostsData}"
		fi
		sudo printf "${hostsData}" >> /etc/hosts
	fi
fi