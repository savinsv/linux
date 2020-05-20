#!/bin/bash

#Удаление ранее созданных пользователей, группы и каталога
sudo userdel -r user1 2> /dev/null
sudo userdel -r user2 2> /dev/null
sudo groupdel developer 2> /dev/null
sudo rm -fr /share 2> /dev/null

