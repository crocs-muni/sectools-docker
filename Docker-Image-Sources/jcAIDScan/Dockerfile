FROM ubuntu:22.04

WORKDIR /jcAIDScan
COPY . /jcAIDScan

RUN apt -y update;

# Useful CLI-utils
RUN apt -y install tar systemctl wget lshw usbutils

# Java Card Dependencies
RUN apt -y install pcscd libpcsclite1 libusb-1.0-0 flex perl pkg-config libpcsclite-dev libusb-1.0-0-dev pcsc-tools

# jcAIDScan Dependencies
RUN apt -y install ant python3 pip openjdk-17-jre-headless

# Drivers installation
WORKDIR /jcAIDScan/ACS-Unified-Driver-Lnx-Mac-118-P
RUN tar -xf acsccid-1.1.8.tar.bz2
WORKDIR /jcAIDScan/ACS-Unified-Driver-Lnx-Mac-118-P/acsccid-1.1.8
RUN ./configure --disable-dependency-tracking
RUN make
RUN make install

WORKDIR /jcAIDScan
