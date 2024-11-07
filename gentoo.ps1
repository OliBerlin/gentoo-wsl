$Check7zip = winget list 7zip.7zip
if (($Check7zip|Select-Object -Last 1).Contains("7zip.7zip")) {
    $7zipexists = $true
} else {
    $7zipexists = $false
    winget install 7zip.7zip --disable-interactivity
}

Invoke-WebRequest -Uri "https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-systemd.txt" -OutFile "latest-stage3-amd64-systemd.txt"
$URLSuffix = (Select-String -Path "latest-stage3-amd64-systemd.txt" -Pattern ".tar.xz").Line -Split(" ") | Select-Object -First 1
$FinalURL="https://distfiles.gentoo.org/releases/amd64/autobuilds/$($URLSuffix)" 
$TargetFilename = $FinalURL -Split("/") | Select-Object -Last 1
#Invoke-WebRequest -Uri $FinalURL -OutFile $TargetFilename
$7zip="$Env:ProgramFiles\7-Zip\7z.exe"
Start-Process $7zip -ArgumentList "x $TargetFilename" -Wait

$tarfile=Get-ChildItem -Filter *.tar
New-Item .\etc\profile.d -type Directory -Force
Invoke-WebRequest -Uri https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/profile.d/initialize.sh -OutFile .\etc\profile.d\initialize.sh
tar -uf $tarfile .\etc\profile.d\initialize.sh
"$Env:LocalAppdata\WSL\Gentoo"
wsl --import Gentoo "$Env:LocalAppdata\WSL\Gentoo" $tarfile --version 2
if (!$7zipexists) {
    winget uninstall 7zip.7zip
} 

