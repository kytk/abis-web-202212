#!/bin/bash
# Script to prepare split files of L4N for distribution

set -x


if [ $# -lt 2 ]; then
  echo "Please specify ova files and Ubuntu version!"
  echo "Usage: $0 OVA 2004|2204"
  exit 1
fi

vm=$1
ubuntuver=$2

splitbase="L4N-${ubuntuver}-ABIS-split-"

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

