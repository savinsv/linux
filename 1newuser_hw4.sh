#!/bin/bash

#1 Создать пользователя, обладающего возможностью выполнять действия от имени суперпользователя.

newuser=$1
#Проверяем имя нового пользователя, возможно такой уже есть
#sudo cat /etc/passwd | grep $newuser > /dev/null

if [[ `grep $newuser /etc/passwd > /dev/null` == 0 ]]
	then
		echo "Пользователь с таким именем уже существует"
	else
		#Создаем нового пользователя, добавляя его сразу в группу sudo
		sudo useradd -m -G sudo -s /bin/bash $newuser
		if [[ $? == 0 ]]
			then
				echo "Пользователь "${newuser}" успешно создан."
			else
				echo "Ошибка создания нового пользователя "${newuser}
		fi
fi
