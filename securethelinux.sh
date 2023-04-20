#!/bin/bash
clear

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root."
    exit 1
fi

# Check if other security processes are running
if [ "$(pidof fail2ban)" ] || [ "$(pidof ufw)" ]; then
    echo "Other security processes are already running. Aborting."
    exit 1
fi

# Check if zenity is installed
if ! command -v zenity &> /dev/null; then
    echo -e "${RED}Zenity is not installed. Installing...${NC}"
    sudo apt-get install zenity
fi
clear

# Variables for colored output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print banner
echo -e "${YELLOW}#######################################################"
echo -e "#${BLUE}               Linux Security Script                ${YELLOW}#"
echo -e "#${BLUE}                  Created By GiuCoder               ${YELLOW}#"
echo -e "#######################################################${NC}"
echo ""

# Update the system
echo -e "${BLUE}Updating system...${NC}"
sudo apt-get update
sudo apt-get upgrade
echo -e "${GREEN}System updated!${NC}"
echo ""
clear
# Print banner
echo -e "${YELLOW}#######################################################"
echo -e "#${BLUE}               Linux Security Script                ${YELLOW}#"
echo -e "#${BLUE}                  Created By GiuCoder               ${YELLOW}#"
echo -e "#######################################################${NC}"
echo ""


# Install and configure a firewall
echo -e "${BLUE}Installing and configuring firewall...${NC}"
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
echo -e "${GREEN}Firewall installed and configured!${NC}"
echo ""
clear
# Print banner
echo -e "${YELLOW}#######################################################"
echo -e "#${BLUE}               Linux Security Script                ${YELLOW}#"
echo -e "#${BLUE}                  Created By GiuCoder               ${YELLOW}#"
echo -e "#######################################################${NC}"
echo ""


# Install and configure fail2ban
echo -e "${BLUE}Installing and configuring fail2ban...${NC}"
sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
echo -e "${GREEN}Fail2ban installed and configured!${NC}"
echo ""
clear
# Print banner
echo -e "${YELLOW}#######################################################"
echo -e "#${BLUE}               Linux Security Script                ${YELLOW}#"
echo -e "#${BLUE}                  Created By GiuCoder               ${YELLOW}#"
echo -e "#######################################################${NC}"
echo ""

# Disable root login and password authentication
echo -e "${BLUE}Disabling root login and password authentication...${NC}"
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo -e "${GREEN}Root login and password authentication disabled!${NC}"
echo ""
clear
# Print banner
echo -e "${YELLOW}#######################################################"
echo -e "#${BLUE}               Linux Security Script                ${YELLOW}#"
echo -e "#${BLUE}                  Created By GiuCoder               ${YELLOW}#"
echo -e "#######################################################${NC}"
echo ""


# Reboot system
zenity --info --title "Success" --text "LINUX HAS BEEN SECURED! LINUX WILL REBOOT SYSTEM."
sudo reboot
