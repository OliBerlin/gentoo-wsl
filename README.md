# Gentoo-WSL

A script for installing Gentoo Linux on Windows Subsystem for Linux (WSL).

## Motivation
Whilst I love using WSL, I'm not satisfied with the standard distributions available - being a devoted Gentoo enthusiast. As I frequently test various configurations and need to reset my clients often, I developed this script.

This repository is based on the official [Gentoo in WSL](https://wiki.gentoo.org/wiki/Gentoo_in_WSL) documentation.

## Prerequisites

### 1. WSL Installation
WSL must be installed on your system. If not yet installed, follow these steps:

```powershell
# Enable required Windows features
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all
```

**Important:** A system restart is required after this step!

```powershell
# WSL Installation and configuration
wsl --install --no-distribution
wsl --update
wsl --set-default-version 2
```

## How It Works

The script:
- Temporarily installs 7zip to extract the latest Gentoo systemd-tar archive
- Extracts the XZ file
- Incorporates the `initialize.sh` script into `/etc/profile.d` to perform various configurations post Gentoo installation
- The initialisation script is automatically removed after execution

## Installation

[Installation and usage instructions to be added]

## Troubleshooting

[Common issues and their solutions to be documented]

## Contributing

Improvements and contributions are welcome! Feel free to create a pull request or raise an issue.

## Licence

[Licence information to be added]
