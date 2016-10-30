#!/bin/bash

git clone https://github.com/zcash/zcash.git
cd zcash
git checkout v1.0.0
./zcutil/fetch-params.sh

sudo apt-get -y install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake

./zcutil/build.sh -j$(nproc)

mkdir -p ~/.zcash
echo "addnode=mainnet.z.cash" >~/.zcash/zcash.conf
echo "rpcuser=username" >>~/.zcash/zcash.conf
echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.zcash/zcash.conf
echo 'gen=1' >> ~/.zcash/zcash.conf
echo 'equihashsolver=tromp' >> ~/.zcash/zcash.conf
echo "genproclimit=$(nproc)" >> ~/.zcash/zcash.conf

./src/zcashd --daemon
