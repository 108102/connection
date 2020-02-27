#!/bin/bash
#developed by br@inl3ss
#the password field input don't output on screen so type carefully
#sudo chmod 755 make_connection.sh;sudo ./make_connection.sh
#variables
SSID=UIT-Student

red=`tput setaf 1`
green=`tput setaf 2`


source_dir=/etc/NetworkManager/system-connections

dest_dir=${source_dir}/${SSID}.nmconnection

#user_input
read -p 'Username: ' user
read -sp 'Password: ' pass
echo $pass
#check_file

if [[ -f "$dest_dir" ]]; then
		echo -e "${red}#Connection for ${SSID} file exist and removing ..\n"
		rm -rf $dest_dir
		echo -e "${red}#Removing done\n"
fi

#file_creation
touch $dest_dir 

echo -e "[802-11-wireless-security]\nkey-mgmt=wpa-eap\nauth-alg=open\n\n[802-11-wireless]\nssid=${SSID}\nmode=infrastructure\nsecurity=802-11-wireless-security\n\n[802-1x]\neap=peap;\nidentity=${user}\npassword=${pass}\nphase2-auth=mschapv2\n\n[ipv4]\nmethod=auto" >> $dest_dir

echo -e "${green}#There is your connection..\n"
sleep 3

while IFS= read line
do
	echo "$line"
done < "$dest_dir"

#restarting_connection
echo -e "${red}#Restarting the connection\n" 
service NetworkManager restart
echo -e "#done\n"

echo -e "${green}#Make connecting ${SSID} again!!"
