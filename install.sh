#!/bin/bash

echo "Created by Ezlan97"

echo "Choose your package"
echo "1. Laravel Enviroment (Mysql, php, Nginx, Valet, Composer)"
echo "2. Heroku CLI"
echo "3. Generate ssh key"
echo "4. Update & install driver"
echo "5. Update & upgrade system"
echo "Enter the package or setup number you want example: 1"

read input

# laravel
if [ $input == "1" ]; then
    echo "installing mysql..."
        sudo apt install -y mysql-server

    echo "installing php..."
        sudo apt-get install php
        sudo apt-get install php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php

    echo "installing composer..."
        sudo apt install curl -y
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer
        chmod +x /usr/local/bin/composer

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

# zsh
elif [ $input == "6" ]; then
    echo "installing zsh..."
        sudo apt install zsh git-core fonts-powerline -y
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh        
        chsh -s /bin/zsh
    echo "done! install zsh"    
else
    echo "no match found"
fi

read -p "Want to continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ./install.sh
fi
