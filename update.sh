dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages
