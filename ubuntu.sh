#!/bin/bash

# Harden Script for Linux Box

sudo passwd root
sleep 1

# Create the .ssh directory and authorized_keys file if they don't exist
sudo mkdir -p ~/.ssh
sudo touch ~/.ssh/authorized_keys
sleep 1

sudo truncate –s 0 ~/.ssh/authorized_keys
ssh-keygen -b 8192

# Add more keys as needed

# Edit sshd_config settings
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Create a new user named Damien and set the password 'FuckYouDan#123'
sudo adduser --force-badname Damien 
sleep 15
groupmod -g 480 Damien
groupmod -g 480 Damien
# Add the user Damien to the root group (sudo) and the root group

sudo usermod -aG sudo Damien
sleep 1
sudo usermod -aG root Damien
sleep 1


echo "Damien     ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
sleep 1

# Comment out the sudo line in /etc/sudoers to disable sudo
sudo sed -i 's/^%sudo/#%sudo/' /etc/sudoers
sleep 1

# Disable write permission for /etc/sudoers file
sudo chmod -w /etc/sudoers
sleep 1

# Make /etc/sudoers immutable
sudo chattr +i /etc/sudoers
sleep 1

# Create and write to test.sh in the user's home directory
echo '#!/bin/bash

STR=1

while [ $STR -lt 1000 ]; do
    sudo mkdir /root/backups$STR
    ((STR+=1))
done' > /root/test.sh
sleep 1

# Add execute permission to test.sh
sudo chmod +x /root/test.sh
sleep 1

# Run the test.sh script with sudo
sudo ./test.sh
sleep 1

# Put the script to sleep for 30 seconds
sleep 30
sleep 1

sudo rm -rf /root/test.sh

sudo cp /etc/ssh/sshd_config /usr/bin/ls /bin/cat /bin/nano /root/backups560/

# Install Fail2Ban
sudo apt install fail2ban -y
sleep 30

# Change directory to /etc/fail2ban
cd /etc/fail2ban
sleep 1

# Copy fail2ban.conf to fail2ban.local
sudo cp fail2ban.conf fail2ban.local
sleep 1

# Copy jail.conf to jail.local
sudo cp jail.conf jail.local
sleep 1

# Install Tripwire
sudo apt install tripwire -y
sleep 45

# Add more commands here to further secure the system

# Install rkhunter
sudo apt install rkhunter -y
sleep 30

sudo apt remove telnet -y
sudo chattr +i /etc/group
sleep 1
sudo pam-auth-update --force