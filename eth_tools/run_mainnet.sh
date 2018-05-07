#!/bin/bash
echo 'Starting Mainnet... To safely exit the screen press [ctrl-A] + D' ;
geth --syncmode "light" --rpc --rpcapi db,eth,net,web3,personal --cache=1024  --rpcport 7000 --rpccorsdomain "*" --maxpeers "50" --datadir="/home/ethnode/.ethereum_mainnet" console 2> /home/ethnode/geth_mainnet.log