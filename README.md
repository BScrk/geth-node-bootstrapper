# GETH NODE BOOTSTRAPPER
This project is a quick **GO-ETHEREUM NODE INSTALLATION HELPER** for ubundu vps/servers.
It's is particularly suitable for deploying a node on a newly installed server from your Lunix/Mac workstation.

## AUTO-INSTALL
Make sure you have an ssh key on you local machine
Just start `bootstrap.sh` stript and follow the instructions...

## MANUAL PROCEDURE

## 1 - Deploy on a server
To manualy deploy this helper on a server, first deploy your ssh-key on it (`ssh-copy-id root@<Server_IP>`) 
and then just run `rsync -av --checksum --exclude ".git" --exclude ".DS_Store" ./* root@<Server_IP>:`

### 2 - Install the new Node
On the remote server, install the dependences:
```
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get -y install ethereum htop fail2ban
```

And create an ethereum user:
```
adduser --disabled-password --gecos ethnode
mkdir /home/ethnode/.ssh
cp -fr .ssh/authorized_keys /home/ethnode/.ssh/
chown -R ethnode:ethnode /home/ethnode/.ssh
chmod 700 /home/ethnode/.ssh
```
Or use the all-in-one script `./install_node.sh`



### Start the node
Start a mainnet node with following command on a screen
```
geth --syncmode "light" --rpc --rpcapi db,eth,net,web3,personal \
     --cache=1024  --rpcport 7000 --rpccorsdomain "*" --maxpeers "50" \
     --datadir="/home/ethnode/.ethereum_mainnet"  \
     console 2> /home/ethnode/geth_mainnet.log
```
Or use the all-in-one script `./start_mainnet.sh`

Same procedure for a testnet node :
```
geth --testnet --syncmode "light" --port 0 --rpc --rpcapi db,eth,net,web3,personal  \
     --cache=1024 --rpcport 7001 --rpccorsdomain "*" --maxpeers "50"  \
     --datadir="/home/ethnode/.ethereum_testnet"  \
     console 2> /home/ethnode/geth_testnet.log
```
Or use the all-in-one script `./start_testnet.sh`


### Connect to the geth console
Attach the geth mainnet or testnet screen to your terminal session: `screen -x [testnet|mainnet]`
Or use the all-in-one script `./connect_[testnet|mainnet].sh`


## Import a Wallet (mainnet or testnet)
To deploy/use write fonctions of your(s) smart contract(s), first import the wallet: `personal.importRawKey("<PRIVATE KEY>","<PASSPHRASE>");`

# License
This helper was initially made for my personnal use only, but I've decided to share it to the community.
So, for sure it's not perfect at all, and it's provided AS-IS without any warranties/support of any kind.
**Please use at your own risk.**
Feel free to fork & improve ;)
