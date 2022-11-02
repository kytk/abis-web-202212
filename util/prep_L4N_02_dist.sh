#!/bin/bash
# Script to prepare split files of L4N for distribution

###
splitbase="L4N-2204-ABIS-split-"
###


if [ $# -lt 1 ]; then
  echo "Please specify ova files!"
  echo "Usage: $0 OVA"
  exit 1
fi

vm=$1

cd ~/Documents
[ ! -d ${vm%.ova} ] && mkdir ~/Documents/${vm%.ova}
mv $vm ~/Documents/${vm%.ova}
cd ~/Documents/${vm%.ova}
chmod 644 $vm
openssl md5 $vm > ${vm}.md5
echo "split -n 30 -d ${vm} ${splitbase}"
split -n 30 -d ${vm} ${splitbase}
for f in ${splitbase}*; do openssl md5 $f > ${f}.md5; done

echo "Done"

exit

####
# sftp user@ftpsite
# cd www/klab/l4n-abis
# put L4N-2?04-ABIS-2022????.ova*
# mkdir L4N-2?04-ABIS-2022????-split
# cd L4N-2?04-ABIS-2022????-split
# put L4N-2?04-ABIS-split-*
#####
