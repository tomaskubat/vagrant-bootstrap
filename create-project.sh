#!/bin/bash

declare -r BOXES_HTTP_MIRROR="http://boxes.prisedni.cz"
declare -r BOXES_CHECKSUM_FILE="sha1sum.txt"

function colorize_err() {
  while IFS='' read LINE; do
    echo -ne '\033[38;5;196m'
    echo -e "$LINE" >&2
    tput sgr0
  done
}

{
  ################################ prompt part ################################

  boxes_list=$(curl -s "$BOXES_HTTP_MIRROR/$BOXES_CHECKSUM_FILE" | cut -c 43-)
  if [ -z "$boxes_list" ]; then
    echo "-E| No available boxes on website mirror ${BOXES_HTTP_MIRROR}" >&2
    exit 1
  else
    echo "Please select vagrant box what you want to use for your project:"
    select user_selected_box in $boxes_list; do
      if [ -z "$user_selected_box" ]; then
        echo "-E| Invalid config selection..." | colorize_err
      else
        break;
      fi
    done
  fi
  echo

  echo "How many vCPUs do you want use?" 1>&2
  while true; do
    read user_num_of_vcpu
    if ! [ "$user_num_of_vcpu" -eq "$user_num_of_vcpu" ] 2>/dev/null; then
      echo "-E| vCPUs has to be a numeric without units!" | colorize_err
    else
      break
    fi
  done
  echo

  echo "How much MB of RAM do you want use?" 1>&2
  while true; do
    read user_memory
    if ! [ "$user_memory" -eq "$user_memory" ] 2>/dev/null; then
      echo "-E| Memory value has to be a numeric without units!" | colorize_err
    else
      break
    fi
    done
  echo

  echo "Do you want see Virtualbox GUI [y/n]?" 1>&2
  while true; do
    read -n 1 reply
    case $reply in
      [yY])
        user_gui="true"
        break
        ;;
      [nN])
        user_gui="false"
        break
        ;;
       *)
        echo
        echo "-E| Wrong answer :)" | colorize_err
        ;;
    esac
  done
  echo
  echo

  echo "Specify name of Vagrant box [ex. 'Vagrant-$(echo $user_selected_box | cut -d '-' -f 1)']?" 1>&2
  while true; do
    read user_box_name
    if [ -z $user_box_name ]; then
      echo "-E| Empty box name" | colorize_err
    else
      break
    fi
  done
  echo
}


# make new project bootstrap
if [ -d "new-project" ]; then
  rm -rf new-project
fi
cp -r template new-project


# customize Vagrantfile
user_box_url="$BOXES_HTTP_MIRROR/$user_selected_box"
user_box_url="${user_box_url//\//\\/}"
sed -i '' "s/<USER_BOX_URL>/${user_box_url}/g" new-project/vagrant/Vagrantfile
sed -i '' "s/<USER_BOX_NAME>/${user_box_name}/g" new-project/vagrant/Vagrantfile
sed -i '' "s/<USER_MEMORY>/${user_memory}/g" new-project/vagrant/Vagrantfile
sed -i '' "s/<USER_VCPU>/${user_num_of_vcpu}/g" new-project/vagrant/Vagrantfile
sed -i '' "s/<USER_USE_GUI>/${user_gui}/g" new-project/vagrant/Vagrantfile

echo "***************************************************"
echo
echo "Your new Vagrant project bootstrap dir was created:"
echo "\$ ls -la 'new-project'"
echo
echo "Copy this folder to your favorite project dir:"
echo "\$ mv new-project ~/Projects/new-project-name"
echo
echo "Then go to project subdir vagrant, where is "
echo "located Vagrant file and boot up your Vagrant box:"
echo "\$ vagrant up"
echo
echo "Enjoy it!"