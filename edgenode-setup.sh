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

touch /home/${sa_username}/script_output.txt
echo -e "cdp_env_name=${cdp_env_name}\nsa_userhome_local=${sa_userhome_local}\nsa_userhome_hdfs=${sa_userhome_hdfs}\nss_mnt_username=${ss_mnt_username}\nss_mnt_dir=${ss_mnt_dir}\nss_win_path=${ss_win_path}\ncdp_home_dir_local=${cdp_home_dir_local}\ncdp_home_dir_hdfs=${cdp_home_dir_hdfs}" >> /home/${sa_username}/script_output.txt


#sudo mkdir -p ${ss_mnt_dir}
#sudo mount -t cifs -o username=${ss_mnt_username},password=${ss_mnt_password},uid=$(id -u ${sa_username}),gid=$(id -g ${sa_username}) ${ss_win_path} ${ss_mnt_dir}
#echo "mount done"

#sudo chsh -s /bin/bash oozie
#sudo -u oozie -H sh -c "cat /dev/zero | ssh-keygen -q -N ''"
#sudo cp /home/oozie/.ssh/id_rsa.pub /tmp/
#sudo chmod ugo+r /tmp/id_rsa.pub
#sudo -u ${sa_username} -H sh -c "mkdir -p ${sa_userhome_local}/.ssh; touch ${sa_userhome_local}/.ssh/authorized_keys; chmod 777 ${sa_userhome_local}/.ssh/authorized_keys; cat /tmp/id_rsa.pub > ${sa_userhome_local}/.ssh/authorized_keys; chmod 700 ${sa_userhome_local}/.ssh/; chmod 600 ${sa_userhome_local}/.ssh/authorized_keys"
#sudo rm -rf /tmp/id_rsa.pub

#hdfs dfs -mkdir -p ${cdp_home_dir_hdfs}/manifests
#hdfs dfs -put ${cdp_home_dir_local}/libs/ ${cdp_home_dir_hdfs}/
#hdfs dfs -chown -R ${sa_username}:hadoop ${sa_userhome_hdfs}/
