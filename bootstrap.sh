#!/bin/bash
function error_exit
{
    echo "ERROR: ${1:-"Unknown Error"}" 1>&2
    exit 1
}
echo ""
echo "Welcome to Geth node bootstraper"
echo "--------------------------------"
echo -n " - Enter Ubuntu VPS/Server IP address > "
read srv_ip
if [[ -z "$srv_ip" ]]; then
  error_exit "No IP given..."
fi

echo -n " - Enter default user (default:root) > "
read user
user="${user:-root}"

echo -n " - Enter default port (default:22) > "
read ssh_port
ssh_port="${ssh_port:-22}"

read -p "Deploy ssh key (Y/n)? " -n 1 -r
echo
REPLY="${REPLY:-y}"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Deploying ssh key... on $user@$srv_ip"
  ssh-copy-id $user@$srv_ip -p $ssh_port
fi

ping -c 1 -t 1 $srv_ip >/dev/null ||  error_exit "Host $srv_ip not found"
echo "Installing rsync if needed... "
ssh $user@$srv_ip -p $ssh_port "apt-get -y install rsync" ||  error_exit "SSH connection failed ($user@$srv_ip on port $ssh_port)"

echo "Deploying project... "
rsync -av -e "ssh -p $ssh_port" --checksum --exclude ".git" --exclude ".DS_Store" ./* $user@$srv_ip: || error_exit "rsync failed"
echo "Deploying... "
ssh $user@$srv_ip -p $ssh_port "./install_node.sh"


echo -n "What do you want to start, 'mainnet' or 'testnet' (empty to just start a ssh session) ? "
read net

if [[ -z "$net" ]]; then
  ssh ethnode@$srv_ip -p $ssh_port
else
  ssh -t ethnode@$srv_ip -p $ssh_port "./start_$net.sh" 
fi
