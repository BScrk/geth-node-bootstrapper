#!/bin/bash
echo
echo ">>>>> INSTALLING DEPS <<<<<"
echo
(sudo apt-get -y install software-properties-common && \
sudo add-apt-repository -y ppa:ethereum/ethereum && \
sudo apt-get update && \
sudo apt-get -y install ethereum htop fail2ban screen) || (echo " FAILED"; exit)
echo " OK"

echo
echo ">>>>> CREATING USER <<<<<"
id -u ethnode > /dev/null
if [ $? = 0 ]; then
   echo "ethnode already exists."
else
   echo "Adding ethnode user (ssh key only)...."
    adduser --disabled-password --gecos ethnode
    mkdir /home/ethnode/.ssh
    cp -fr .ssh/authorized_keys /home/ethnode/.ssh/
    chown -R ethnode:ethnode /home/ethnode/.ssh
    chmod 700 /home/ethnode/.ssh
echo " OK"
fi

echo
echo ">>>>> UPDATING SCRIPTS <<<<<"
cp start_testnet.sh  /home/ethnode/
cp start_mainnet.sh  /home/ethnode/
cp connect_mainnet.sh  /home/ethnode/
cp connect_testnet.sh  /home/ethnode/
cp -r eth_tools  /home/ethnode/
chown -R ethnode:ethnode /home/ethnode/* 
echo " OK"

echo
echo ">>>>> CLEANING <<<<<"
echo
rm start_testnet.sh
rm start_mainnet.sh
rm connect_mainnet.sh
rm connect_testnet.sh
rm install_node.sh
rm bootstrap.sh
rm README.md
rm -fr eth_tools
echo " OK"
