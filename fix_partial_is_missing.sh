#fix "/var/cache/apt/archives/partial is missing" for Sileo
#run this script in filza installed in trollstore

set JBROOT $(find /var/containers/Bundle/Application -maxdepth 1 -name ".jbroot-*")

mkdir $JBROOT/var/cache
mkdir $JBROOT/var/cache/locate
mkdir -p $JBROOT/var/cache/apt/archives/partial
printf "" > $JBROOT/var/cache/apt/archives/lock

echo "done"
