#!/bin/bash
echo 'Starting Testnet... To safely exit the screen press [ctrl-A] + D' ;
geth --testnet --syncmode "light" --port 0 --rpc --rpcapi db,eth,net,web3,personal --cache=1024 --rpcport 7001 --rpccorsdomain "*" --maxpeers "50" --datadir="/home/ethnode/.ethereum_testnet" console 2> /home/ethnode/geth_testnet.log