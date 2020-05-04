ДЗ 1

1.  Установлено на debian virtualBox и KVM
1.a Установлено на Windows 10 hyper-v компоненты
1.b Установлена ubuntu 18.04.4 Desktop
    после установки обновлены пакеты:
    sudo apt update && sudo apt upgrade -y
2.  Установлены средства интеграции на VirtualBox
    sudo apt install -y gcc make perl
    sudo apt install -f -y build-essential dkms linux-headers-generic
2.a В hyper-v изменили протокол подключения к гостевой ОС
Найденные решения не работают
3  Установлен openssh-server
