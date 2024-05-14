#fix "/var/cache/apt/archives/partial is missing" for Sileo
#run this script in filza installed in trollstore

mkdir /var/cache
mkdir /var/cache/locate
mkdir -p /var/cache/apt/archives/partial
touch /var/cache/apt/lock

echo "done"
