#!/bin/bash
if [ ! $pooid ]; then
	read -p "Enter your PooId: " pooid
	echo 'export pooid='${pooid} >> $HOME/.bash_profile
fi
echo -e '\n\e[45mYour PooId:' $pooid '\e[0m\n'
sleep 2
if [ ! $amount ]; then
	read -p "Enter your stake amount: " amount
	echo 'export amount='${amount} >> $HOME/.bash_profile
fi
echo -e '\n\e[45mYour stake amount:' $amount '\e[0m\n'
sleep 2
if [ ! $mnemonic ]; then
	read -p "Enter your mnemonic: " mnemonic
	echo 'export mnemonic='${mnemonic} >> $HOME/.bash_profile
fi
echo -e '\n\e[45mYour mnemonic:' $mnemonic '\e[0m\n'
echo y | sudo apt update
echo y | sudo apt install git
echo y | sudo apt install nano
echo y | sudo apt install yarn
echo y | sudo apt install curl
sudo y | apt remove cmdtest
echo y | sudo apt remove yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
echo y | apt-get update
echo y | apt-get install yarn -y
git clone https://github.com/kyve-org/kysor.git
mkdir $HOME/kysor/secrets
cat <<EOF > mnemonic.txt
$mnemonic
EOF
mv mnemonic.txt $HOME/kysor/secrets
sudo mv /home/ubuntu/arweave.json $HOME/kysor/secrets
sudo mv restart.sh $HOME/kysor
sed -i.bak -e "s/initialStake: 100/initialStake: $amount/; s/poolId: 0/poolId: $pooid/" $HOME/kysor/kysor.conf.ts
cd kysor
yarn install
yarn build
nohup sh restart.sh >> restart.out &
ls
echo -e '\n\e[42mInstallation completed\e[0m\n'
