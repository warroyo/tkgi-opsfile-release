#! /bin/bash
set -e 
iaas=$1

metadata=$(grep -rl /var/tempest/workspaces/default/metadata/ -e "name: pivotal-container-service" | head -1)
now=$(date +"%Y-%m-%d.%H:%M:%S")
cp $metadata /tmp/tkgi-metadata.yml.bak.${now}

count=$(grep -o "tkgi-override-opsfile.yml" $metadata | wc -l)
if [ $count = "4" ]; then
   echo "already modified"
   exit 0
fi


echo "modifying....."
sed -i '/^        ops_files_paths:/a\        - /var/vcap/jobs/opsfiles-add/config/tkgi-override-opsfile.yml\' $metadata

