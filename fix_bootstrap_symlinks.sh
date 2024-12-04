#fix updatelinks.sh failed when re-jailbreaking due to broken bootstrap symlinks
#run this script in filza installed in trollstore

set JBROOT $(find /var/containers/Bundle/Application -maxdepth 1 -name ".jbroot-*")

ln -sf .jbroot/usr/bin/dash $JBROOT/bin/sh
ln -sf .jbroot/usr/bin/dash $JBROOT/usr/bin/sh

echo "fix completed"
