# Security analytic tools

This repository contains docker images which simplify and partially automate deployment of
Cyber and Information Security tools developed at the CROCS laboratory.

All docker images use Linux (Ubuntu) as a base layer. This means, they can be run and deployed on windows,
however some functionality will not be available (such as device sharing from windows hosts) due to the current limitations of Docker.

There has been a focus on encapsulating as much dependencies and automating as much of the deployment process as possible, but for
various reasons there might be some steps that need to be performed mannualy by the end users of the tools (this applies mainly
for the tools communicating with javacards). Also some level of knowledge/experience with Docker is assumed.

# Docker Images

The images and the tools they contain can be generally split in two groups:

## Data Analysis Tools

In general, these images are easier to use and require little to no preparation/knowledge and can be played with on remote machines, etc.

*Tip: You may want to share a folder with your prepared data to the container when running it. It could look something like this:*

``` docker run -it -v /data/myProject/rnd:/data/myProject/rnd xmoravec/security_analytics:booltest /bin/bash```

### Booltest

To pull the image with booltest run:

``` docker pull xmoravec/security_analytics:booltest ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it xmoravec/security_analytics:booltest /bin/bash ```

Inside the docker terminal you can run:

``` booltest -h ```

Or:

``` /booltest/try.sh ```

To generate some random and non-random data and run booltest on it.

### ECTester - standalone

To pull the image with ECTester run:

``` docker pull xmoravec/security_analytics:ECTester ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it xmoravec/security_analytics:ECTester /bin/bash ```

Inside the docker terminal you can run:

``` java -jar /ECTester/dist/ECTesterStandalone-dist.jar list-libs ```

Or:

``` /ECTester/try.sh```

To run some basic functionality tests on BouncyCastle Library.

### RTT

To pull the image with RTT run:

``` docker pull xmoravec/security_analytics:rtt ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it xmoravec/security_analytics:rtt /bin/bash ```

Inside the docker terminal you can run:

``` /rtt/randomness-testing-toolkit -h ```

Or:

``` /rtt/try.sh```

To generate some random and non-random data and run rtt on it.

### SPA-Cryprographic-Operations-Extractor

To pull the image with scrutiny run:

``` docker pull xmoravec/security_analytics:SPA ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it xmoravec/security_analytics:SPA /bin/bash ```

Inside the docker terminal you can run:

```java -jar /SPA/CryptoOperationsExtractor-1.0.0-Windows.jar ```

*Note that SPA is a desktop application and therefore further configuration on the host side is necessary*

**TODO: try to come up with solution for GUI sharing**

## Java Card Analysis Tools - Guide

These images contain all required dependencies (including PCSC Lite, ...) and useful tools to work with Java Smart Cards (lsusb, pcsc_scan, ...).
However, the usage of following tools requires a bit more user OS knowledge and experience with Java Smart Cards.

*The images come with pre-installed drivers for the ACS card readers, if you would like to use different readers with the tools, manuall installation of the relevant drivers is necessary at the moment.*

---

Most importantly, you will need to share the connected usb device (JSC) with the docker container when running it.
The device must be connected before the container is started.
This can be done in multiple ways, each of them having some benefits and problems:

1. Sharing just the specific device
   
``` docker run -it --device=/dev/ttyUSB0 xmoravec/security_analytics:JCAlgtest /bin/bash ```

This is the docker best practice as it only shares the device without exposing unrelated resources.

2. Sharing folder with the devices

``` docker run -it -v /dev/bus/usb:/dev/bus/usb xmoravec/security_analytics:JCAlgtest /bin/bash ```

This is an easy way of sharing all usb devices, however you are also exposing irrelevant devices to the container.

3. Run the container in privileged mode

``` docker run -it --privileged xmoravec/security_analytics:JCAlgtest /bin/bash ```

The privileged flag gives docker basically full host capabilities including access to all devices.
As this may be very convenient, it is not recommended to use the privileged flag for more than short tests/debugging.

As far as I know, it is required to have the drivers and all necessary software (PCSClite, ...) installed on the host PC (you basically need to see the card reader in the pcsc_scan output on the host). **(TODO: needs further testing on hosts with no drivers)**

---

Once you are in the terminal inside the running container, you should see the device. For example try running:

``` lsusb ```

*You can use the lsusb utility to determine the number of your device on the host*

Then you will need to start the pcscd service:

``` service pcscd start ```

Now verify you see your card reader with some card information in the output of pcsc_scan:

``` pcsc_scan ```

If you see your device here, everything should be good and you can jump to using the tools!

#### Troubleshooting

1. If there is a problem with the device, but you can see it in the container (lsusb) restarting the pcscd service often helps

``` service pcscd restart ```

2. If the device is correctly running in your host (pcsc_scan shows it) but you cant share it to the host
    a) Make sure you are not running Docker Desktop (there is a conflict between the desktop app and the daemon)
    b) Try rebooting the host and restarting the pcscd service on the host

3. Other usefull debug tools (both in the guest and host):
    a) To see if the service is running:

    ``` service pcscd status ```

    b) For logs of encountered issues:

    ``` pcscd --foreground --debug --apdu --color ```

## Java Card Analysis Tools - Images 

### JCAlgtest

To pull the image with JCAlgtest run:

``` docker pull xmoravec/security_analytics:JCAlgtest ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it --device=/dev/bus/usb/001/002 xmoravec/security_analytics:JCAlgtest /bin/bash ```

You will first need to install the applet, you can do that from inside the container:

``` java -jar gp.jar --install AlgTest_v1.8.0_jc304.cap ```

Inside the docker terminal you can run:

``` java -jar AlgTestJClient.jar --help ```

or

``` java -Dsun.security.smartcardio.library=/usr/lib64/libpcsclite.so.1 -jar AlgTestJClient.jar ```

to perform actual measurements and tests.

### Scrutiny

To pull the image with scrutiny run:

``` docker pull xmoravec/security_analytics:scrutiny ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it --device=/dev/bus/usb/001/002 xmoravec/security_analytics:scrutiny /bin/bash ```

Inside the docker terminal you can run:

``` python -u /scrutiny/measure_javacard.py --help ```

Or

``` python -u measure_javacard.py Supposedly_NXP_P60 ```

To perform some actual measurements. (Install the JCAlgTest applet if needed.)

### jcAIDScan

To pull the image with scrutiny run:

``` docker pull xmoravec/security_analytics:jcAIDScan ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it --device=/dev/bus/usb/001/002 xmoravec/security_analytics:jcAIDScan /bin/bash ```

Inside the docker terminal you can run:

``` python /jcAIDScan/jcAIDScan.py ```

### ECTester - reader + applet

To pull the image with ECTester run:

``` docker pull xmoravec/security_analytics:ECTester ```

Or run it directly (the image is downloaded automatically first):

``` docker run -it --device=/dev/bus/usb/001/002 xmoravec/security_analytics:ECTester /bin/bash ```

Inside the docker terminal you can run:

``` java -jar ECTesterReader.jar -h ```

Or:

``` java -jar ECTesterReader.jar -t -s ```

To perform actual measurements. If you need to install the applet, you can do it with the included GlobalPlatformPro:

``` java -jar /ECTester/applet/gp.jar --install /path/to/applet ```

---

## Play with docker
If you don't want to install docker, you can play with the tools here:

``` https://labs.play-with-docker.com/ ```

However, the functionality will obviously be limited as the docker is not running on your computer - it is difficult if not impossible to try most of the advanced functionality of these tools (can't connect a smartcard, problem to get data to the container, ...).

---
## Sources

This repository and contained docker images have been created as a part of a Master Thesis at Masaryk University for CROCS laboratory where all the dockerized tools were developed.

For more information on licensing, further development, test data and especially for more detailed documentation and usage of dockerized tools, please refer to
https://github.com/orgs/crocs-muni where repositories of most of those tools can be found.

The pre-built Docker images live in https://hub.docker.com/repository/docker/xmoravec/security_analytics/general.