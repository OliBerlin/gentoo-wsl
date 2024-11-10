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
