#!/bin/bash
clear
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
echo "
#######################################################################################
#
#                                  VPSFREE.ES SCRIPTS
#
#                           Copyright (C) 2022 - 2023, VPSFREE.ES
#
#
#######################################################################################"
echo "Select an option:"
echo "1) LXDE - XRDP"
echo "2) PufferPanel"
echo "3) Install Basic Packages"
echo "4) Install Nodejs"
read option

if [ $option -eq 1 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
    apt update && apt upgrade -y
    export SUDO_FORCE_REMOVE=yes
    apt remove sudo -y
    apt install lxde -y
    apt install xrdp -y
    echo "lxsession -s LXDE -e LXDE" >> /etc/xrdp/startwm.sh
clear
    echo -e "${GREEN}Downloading and installation completed!"
    echo -e "${YELLOW}Select RDP Port"
    read selectedPort

    sed -i "s/port=3389/port=$selectedPort/g" /etc/xrdp/xrdp.ini
clear
    service xrdp restart
    clear
    echo -e "${GREEN}RDP Created And Started on Port $selectedPort"
elif [ $option -eq 2 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
    apt update && apt upgrade -y
    export SUDO_FORCE_REMOVE=yes
    apt remove sudo -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt upgrade -y
    curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
    chmod -R 777 /bin/systemctl
    apt install pufferpanel
    clear
    echo -e "${GREEN}PufferPanel installation completed!"
    echo -e "${YELLOW}Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    echo -e "${YELLOW}Enter the username for the admin user:"
    read adminUsername
    echo -e "${YELLOW}Enter the password for the admin user:"
    read adminPassword
    echo -e "${YELLOW}Enter the email for the admin user:"
    read adminEmail

    pufferpanel user add --name "$adminUsername" --password "$adminPassword" --email "$adminEmail" --admin
    clear
    echo -e "${GREEN}Admin user $adminUsername added successfully!${NC}"
    systemctl restart pufferpanel
    clear
    echo -e "${GREEN}PufferPanel Created & Started - PORT: ${NC}$pufferPanelPort${GREEN}"
elif [ $option -eq 3 ]; then
clear
    echo -e "${RED}Downloading... Please Wait"
     apt update && apt upgrade -y
     apt install git curl wget sudo lsof iputils-ping -y
     curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
     chmod -R 777 /bin/systemctl
     clear
    echo -e "${GREEN}Basic Packages Installed!" 
    echo -e "${RED}sudo / curl / wget / git / lsof / ping"
elif [ $option -eq 4 ]; then
#!/bin/bash

echo "Choose a Node.js version to install:"
echo "1. 12.x"
echo "2. 13.x"
echo "3. 14.x"
echo "4. 15.x"
echo "5. 16.x"
echo "6. 17.x"
echo "7. 18.x"
echo "8. 19.x"
echo "9. 20.x"

read -p "Enter your choice (1-9): " choice

case $choice in
    1)
        version="12"
        ;;
    2)
        version="13"
        ;;
    3)
        version="14"
        ;;
    4)
        version="15"
        ;;
    5)
        version="16"
        ;;
    6)
        version="17"
        ;;
    7)
        version="18"
        ;;
    8)
        version="19"
        ;;
    9)
        version="20"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac
echo -e "${RED}Downloading... Please Wait"
apt remove --purge node* nodejs npm -y
apt update && apt upgrade -y && apt install curl -y
curl -sL "https://deb.nodesource.com/setup_${version}.x" -o /tmp/nodesource_setup.sh
bash /tmp/nodesource_setup.sh
apt update -y
apt install -y nodejs
clear
echo -e "${GREEN}Node.js version $version has been installed."

else
    echo -e "${RED}Invalid option selected.${NC}"
fi
