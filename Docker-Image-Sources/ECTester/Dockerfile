FROM ubuntu:22.04

WORKDIR /ECTester
COPY . /ECTester

RUN apt -y update;

# Useful CLI-utils
RUN apt -y install tar systemctl wget lshw usbutils make

# Java Card Dependencies
RUN apt -y install pcscd libpcsclite1 libusb-1.0-0 flex perl pkg-config libpcsclite-dev libusb-1.0-0-dev pcsc-tools

# ECTester Dependencies
RUN apt -y install openjdk-8-jre-headless openjdk-8-jdk-headless ant gcc g++ git

# Drivers installation
WORKDIR /ECTester/ACS-Unified-Driver-Lnx-Mac-118-P
RUN tar -xf acsccid-1.1.8.tar.bz2
WORKDIR /ECTester/ACS-Unified-Driver-Lnx-Mac-118-P/acsccid-1.1.8
RUN ./configure --disable-dependency-tracking
RUN make
RUN make install

#building all 3 submodules
#RUN git submodule update --init --recursive       # To initialize submodules (JavaCard SDKs, Microsoft CNG, BoringSSL, ...)
WORKDIR /ECTester
RUN ant -f build-reader.xml package               # To build the reader tool (jar) -> "dist/ECTesterReader.jar"
RUN ant -f build-standalone.xml package           # To build the standalone tool (jar) -> "dist/ECTesterStandalone.jar"
RUN ant -f build-applet.xml build                 # To build the applet (cap) -> "applet/ectester.cap".

WORKDIR /ECTester