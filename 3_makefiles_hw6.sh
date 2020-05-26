#!/bin/bash

ehelp(){
cat << EOF
Creating files from the list in the specified directory.
Usage:
        $0 [-d path to folder] [file1 file2 ...]

EOF
}
if [[ $# == 0 ]] ; then
        ehelp
        exit 0
else
#       echo $@
        while [ $# -gt 0 ] ; do
#               echo $1
                if [ $1 = -d ]; then
                   if [ -d $2 ]; then
                        shift
                        fold+=("$1")
                        shift
                        continue
                  else
                        echo "The existing directory must be specified after the '-d' parameter." && exit 2
                  fi
                else
                        files+=("$1")
                        shift
                fi

        done
#       echo "путь до папки: "${fold}
        (( ${#files[@]} == 0 )) && echo "Files not specified." && exit 1
        (( ${#fold[@]} > 1 )) &&  echo "More than one destination folder is specified." && exit 2
        for i in ${files[@]} ;do
                if [[ ! -f ${fold[0]}/$i ]] ; then
                   echo "Создаем файлик "$i"."
                   touch ${fold[0]}/$i
                else
                   echo $i" есть уже такой."
                fi
        done
fi
