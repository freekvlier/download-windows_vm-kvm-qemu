#!/bin/bash

# Define the location where the resulting file should be stored
# Pass the desired path as the first argument to the script
RESULTING_PATH=$1

# Ensure the resulting path argument is provided
if [ -z "$RESULTING_PATH" ]; then
  echo "Please provide the path for the resulting file as an argument."
  exit 1
fi

# Update and install required packages
echo "Updating system and installing required packages..."
sudo apt-get update && sudo apt-get install -y qemu-utils unzip

# Define download URL and zip file name
DOWNLOAD_URL="https://aka.ms/windev_VM_vmware"
ZIP_FILE="windows_vmware.zip"

# Download the Windows VMware image
echo "Downloading Windows VMware image..."
wget $DOWNLOAD_URL -O $ZIP_FILE

# Find the VMDK file name inside the zip
VMDK_FILE=$(unzip -l $ZIP_FILE | grep -o '\S*\.vmdk$')
if [ -z "$VMDK_FILE" ]; then
  echo "No VMDK file found in the zip archive."
  exit 1
fi

# Extract only the VMDK file from the zip archive
echo "Extracting VMDK file from the downloaded image..."
unzip $ZIP_FILE $VMDK_FILE

# Extract the base name of the VMDK file without the extension
BASE_NAME=$(basename $VMDK_FILE .vmdk)

# Define the name of the QEMU image based on the VMDK file base name
QEMU_IMAGE="${BASE_NAME}.qcow2"

# Convert the VMware image to QEMU/KVM format
echo "Converting VMware image ($VMDK_FILE) to QEMU/KVM format ($QEMU_IMAGE)..."
qemu-img convert -O qcow2 $VMDK_FILE $QEMU_IMAGE

# Move the resulting QEMU image to the specified location
echo "Moving resulting image to ${RESULTING_PATH}/${QEMU_IMAGE}..."
mv $QEMU_IMAGE "${RESULTING_PATH}/${QEMU_IMAGE}"

# Clean up: remove the zip and extracted VMDK file
echo "Cleaning up..."
rm $ZIP_FILE
rm $VMDK_FILE

echo "Conversion complete! The QEMU image is located at ${RESULTING_PATH}/${QEMU_IMAGE}"
