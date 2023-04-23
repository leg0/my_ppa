# TODO: ...y
:$

version=0.24.3
#arch=amd64

filename=step-cli_${version}_amd64.deb
if [ ! -f ${filename} ]; then
    wget https://dl.step.sm/gh-release/cli/gh-release-header/v${version}/${filename}
    exit 1
else
    echo ${filename} already downloaded
fi

filename=step_linux_${version}_armv6.tar.gz
if [ ! -f ${filename} ]; then
    wget https://github.com/smallstep/cli/releases/download/v${version}/${filename}
else
    echo ${filename} already downloaded
fi
executable=$(tar xvf ${filename} --wildcards '*bin/step')
mv ${executable} ./tmp/usr/bin/step-cli

cat <<EOF > ./tmp/DEBIAN/control
Package: step-cli
Version: ${version}
Architecture: armhf
Maintainer: Smallstep Labs, Inc. <techadmin@smallstep.com>
Installed-Size: $(( $(stat --format=%s ./tmp/usr/bin/step-cli) / 1024 ))
Section: utils
Priority: optional
Homepage: https://github.com/smallstep/cli
Description: Zero trust swiss army knife
   step is a zero trust swiss army knife. It’s an easy-to-use and hard-to-misuse
   utility for building, operating, and automating systems that use zero trust
   technologies like authenticated encryption (X.509, TLS), single sign-on
   (OAuth OIDC, SAML), multi-factor authentication (OATH OTP, FIDO U2F),
   encryption mechanisms (JSON Web Encryption, NaCl), and verifiable claims
   (JWT, SAML assertions)
EOF

dpkg-deb --build tmp step-cli_${version}_armhf.deb
