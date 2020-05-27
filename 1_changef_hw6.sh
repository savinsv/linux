#!/bin/bash
somehelp(){
   cat << EOF
This is a simple program for deleting empty lines 
and (or) converting the case of the text of the selected file.

Usege: $0 [-e] [-u] [-l] [file]

Examples:
	$0 --help of -h - print this help
	$0 -e somefile.txt - delete empty lines
	$0 -u somefile.txt - convert to uppercase
	$0 -l somefile.txt - convert to lowercase
	$0 -e -u somefile.txt - delete empty lines and convert to uppercase
  
EOF
}

#echo $#

 if [[ $# == 0 ]] ; then
          somehelp
 else
	while [ $# -gt 0 ] ; do
	   case $1 in 
	   --help|-h)
		somehelp
		exit 0
	   ;;
#	   -o)
#	    output+=("$2")
#		shift
#		shift
#	   ;;
	  -*)
	   params+=("$1")
		shift
	  ;;
	  *)
	   input="$1"
	   shift
	  ;;
	 esac
	done
 fi

(( ${#params[@]} == 0 )) && echo "Text conversion parameters are not specified." && exit 1
[[  ! -f ${input} && ! -h ${input} ]] && echo "The source file is omitted or does not exist." && exit 2

for i in ${params[@]} ; do
	case $i in
	 -e)
	sed -i '/^$/d' $input
	;;
	-u)
	sed -i 's/.*/\U&/' $input
	;;
	-l)
	sed -i 's/.*/\L&/' $input
	;;
	esac
done 
