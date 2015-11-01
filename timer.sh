#!/bin/sh

ESC="\033"

Usage () {
  # Name:     usage - display simple usage
  # Synopsis: usage
  cmd_name=`basename $0`
  echo "usage: ${cmd_name} <minutes>";
}

CheckOS () {
  if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
  elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    OS='Cygwin'
  else
    OS='UNKNOWN'
  fi
}

((!$#)) && echo "Please specify minutes" 1>&2 && Usage && exit 1
expr "$1" + 1 >/dev/null 2>&1
if [ $? -ge 2 ]; then
  echo "Please speficy a number" 1>&2 && Usage && exit 1
fi

CheckOS
if [ $OS == 'UNKNOWN' ]; then
  echo "($(uname)) is not supported." && exit 2
fi


sec=`expr $1 \* 60 - 3`
echo "timer start:"
[ $OS == 'Mac' ] && say Timer starts.

while [ $sec != 0 ] ; do
  sleep 1
  sec=`expr $sec - 1`
done
sec=3

until [ $sec = 0 ] ; do
  sec=`expr $sec -1`
  # BEEP!
  printf $'\a'
  printf "$sec "
  sleep 1
done

echo 'finish'

say You can eat it.
