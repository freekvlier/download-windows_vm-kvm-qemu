
# Automatic Windows VM Downloader for QEMU (VMware to QEMU Conversion)

## Overview

This script, `download_windows_vm.sh`, automates the process of downloading a Windows VMware image, converting it to a QEMU/KVM compatible format, and moving the resulting image to a specified directory. It's designed for Ubuntu systems and utilizes `qemu-img` for conversion.

## Prerequisites

- **Ubuntu or another similar Linux distribution**: The script is tailored for Ubuntu but should work on similar systems.
- **Sudo privileges**: Required for installing packages and moving files to protected directories.
- **Internet connection**: Necessary for downloading the VMware image and necessary packages.

## Installation

**Install Git**: Before cloning the repository, ensure you have Git installed. If not, install it using the following command:

```bash
sudo apt-get update
sudo apt-get install git
```

**Download the Script**: Clone the repository or download the script directly to your desired directory using the following command:

```bash
git clone https://github.com/freekvlier/download-windows_vm-kvm-qemu.git
```

## Usage

The script should be provided with the destination path for the converted QEMU image. The default location for QEMU images is typically `/var/lib/libvirt/images/`. Use the script as follows:

```bash
sudo ./download_windows_vm.sh /var/lib/libvirt/images/
```

Replace the path with your specific desired destination if it differs from the default.

### Parameters

- **Resulting Path**: The first (and only) argument you need to provide is the path where the resulting QEMU image will be stored.

## Features

- **Automated Download**: Downloads the specified VMware image from the provided URL.
- **Extraction**: Unzips the downloaded VMware image.
- **Conversion**: Converts the VMware image to a QEMU/KVM compatible `.qcow2` format.
- **File Cleanup**: Removes all intermediate files, leaving only the converted QEMU image.

## Important Notes

- Ensure you have sufficient permissions to run the script and write to the destination directory.
- Run the script in a controlled environment first to confirm it behaves as expected.
- Always be cautious when running scripts with `sudo` or as a root user.

## Post-Installation: Installing Virtio Drivers and QEMU Guest Agent

After the Windows VM is set up, you'll need to install Virtio drivers and the QEMU guest agent to ensure optimal performance and functionality. These can be obtained from the following URL:

```text
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
```

**Steps to Install Virtio Drivers:**

1. Download the Virtio drivers ISO from the link above.
2. Mount the `.iso` file to your VM as a virtual CD/DVD.
3. Inside the VM, navigate to the mounted CD/DVD drive.
4. Run the appropriate executable files to install the Virtio drivers.
5. Follow the on-screen instructions to complete the installation.

**Note**: The QEMU guest agent is also included in this ISO and can be installed for enhanced performance and management features.

## Troubleshooting

- **VM crashes with a blue screen error ("thread exception not handled")**: This issue may arise due to CPU configuration. Try setting the CPU model to "hypervisor default" instead of "host passthrough".
  
- **Permission Issues**: If you encounter permission issues, especially when moving the converted image to `/var/lib/libvirt/images/`, ensure that:
    - You have sudo privileges.
    - The target directory has the correct permissions.
    - Your user is part of the necessary group (commonly `libvirt` or `kvm`).

- **Package Installation Failures**: If the script fails to automatically install required packages, you may need to install them manually. The necessary packages are `qemu-utils`, `unzip`, and `wget`. Install them using:
    ```bash
    sudo apt-get update
    sudo apt-get install qemu-utils unzip wget
    ```
