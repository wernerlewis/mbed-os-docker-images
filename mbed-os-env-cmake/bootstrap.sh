#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# Install tools via apt-get
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install python3-setuptools \
    python3-usb \
    python3-pip \
    ninja-build

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
add-apt-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
apt-get -y update
apt-get -y install cmake
apt-get clean
rm -rf /var/lib/apt/lists

# ------------------------------------------------------------------------------
# Set up mbed environment
cd /root
wget https://github.com/ARMmbed/mbed-os/raw/latest/tools/cmake/requirements.txt
pip3 install -r requirements.txt

# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
pip3 install \
    mbed-tools \
    pyocd \
    mbed-greentea \
    mbed-host-tests

# ------------------------------------------------------------------------------
# Add additional environment settings
(echo -n 'mbed-tools ' && mbed-tools --version) | tee -a env_settings
(echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings
(echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings
(echo -n 'pyocd ' && pyocd --version) | tee -a env_settings

