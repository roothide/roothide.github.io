#fix updatelinks.sh failed when re-jailbreaking due to broken bootstrap symlinks
#run this script in filza installed in trollstore

set JBROOT $(find /var/containers/Bundle/Application -maxdepth 1 -name ".jbroot-*")

if test -z "$JBROOT"
	echo "error: jbroot dir not found"
	exit 1
end

rm $JBROOT/.jbroot 2>/dev/null || true
rm $JBROOT/bin/.jbroot 2>/dev/null || true
rm $JBROOT/usr/bin/.jbroot 2>/dev/null || true

ln -sf . $JBROOT/.jbroot
ln -sf ../.jbroot $JBROOT/bin/.jbroot
ln -sf ../../.jbroot $JBROOT/usr/bin/.jbroot
ln -sf .jbroot/usr/bin/dash $JBROOT/bin/sh
ln -sf .jbroot/usr/bin/dash $JBROOT/usr/bin/sh

echo "fix completed"
