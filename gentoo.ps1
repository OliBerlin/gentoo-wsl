#############################################################################
# Gentoo WSL Installation Script
# This script automates the installation of Gentoo Linux in WSL2
#############################################################################

# Check if 7zip is installed
# Uses winget to list installed packages and searches for 7zip
$Check7zip = winget list 7zip.7zip
if (($Check7zip|Select-Object -Last 1).Contains("7zip.7zip")) {
    $7zipexists = $true
} else {
    # If 7zip isn't installed, install it silently using winget
    $7zipexists = $false
    winget install 7zip.7zip --disable-interactivity
}

#############################################################################
# Download and extract the latest Gentoo stage3 tarball
#############################################################################

# Download the file containing the latest stage3 systemd tarball information
Invoke-WebRequest -Uri "https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-systemd.txt" -OutFile "latest-stage3-amd64-systemd.txt"

# Extract the tarball URL from the downloaded file
# The file contains a line with the tarball path, we extract just the path part
$URLSuffix = (Select-String -Path "latest-stage3-amd64-systemd.txt" -Pattern ".tar.xz").Line -Split(" ") | Select-Object -First 1

# Construct the complete download URL
$FinalURL="https://distfiles.gentoo.org/releases/amd64/autobuilds/$($URLSuffix)" 

# Extract the filename from the URL
$TargetFilename = $FinalURL -Split("/") | Select-Object -Last 1

# Download the stage3 tarball
Invoke-WebRequest -Uri $FinalURL -OutFile $TargetFilename

# Define path to 7zip executable
$7zip="$Env:ProgramFiles\7-Zip\7z.exe"

# Extract the downloaded .tar.xz file
Start-Process $7zip -ArgumentList "x $TargetFilename" -Wait

#############################################################################
# Prepare the initialization script
#############################################################################

# Get the extracted .tar file
$tarfile=Get-ChildItem -Filter *.tar

# Create directory structure for the initialization script
New-Item .\etc\profile.d -type Directory -Force

# Download the initialization script from GitHub
Invoke-WebRequest -Uri https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/profile.d/initialize.sh -OutFile .\etc\profile.d\initialize.sh

# Add the initialization script to the tarball
tar -uf $tarfile .\etc\profile.d\initialize.sh

#############################################################################
# Install Gentoo in WSL
#############################################################################

# Create directory for Gentoo WSL installation
mkdir "$Env:LocalAppdata\WSL\Gentoo"

# Import the Gentoo tarball into WSL
wsl --import Gentoo "$Env:LocalAppdata\WSL\Gentoo" $tarfile --version 2

#############################################################################
# Cleanup
#############################################################################

# Remove 7zip if it wasn't installed before
if (!$7zipexists) {
    winget uninstall 7zip.7zip
} 

# Remove all temporary files and directories
Remove-Item $TargetFilename
Remove-Item $tarfile
Remove-Item "latest-stage3-amd64-systemd.txt"
Remove-Item etc -Recurse
