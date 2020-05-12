#/usr/sbin/bash
echo 'Создаем каталог /tmp/lesson3/permissions'
WORKDIR="/tmp/lesson3/permissions"
WORKDIR2="/tmp/lesson3"
WORKDIR3="/tmp"
mkdir -p ${WORKDIR}
RESULT=`echo $?`
if [[ $RESULT == 0 ]] 
then 
	echo 'Каталог создан'
	#
	#echo 'Создаем файл test.txt размером 4 мегабайта в созданном каталоге'
	#dd if=/dev/zero of=${WORKDIR}/test.txt bs=1M count=4
	echo 'Создаем файл test.txt с текстовым содержимым'
	echo 'С праздником Великой Победы над фашизмом!!!!' > ${WORKDIR}/test.txt
	RESULT=`echo $?`
	if [[ $RESULT == 0 ]]
	then 
		echo 'test.txt успешно создан'
		#
		echo 'Создаем жесткую ссылку test_hl.txt на файл test.txt'
		ln ${WORKDIR}/test.txt ${WORKDIR}/test_hl.txt
		echo 'Создаем символическую ссылку test_sl.txt на файл test.txt'
		ln -s ${WORKDIR}/test.txt ${WORKDIR}/test_sl.txt
		echo 'Создаем символическую ссылку в каталоге /tmp/lesson3 на файл-символическую ссылку /tmp/lesson3/permissions/test_sl.txt'
		ln -s  ${WORKDIR}/test_sl.txt ${WORKDIR2}/test_sl2.txt
		echo
		echo 'Содержимое файла test.txt'
		cat ${WORKDIR}/test.txt
		echo 
		echo 'Содержимое файла test_hl.txt'
		cat ${WORKDIR}/test_hl.txt
		echo 
		echo 'Содержимое файла test_sl.txt'
		cat ${WORKDIR}/test_sl.txt
		echo
		echo 'Содержимое файла test_sl2.txt'
		cat ${WORKDIR2}/test_sl2.txt
		echo
		echo 'Иноды файлов test*'
		ls -li ${WORKDIR}/test* && ls -li ${WORKDIR2}/test*
		echo 'Иноды файла test.txt и файла жесткой ссылки test_hl.txt совпадают, так как указывают на тот же блок данных на диске. Иноды файлов символических ссылок отличаются, так как укзавают на файл, а не на данные'
		echo
		echo 'Переносим файлы ссылок из каталога '${WORKDIR}' в каталог '${WORKDIR3}
		mv ${WORKDIR}/test_* ${WORKDIR3}
		echo 'Вывод содержимого перемещенных файлов ссылок в каталог'$WORKDIR3
		cat ${WORKDIR3}/test_*
		echo
		cat ${WORKDIR2}/test_*
		echo 'Перемещение ссылок в другое расположение не разррывает связь с данными на которые они ссылаются, если источник не меняет своего места расположения'
		echo 'Переместив файл ссылку test_sl.txt, мы разорвали ее связь с ссылкой test_sl2.txt'
		echo
		echo 'Иноды файлов с учетом текущего размещения'
		ls -li ${WORKDIR}/test* && ls -li ${WORKDIR2}/test* && ls -li ${WORKDIR3}/test*
		echo 'Удаление созданных скриптом каталогов и файлов'
		rm -r ${WORKDIR2}
	else
		echo 'Ошибка создания файла test.txt'
	fi
else
	echo 'Ошибка создния каталога'
fi
