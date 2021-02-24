#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# Install tools via apt-get
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install python3-setuptools \
    python3-usb \
    python3-pip \
    mercurial \
    ninja-build \
    cmake

apt-get clean
rm -rf /var/lib/apt/lists

# ------------------------------------------------------------------------------
# Set up mbed environment
cd /root
wget https://github.com/ARMmbed/mbed-os/raw/latest/requirements.txt
pip3 install -r requirements.txt

# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
pip3 install \
    'pyyaml>=5.1,<6.0' \
    mbed-cli \
    pyocd

# ------------------------------------------------------------------------------
# Display and save environment settings
(echo -n 'mbed-cli' && mbed --version) | tee -a env_settings
(echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings
(echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings
(echo -n 'pyocd ' && pyocd --version) | tee -a env_settings
