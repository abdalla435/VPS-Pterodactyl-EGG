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

read option

if [ $option -eq 1 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
    apt update && apt upgrade -y
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
    apt remove sudo -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt upgrade -y
    curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
    chmod -R 777 /bin/systemctl
    apt install pufferpanel
    pufferpanel user add
    echo -e "${GREEN}PufferPanel installation completed!"
    echo -e "${YELLOW}Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    systemctl restart pufferpanel
    clear
    echo -e "${GREEN}PufferPanel Created & Started - PORT: ${NC}$pufferPanelPort${GREEN}"
else
    echo -e "${RED}Invalid option selected.${NC}"
fi
