#!/bin/bash

#Проверка наличия группы web и geekbrains. Если группа есть, то будет выведена информация о ней.
groups=("web" "geekbrains")

for group in ${groups[@]}; do

	grep $group /etc/group > /dev/null 2>&1
	if [[ $? == 0 ]]
	        then
        	        echo "Группа "${group}" уже существует:"
			grep ${group} /etc/group
        	else
                	sudo addgroup ${group} > /dev/null 2>&1
                	if [[ $? == 0 ]] 
				then
        	                	echo "Группа "${group}" успешно создана"
                		else
                        		echo "Ошибка создания группы "${group}"..."
                	fi
	fi
done

#Проверяем,корректируем или создаем нового пользователя rockstar

user="rockstar"
grep $user /etc/passwd > /dev/null 2>&1
if [[ $? == 0 ]]
 then
	echo "Пользователь "${user}" уже существует."
	#Проверка uid пользователя
	uid=`id -u $user`
	if [[ $uid == 143 ]]
	 then
		echo "UID пользователя "${user}": "${uid}". Всё правильно."
	 else
		echo "UID пользователя "${user}": "${uid}" меняем на 143"
		sudo usermod -u 143 $user
	 fi
	#Проверка основной группы пользователя
	IFS=':' read -ra allgroups <<< `groups $user`
	ugid=(`id ${user}`)
	if [[ ${ugid[1]} == *${groups[0]}* ]]; then
			echo "Основная группа пользователя "${user}": "${groups[0]}
		else
			echo "Меняем онсновную группу пользователя "${user}" на "${groups[0]}
			sudo usermod -g ${groups[0]} ${user} > /dev/null 2>&1
			echo "Основная группа пользователя "${user}": "${groups[0]}" изменена."
	fi
	#Проверка вхождения пользователя в дополнительную группу
	if [[ ${allgroups[1]} == *${groups[1]}* ]]; then
		echo "Пользователь "${user}" включен в группу "${groups[1]}
	else
		#Включаем пользователя в нужную группу
		sudo usermod -G ${groups[1]} ${user} > /dev/null 2>&1
		echo "Пользователь "${user}" включен в группу "${groups[1]}
	fi
 else
	echo "Пользователя "${user}" не существует. Создадим его."
	sudo useradd -m -u 143 -g ${groups[0]} -G ${groups[1]} -s /bin/bash -p $(openssl passwd ${user}) ${user} 
	echo $(id ${user})
fi
