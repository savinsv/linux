#/bin/bash

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


#2 Создать группу developer, несколько пользователей, входящих в эту группу. Создать директорию для совместной работы. 
#Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы. 
#Создать в директории для совместной работы поддиректорию для обмена файлами, но чтобы удалять файлы могли только их 
#создатели.

#Создаем группу developer
sudo addgroup developer
#Создаем общую директорию DEVELOPER
sudo mkdir /DEVELOPER
#создаем пользователей user1 и user2
sudo useradd -m -G developer -s /bin/bash -p user1 user1
sudo useradd -m -G developer -s /bin/bash -p user2 user2
#Проверяем пользователей и наличие у них группы
less /etc/group | grep developer

#Вывод такой:
#developer:x:1001:user1,user2

#Меняем права владельца-группы на developer
sudo chown root:developer /DEVELOPER/

#Устанавливаем права на каталог
sudo chmod g+ws,o= /DEVELOPER/

ls -l / | grep DEVELOPER
