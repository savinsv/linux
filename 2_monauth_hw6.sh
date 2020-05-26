#!/bin/bash
ehelp(){
cat << EOF
A simple example of filtering auth.log by the error text value.
Usage:
        $0 [-e error text value] [-i path to auth.log]
EOF
}

if [[ $# == 0 ]] ; then
        ehelp
else
        while [ $# -gt 0 ] ; do
                case $1 in
                        -e)
                        exp=$2
                        shift
                        shift
                        ;;
                        -i)
                        input=$2
                        shift
                        shift
                        ;;
                esac
        done
fi

[[ -z exp ]] && echo "The error text was omitted." && exit 1
[[ ! -f ${input} && ! -h ${input} ]] && echo "No data file was specified." && exit 2


tail -f -n 40 ${input} | sed -En "s/^.*(sshd).*(${exp}).*(([0-9]{1,3}\.){3}[0-9]{1,3}).*$/Service: \[\1\] error: \2 from: \3/p"
