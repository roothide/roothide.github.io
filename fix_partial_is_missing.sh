#fix "/var/cache/apt/archives/partial is missing" for Sileo
#run this script in filza installed in trollstore

set JBROOT $(find /var/containers/Bundle/Application -maxdepth 1 -name ".jbroot-*")

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

echo "done(v2)"
