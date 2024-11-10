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

### Starting Gentoo

Wherever you are in Windows, simply open a terminal and type:
```powershell
wsl -d gentoo
```

## Contributing

Improvements and contributions are welcome! Feel free to create a pull request or raise an issue.

## Licence

MIT License
Copyright (c) 2024 OliBerlin
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
