#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# Install tools via apt-get
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install git \
    wget \
    python3 \
    python3-dev \
    software-properties-common \
    build-essential \
    astyle \
    libssl-dev \
    srecord

apt-get clean
rm -rf /var/lib/apt/lists

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
cd /root
TARBALL=""
ARCH="$(uname -m)"
if [ "$ARCH" = "aarch64" ]
then
    TARBALL="gcc-arm-none-eabi-9-2019-q4-major-aarch64-linux.tar.bz2"
else
    TARBALL="gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
fi

wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/$TARBALL
tar -xjf $TARBALL
rm $TARBALL
PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"
echo 'PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"' >> ~/.bashrc


# ------------------------------------------------------------------------------
# Display and save environment settings
python3 --version | tee env_settings
arm-none-eabi-gcc --version | tee -a env_settings

