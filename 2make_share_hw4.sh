#!/bin/bash

#2 Создать группу developer, несколько пользователей, входящих в эту группу. Создать директорию для совместной работы. 
#Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы. 
#Создать в директории для совместной работы поддиректорию для обмена файлами, но чтобы удалять файлы могли только их 
#создатели.

#Создаем группу developer
sudo addgroup developer
#Создаем общую директорию DEVELOPER
sudo mkdir /share
#создаем пользователей user1 и user2
sudo useradd -m -G developer -s /bin/bash -p $(openssl passwd user1) user1
sudo useradd -m -G developer -s /bin/bash -p $(openssl passwd user2) user2
#Проверяем пользователей и наличие у них группы
less /etc/group | grep developer

#Вывод такой:
#developer:x:1001:user1,user2

#Меняем права владельца-группы на developer
sudo chown root:developer /share/

#Устанавливаем права на каталог
sudo chmod g+ws /share/

#Создаем каталог для обмена с запретом удаления файлов не владельцу
sudo mkdir /share/temp

#Добавляем запрет на удаление невладельцу
sudo chmod g+ws,o+t /share/temp

ls -la /share
