#/bin/bash
groupadd windows-mounts
echo "Username: "
read username
useradd -m wheel,audio,users,windows-mounts -s /bin/bash $username
echo "$username's passwort: "
passwd $username


systemd-machine-id-setup
systemd-firstboot --prompt

# Customzing portage
nativecpu=`gcc -mtune=native -Q --help=target|grep '  -mtune=' | sed 's/  -mtune=//'| awk '{print $NF}'`
sed -i "s/-O2/-O2 -march=$nativecpu/g" make.conf #/etc/portage/make.conf
echo 'VIDEO_CARDS="d3d12"' >> /etc/portage/make.conf
emerge --ask --oneshot app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
emerge --depclean app-portage/cpuid2cpuflags

# Setting timezone
ln -sf /usr/share/zoneinfo/Europe/Berlin  /etc/localtime

# Customizing locale-gen
cd /etc
wget https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/locale.gen
locale-gen
eselect locale list
read localesetting
eselect locale set localesetting

# Some wsl-stuff
cd /etc
wget https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/wsl.conf
groupid=`getent group windows-mounts | cut -d: -f3`
sed -i "s/uid=1000,gid=1000/gid=$groupid/g" wsl.conf
sed -i "s/default = nobody/default = $username/g" wsl.conf