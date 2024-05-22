#fix "/var/cache/apt/archives/partial is missing" for Sileo
#run this script in filza installed in trollstore

set JBROOT $(find /var/containers/Bundle/Application -maxdepth 1 -name ".jbroot-*")

unlink $JBROOT/UsrLb
unlink $JBROOT/vmo
unlink $JBROOT/Xapps
unlink $JBROOT/var/.keep_symlinks
unlink $JBROOT/var/alternatives
unlink $JBROOT/var/bash
unlink $JBROOT/var/bin
unlink $JBROOT/var/dpkg
unlink $JBROOT/var/etc
unlink $JBROOT/var/lib
unlink $JBROOT/var/Lib
unlink $JBROOT/var/libexec
unlink $JBROOT/var/LIY
unlink $JBROOT/var/sbin
unlink $JBROOT/var/share
unlink $JBROOT/var/sy
unlink $JBROOT/var/zsh

mkdir $JBROOT/var/cache
mkdir $JBROOT/var/cache/locate
mkdir -p $JBROOT/var/cache/apt/archives/partial
printf "" > $JBROOT/var/cache/apt/archives/lock

unlink $JBROOT/var/lib
mkdir $JBROOT/var/lib
mkdir $JBROOT/var/lib/ex
mkdir $JBROOT/var/lib/misc
unlink $JBROOT/var/lib/.jbroot
ln -s ../../.jbroot $JBROOT/var/lib/.jbroot
ln -s .jbroot/Library/dpkg $JBROOT/var/lib/dpkg

echo "fix completed (v3)"
