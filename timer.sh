#!/bin/sh


Usage () {
  # Name:     usage - display simple usage
  # Synopsis: usage
  cmd_name=`basename $0`
  echo "usage: ${cmd_name} <minutes>";
}

((!$#)) && echo "Please specify minutes" 1>&2 && Usage && exit 1
expr "$1" + 1 >/dev/null 2>&1
if [ $? -ge 2 ]; then
  echo "Please speficy a number" 1>&2 && Usage && exit 1
fi


sec=`expr $1 \* 60 -3`
echo 'start'

say Timer starts right now.

while [ $sec != 0 ] ; do
  sleep 1
  sec=`expr $sec -1`
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
