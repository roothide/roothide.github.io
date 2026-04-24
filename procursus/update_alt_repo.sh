#!/usr/bin/env bash
cd $(dirname "$0")
ORIG_DIR_NAME="$(pwd)"

EXTRAOPTS='--db=/tmp/repocache.db -oAPT::FTPArchive::AlwaysStat=true'
FTPARCHIVE='apt-ftparchive'

mkdir -p alt-repo

for dist in 1800 1900; do
	echo "ALT ${dist}"

	alt_dir="alt-repo/${dist}"
	cd "$ORIG_DIR_NAME/alt-repo/${dist}"

	for deb in *.deb; do
		if $(echo "${deb}" | grep -qF "~"); then
			mv "${deb}" "$(echo "${deb}" | sed 's/~/./g')"
		fi
	done

	$FTPARCHIVE $EXTRAOPTS packages . > Packages
	xz -c9 Packages > Packages.xz
	zstd -q -c19 Packages > Packages.zst

	$FTPARCHIVE $EXTRAOPTS contents . > Contents-iphoneos-arm64e
	xz -c9 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.xz
	zstd -q -c19 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.zst

	$FTPARCHIVE $EXTRAOPTS release -c "$ORIG_DIR_NAME/alt-iphoneos-arm64e.conf" . > Release
	echo "Codename: ${dist}" >> Release

	rm -f Release.gpg InRelease

	gpg -abs -u 38FFD71E113DB930935928FC664421BE84375685 -o Release.gpg Release
	gpg -abs -u 38FFD71E113DB930935928FC664421BE84375685 --clearsign -o InRelease Release
done
