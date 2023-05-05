FROM ubuntu:22.04

WORKDIR /JCAlgTest
COPY . /JCAlgTest

RUN apt -y update;

# Useful CLI-utils
RUN apt -y install tar systemctl wget lshw usbutils make

# Java Card Dependencies
RUN apt -y install pcscd libpcsclite1 libusb-1.0-0 flex perl pkg-config libpcsclite-dev libusb-1.0-0-dev pcsc-tools

# JCAlgTest Dependencies
RUN apt -y install openjdk-17-jre-headless

# Drivers installation
WORKDIR /JCAlgTest/ACS-Unified-Driver-Lnx-Mac-118-P
RUN tar -xf acsccid-1.1.8.tar.bz2
WORKDIR /JCAlgTest/ACS-Unified-Driver-Lnx-Mac-118-P/acsccid-1.1.8
RUN ./configure --disable-dependency-tracking
RUN make
RUN make install

WORKDIR /JCAlgTest