#!/usr/bin/env bash
cd $(dirname "$0")

EXTRAOPTS='--db=/tmp/repocache.db -oAPT::FTPArchive::AlwaysStat=true'
FTPARCHIVE='apt-ftparchive'

# Update ${cfver}.config for new Architectures
for ogdist in iphoneos-arm64/1{8,9}00 iphoneos-arm64e/1{8,9}00; do
	if [[ "${ogdist}" == "iphoneos-arm64e"* ]]; then
		dist="${ogdist}"
		arch=iphoneos-arm64e
	elif [[ "${ogdist}" == "iphoneos-arm64"* ]]; then
		dist="${ogdist}"
		arch=iphoneos-arm64
	fi
	echo $dist
	binary=binary-${arch}
	contents=Contents-${arch}
	mkdir -p dists/${dist}
	rm -f dists/${dist}/{Release{,.gpg},InRelease}

	cp -a CydiaIcon*.png dists/${dist}

	for comp in main testing; do
		if [ ! -d pool/${comp}/${ogdist} ]; then
			continue;
		fi
		mkdir -p dists/${dist}/${comp}/${binary}
		rm -f dists/${dist}/${comp}/${binary}/{Packages{,.xz,.zst},Release{,.gpg}}

		$FTPARCHIVE $EXTRAOPTS packages pool/${comp}/${ogdist} > \
			dists/${dist}/${comp}/${binary}/Packages 2>/dev/null
		xz -c9 dists/${dist}/${comp}/${binary}/Packages > dists/${dist}/${comp}/${binary}/Packages.xz
		zstd -q -c19 dists/${dist}/${comp}/${binary}/Packages > dists/${dist}/${comp}/${binary}/Packages.zst
		
		$FTPARCHIVE $EXTRAOPTS contents pool/${comp}/${ogdist} > \
			dists/${dist}/${comp}/${contents}
		xz -c9 dists/${dist}/${comp}/${contents} > dists/${dist}/${comp}/${contents}.xz
		zstd -q -c19 dists/${dist}/${comp}/${contents} > dists/${dist}/${comp}/${contents}.zst

		$FTPARCHIVE $EXTRAOPTS release -c config/${arch}-basic.conf dists/${dist}/${comp}/${binary} > dists/${dist}/${comp}/${binary}/Release 2>/dev/null
	done

	$FTPARCHIVE $EXTRAOPTS release -c config/$(echo "${dist}" | cut -f1 -d '/').conf dists/${dist} > dists/${dist}/Release 2>/dev/null

	gpg -abs -u 38FFD71E113DB930935928FC664421BE84375685 -o dists/${dist}/Release.gpg dists/${dist}/Release
	gpg -abs -u 38FFD71E113DB930935928FC664421BE84375685 --clearsign -o dists/${dist}/InRelease dists/${dist}/Release
done
