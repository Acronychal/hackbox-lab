#!/bin/bash
# created by : acronychal
# utility to download vulnerable VM hosts vulnhub.com. 
# version 1
#Sample Vulnhub link
#https://download.vulnhub.com/hackerkid/Hacker_Kid-v1.0.1.ova

# variables
STORAGE="local-lvm"

# Prompt the user to select the VM size
echo "Please select VM size:"
echo "SM 2 Cores & 2gb RAM | MD 4 Cores & 4gb RAM | LG 8 Cores & 8gb RAM"
read -p "Enter VM size : " CHOICE

# Define the options and corresponding sizes
SM=("2" "2048")
MD=("4" "4096")
LG=("8" "8192")

# Validate the user's choice and assign the size variables
case "$CHOICE" in
    "SM")
        CORES="${SM[0]}"
        RAM="${SM[1]}"
        ;;
    "MD")
        CORES="${MD[0]}"
        RAM="${MD[1]}"
        ;;
    "LG")
        CORES="${LG[0]}"
        RAM="${LG[1]}"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Print the selected VM size variables
echo "Selected VM size: cores = $CORES, RAM = $RAM"
## CHECKPOINT > script breaks if user enters lowercase size. 
# Prompt the user for additional parameters
read -p "VM Name : " VM_NAME
read -p "VM ID : " VM_ID
read -p "VLAN TAG : " VLANTAG
read -p "Vulnhub URL : " VULN_URL

## CHECKPOINT > prints selections before building
echo "VM Parameters : $VM_NAME,$VMID,$VLANTAG,$CORES,$RAM,$VULN_URL"
echo -e "\n        press ENTER to build\n"
read

# create vm. 
qm create $VM_ID --cores $CORES \
--name $VM_NAME \
--net0 model=virtio,bridge=vmbr500,tag=$VLANTAG \
--storage $STORAGE \
--memory $RAM

# setup workbench
mkdir -p /tmp/vulnbench

# download image, process and import.
wget -q -O /tmp/vulnbench/vulnhub.ova $VULN_URL
tar xvf /tmp/vulnbench/vulnhub.ova -C /tmp/vulnbench/

# find vmdk file in source directory
VMDK_FILE=$(find /tmp/vulnbench -name "*.vmdk" -type f)

# check if vmdk file exists
if [ -z "$VMDK_FILE" ]; then
    echo "Error: No .vmdk file found in the source directory."
    exit 1
fi

# import disk
qm importdisk $VM_ID "$VMDK_FILE" $STORAGE --format qcow2


# import & set disk
qm set $VM_ID --ide0 $STORAGE:vm-$VM_ID-disk-0
qm set $VM_ID --boot order=ide0

# Optional uncomment this to cleanup workbench
#rm -r /tmp/vulnbench
#qm start $VM_ID