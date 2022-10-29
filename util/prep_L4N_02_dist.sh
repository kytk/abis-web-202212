#!/bin/bash
# Script to prepare split files of L4N for distribution

if [ $# -lt 1 ]; then
  echo "Please specify ova files!"
  echo "Usage: $0 OVA"
  exit 1
fi

vm=$1

[ ! -d ${vm%.ova} ] && mkdir ~/Documents/${vm%.ova}
mv $vm ~/Documents/${vm%.ova}
cd ~/Documents/${vm%.ova}
chmod 644 $vm
openssl md5 $vm > ${vm}.md5
echo "split -n 30 -d ${vm} L4N-2204-ABIS-split-"
split -n 30 -d ${vm} L4N-2204-ABIS-split-
for f in L4N-2204-ABIS-split-*; do openssl md5 $f > ${f}.md5; done

echo "Done"

exit

####
# sftp user@ftpsite
# cd www/klab/l4n-abis
# put L4N-2204-ABIS-20221028*
# mkdir L4N-2204-ABIS-20221028-split
# cd L4N-2204-ABIS-20221028-split
# put L4N-2204-ABIS-split-*
#####

