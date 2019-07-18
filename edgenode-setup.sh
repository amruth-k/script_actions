#!/bin/bash
set -e

export cdp_env_name=$1 
export sa_username=$2 
export sa_password=$3
export sa_userhome_local=/home/${sa_username}
export sa_userhome_hdfs=/user/${sa_username}
export ss_mnt_username=$4
export ss_mnt_password=$3
export ss_mnt_dir="$5"/${cdp_env_name}
export ss_win_path="$6"/${cdp_env_name}
export extract_tmp_dir=/mnt/extract_tmp

export cdp_home_dir_local=${ss_mnt_dir}
export cdp_home_dir_hdfs=${sa_userhome_hdfs}/environments/${cdp_env_name}

sudo mkdir -p ${ss_mnt_dir}

sudo mount.cifs $ss_win_path $ss_mnt_dir -o username=${ss_mnt_username},password=${ss_mnt_password},uid=$(id -u ${sa_username}),gid=$(id -g ${sa_username})
echo "mount done"

sudo chsh -s /bin/bash oozie
sudo -u oozie -H sh -c "ssh-keygen -q -N '' -f ~/.ssh/id_rsa.pub"
sudo cp /home/oozie/.ssh/id_rsa.pub /tmp/
sudo chmod ugo+r /tmp/id_rsa.pub
sudo -u ${sa_username} -H sh -c "mkdir -p ${sa_userhome_local}/.ssh; touch ${sa_userhome_local}/.ssh/authorized_keys; chmod 777 ${sa_userhome_local}/.ssh/authorized_keys; cat /tmp/id_rsa.pub > ${sa_userhome_local}/.ssh/authorized_keys; chmod 700 ${sa_userhome_local}/.ssh/; chmod 600 ${sa_userhome_local}/.ssh/authorized_keys"
sudo rm -rf /tmp/id_rsa.pub

hdfs dfs -mkdir -p ${cdp_home_dir_hdfs}/manifests
hadoop fs -put -f ${cdp_home_dir_local}/libs/ ${cdp_home_dir_hdfs}/
hadoop fs -touchz ${cdp_home_dir_hdfs}/manifests/tmp.txt
hdfs dfs -chown -R ${sa_username}:hadoop ${sa_userhome_hdfs}/
hadoop fs -rm -r ${cdp_home_dir_hdfs}/manifests/tmp.txt
