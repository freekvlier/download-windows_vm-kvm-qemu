$ Automatic Windows VM downloader for QEMU (VMware to QEMU Conversion)

## Overview

This script automates the process of downloading a Windows VMware image, converting it to a QEMU/KVM compatible format, and moving the resulting image to a specified directory. It's designed for Ubuntu systems and utilizes `qemu-img` for conversion.

## Prerequisites

- **Ubuntu or another similar Linux distribution**: The script is tailored for Ubuntu but should work on similar systems.
- **Sudo privileges**: Required for installing packages and moving files to protected directories.
- **Internet connection**: Necessary for downloading the VMware image and necessary packages.

## Installation

1. **Install Required Packages**: The script requires `qemu-utils` and `unzip`. These will be installed automatically when you run the script, but you can install them manually using:
    ```bash
    sudo apt-get update
    sudo apt-get install qemu-utils unzip
    ```

2. **Download the Script**: Clone the repository or download the script directly to your desired directory.

## Usage

To use the script, you need to provide the destination path for the converted QEMU image as an argument.

```bash
sudo ./convert_vm.sh /path/to/resulting.qcow2
```

Replace `/path/to/resulting.qcow2` with the actual path where you want the converted image to be stored.

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

## Troubleshooting

If you encounter permission issues, especially when moving the converted image to `/var/lib/libvirt/images/`, ensure that:

- You have sudo privileges.
- The target directory has the correct permissions.
- Your user is part of the necessary group (commonly `libvirt` or `kvm`).
