# Gentoo-WSL

A script for installing Gentoo Linux on Windows Subsystem for Linux (WSL).

## Motivation
Whilst I love using WSL, I'm not satisfied with the standard distributions available - being a devoted Gentoo enthusiast. As I frequently test various configurations and need to reset my clients often, I developed this script.

This repository is based on the official [Gentoo in WSL](https://wiki.gentoo.org/wiki/Gentoo_in_WSL) documentation.

## Prerequisites

### WSL Installation
WSL must be installed on your system.

```powershell
# Enable required Windows features
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all

# System restart required!

# WSL Installation and configuration
wsl --install --no-distribution
wsl --update
wsl --set-default-version 2
```

## How It Works

For Gentoo enthusiasts, just check the `initialize.sh` script - you'll know what it does. In essence, it downloads the latest stage3 tarball and sets up your beloved Gentoo environment.

## Contributing

Improvements and contributions are welcome! Feel free to create a pull request or raise an issue.

## Licence

MIT License
Copyright (c) 2024 OliBerlin
