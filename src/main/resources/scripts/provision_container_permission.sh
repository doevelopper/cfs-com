#!/bin/bash

set -o errexit
set +o nounset
set -o pipefail

# Check if any values are blank and set defaults as needed
if [[ -z $USER_ID || $USER_ID == 0 ]]; then
  USER_ID=1100
fi
if [[ -z $USER || "$USER" -eq "root" ]]; then
  USER="geuser"
fi
if [[ -z $GROUP_ID || $GROUP_ID == 0 ]]; then
  GROUP_ID=1100
fi
if [[ -z $GROUP || "$GROUP" -eq "root" ]]; then
  GROUP="geusers"
fi

echo "Starting container uid=${USER_ID}(${USER}) gid=${GROUP_ID}(${GROUP})..."

if [ ! $(getent group $GROUP_ID) ]; then
  # add if the group does not exist
  groupadd --gid $GROUP_ID $GROUP
fi

export HOME=/home/$USER

mkdir -p $HOME
if [ ! $(getent passwd $USER_ID) ]; then
  # add if the user does not exist
  useradd --shell /bin/bash -o --uid $USER_ID --gid $GROUP_ID $USER --home $HOME

  # adduser $USER sudo
  # Allow user no password sudo access
  echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
else
  # probably should check to see if the user (by uid) is in the group (by gid) and if not add
  :
fi
chown $USER_ID:$GROUP_ID $HOME

cd $HOME
chown -R $USER:$GROUP /home/$USER
exec /usr/local/bin/su-exec $USER "$@"

