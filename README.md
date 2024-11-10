# gentoo-wsl

Requirements:
Powershell 7 must be installed and scripting enabled:
winget install Microsoft.PowerShell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

wsl has to be already installed:
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --install  --no-distribution
wsl --update
wsl --set-default-version 2

The Script installs temporally 7zip to unzip the latest systemd-tar from gentoo.
After decompressing the xz-File, it will include the initialize.sh-Script into /etc/profile.d to do some stuff after installing gentoo.
The script will de deleted after running.

