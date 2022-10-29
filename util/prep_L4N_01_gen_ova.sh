#!/bin/bash

# Script to export VirtualBOX OVA file
# Usage: gen_vb_ova.sh VM_Name OVA

if [ $# -lt 2 ]; then
  echo "Error: You have to specify VM_Name and OVA_filename"
  echo "Usage: $0 VM_Name OVA"
  exit 1
fi

vmname=$1
ovafname=$2
uuid=$(vboxmanage list hdds | grep -4 $vmname | head -n 1 | awk '{ print $2 }')

# compact
echo "vboxmanage modifyhd ${uuid} --compact"
vboxmanage modifyhd ${uuid} --compact

# export
echo "vboxmanage export $vmname -o ~/Documents/$ovafname"
vboxmanage export $vmname -o ~/Documents/$ovafname

echo "Done"

exit
 
