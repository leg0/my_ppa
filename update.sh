EMAIL=leg0@github.com

dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages
git add Packages Packages.gz

apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease

git add Release Release.gpg InRelease

