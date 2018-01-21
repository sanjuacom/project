#!/bin/sh

echo 'Remind you should have installed VirtualBox and Vagrant'

#get composer:
if  [ composer > /dev/null ]; then
    echo 'Composer is installed'
else
    echo 'Composer is not installed.....'
    # Goto a directory you can write to:
    cd ~
    curl -s https://getcomposer.org/installer | php
    # move composer into a bin directory you control:
    sudo mv composer.phar /usr/local/bin/composer

    # double check composer works
    composer about
    # (optional) Update composer:
    sudo composer self-update
fi

#Install composer dependencies for project
cd ..
composer install
composer require --dev geerlingguy/drupal-vm
composer run-script blt-alias
source ~/.bash_profile

echo 'Going to run vagrant - PLEASE! Make attention you will have to enter your password'
vagrant plugin install vagrant-hostsupdater
vagrant up
vagrant provision

#running and installing Drupal
echo 'Running BLT VM'
blt vm
blt setup

#Command line to generate a new drupal root
echo 'Please run this command to generate a new drupal root user drush @project.local uli'