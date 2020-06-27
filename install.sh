#!/bin/bash

#                               
#   _____ _____     _____ _____ 
#  |   __|   __|___|   __|__   |
#  |  |  |  |  |___|   __|   __|
#  |_____|_____|   |_____|_____|
#                               
#                  Version 0.0.2
#  
#  Ezlan <https://github.com/Ezlan97>
#  

echo "Choose your package"
echo "1. Laravel Enviroment (Mysql, php, Nginx, Valet, Composer, Nodejs, NPM)"
echo "2. Ionic Enviroment (NodeJS, Ionic, Cordova)"
echo "3. Heroku CLI"
echo "4. Generate ssh key"
echo "5. Update & install driver"
echo "6. Update & upgrade system"
echo "7. Docker (Docker CE, Docker-compose)"
echo "8. Development software (Visual Studio Code, Android Studio, Gitkraken, Postman, FileZilla)"
echo "9. Chat & Storage software (Discord, Whatsdesk, telegram)"
echo "Enter the package or setup number you want example: 1"

read input

# laravel
if [ $input == "1" ]; then
    echo "installing php..."
        sudo apt install php-fpm php-cli php-curl php-mysql php-curl php-zip php-gd php-mbstring php-pear -y        
    echo "installing mysql..."
        sudo apt install -y mysql-server

    echo "installing composer..."
        sudo apt install -y composer
    
    echo "installing nodeJS"
        curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
        sudo apt-get install -y nodejs

    echo "installing Npm"
        sudo apt install npm -y

    echo "installing valet & nginx..."
        sudo apt-get install network-manager libnss3-tools jq xsel -y
        sudo service apache2 stop
        composer global require cpriego/valet-linux
	export PATH=$PATH:$HOME/.config/composer/vendor/bin
        valet install
        echo "enter domain for valet"
        read domain
        valet domain $domain

    echo "installing laravel installer..."
        composer global require laravel/installer

    echo "Done! your laravel enviroment had been setup"

elif [ $input == "2" ]; then
    echo "Installing ionic framework"
    sudo apt install npm -y
    curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
    sudo apt install nodejs -y
    sudo npm install -g cordova
    sudo npm install -g ionic
    echo "Done! ionic framework has been install and ready to use"

# heroku cli
elif [ $input == "3" ]; then
    echo "Installing heroku cli..."
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
    echo "done! your heroku cli had been installed"

# ssh key
elif [ $input == "4" ]; then
    echo "enter your email"
    read email
    echo "generating your ssh key..."
        ssh-keygen -t rsa -b 4096 -C "$email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
        hash xclip &>/dev/null && echo "xclip installed, continue copy ssh key" || sudo apt install xclip
        xclip -sel clip < ~/.ssh/id_rsa.pub
    echo "done! copied your ssh key"
    echo "for later use just run this command : xclip -sel clip < ~/.ssh/id_rsa.pub"

# update driver
elif [ $input == "5" ]; then
    echo "installing driver packages..."
        sudo ubuntu-drivers autoinstall
    echo "Done! all drivers installed"

# update package and upgrade
elif [ $input == "6" ]; then
    echo "check for update and upgrade package"
        sudo apt update && sudo apt upgrade -y
    echo "done!"

# Docker
elif [ $input == "7" ]; then
    echo "installing docker..."        
        sudo apt install -y docker.io
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo apt install -y docker-compose

    echo "done! installed docker"
elif [ $input == "8" ]; then
    # echo "installing Visual Studio Code"
    #     curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg;
    #     sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg;
    #     sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list';
    #     sudo apt-get update;
    #     sudo apt-get install code;
    echo "installing Android Studio"
        sudo apt install snapd snapd-xdg-open -y
        sudo snap install android-studio --classic
    echo "installing Gitkraken"
        wget https://release.gitkraken.com/linux/gitkraken-amd64.deb -p ~/Downloads
        dpkg -i gitkraken-amd64.deb
        sudo apt install -f
    echo "installing Postman"
        sudo snap install postman
    echo "installing FileZilla"
        sudo apt install filezilla -y
	sudo apt install -f
elif [ $input == "9" ]; then
    echo "installing Discord"
        wget -O ~/Downloads/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
        sudo dpkg -i ~/Downloads/discord.deb
    echo "installing Whatsdesk"
        sudo snap install whatsdesk
    echo "installing telegram"
        sudo apt install telegram-desktop -y
	sudo apt install -f -y

else
    echo "no match found, please input the number."
fi

read -p "Want to continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ./install.sh
fi
