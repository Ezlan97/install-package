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
echo "2. Heroku CLI"
echo "3. Generate ssh key"
echo "4. Update & install driver"
echo "5. Update & upgrade system"
echo "6. Docker (Docker CE, Docker-compose)"
echo "Enter the package or setup number you want example: 1"

read input

# laravel
if [ $input == "1" ]; then
    echo "installing php..."
        sudo apt install -y php7.2 libapache2-mod-php7.2 php7.2-cli php7.2-common php7.2-mbstring php7.2-gd php7.2-intl php7.2-xml php7.2-mysql php7.2-zip php7.2-fpm php7.2-bcmath php7.2-curl  
        
    echo "installing mysql..."
        sudo apt install -y mysql-server

    echo "installing composer..."
        sudo apt install -y composer
    
    echo "installing nodeJS"
        sudo apt install -y nodejs
    
    echo "installing NPM"
        sudo apt install -y npm

    echo "installing valet & nginx..."
        sudo apt-get install network-manager libnss3-tools jq xsel -y
        sudo service apache2 stop
        composer global require cpriego/valet-linux
        export PATH=$PATH:~/.composer/vendor/bin
        valet install
        echo "enter domain for valet"
        read domain
        valet domain $domain

    echo "installing laravel installer..."
        composer global require laravel/installer

    echo "Done! your laravel enviroment had been setup"

# heroku cli
elif [ $input == "2" ]; then
    echo "Installing heroku cli..."
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
    echo "done! your heroku cli had been installed"

# ssh key
elif [ $input == "3" ]; then
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
elif [ $input == "4" ]; then
    echo "installing driver packages..."
        sudo ubuntu-drivers autoinstall
    echo "Done! all drivers installed"

# update package and upgrade
elif [ $input == "5" ]; then
    echo "check for update and upgrade package"
        sudo apt update && sudo apt upgrade -y
    echo "done!"

# Docker
elif [ $input == "6" ]; then
    echo "installing docker..."        
        sudo apt install -y docker.io
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo apt install -y docker-compose

    echo "done! installed docker"    
else
    echo "no match found"
fi

read -p "Want to continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ./install.sh
fi
