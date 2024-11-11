#/bin/bash
# Some systemd-stuff
systemd-machine-id-setup
systemd-firstboot --prompt

# Setting timezone
ln -sf /usr/share/zoneinfo/Europe/Berlin  /etc/localtime

# Creating user and group and changing passwords
passwd
groupadd windows-mounts
read -p "Username: " username
useradd -m -G wheel,audio,users,windows-mounts -s /bin/bash $username 
passwd $username


# Customzing portage
echo "Building portage"
emerge --sync
nativecpu=`gcc -mtune=native -Q --help=target|grep '  -mtune=' | sed 's/  -mtune=//'| awk '{print $NF}'`
sed -i "s/-O2/-O2 -march=$nativecpu/g" make.conf #/etc/portage/make.conf
echo 'VIDEO_CARDS="d3d12"' >> /etc/portage/make.conf
emerge --quiet --oneshot app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
emerge --depclean app-portage/cpuid2cpuflags
emerge --quiet --verbose --update --deep --newuse @world

# Customizing locale-gen
cd /etc
rm locale.gen
wget https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/locale.gen
locale-gen
eselect locale list

# Some wsl-stuff
cd /etc
wget https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/wsl.conf
groupid=`getent group windows-mounts | cut -d: -f3`
sed -i "s/uid=1000,gid=1000/gid=$groupid/g" wsl.conf
sed -i "s/default = nobody/default = $username/g" wsl.conf

# sudo-stuff
emerge --quiet sudo
cd /etc
mkdir sudoers.d
cd sudoers.d
wget https://github.com/OliBerlin/gentoo-wsl/raw/refs/heads/main/etc/sudoers.d/wheel

# Cleanup
rm /etc/profile.d/initialize.sh
exit
