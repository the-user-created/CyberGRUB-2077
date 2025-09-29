# CyberGRUB-2077

![CyberGRUB-2077 Preview](./preview.png)

<div align="center">
    <a href="README.md"><img src="https://img.shields.io/badge/ENGLISH-white?style=for-the-badge" alt="English README.md version"/></a>
    <a href="README-es.md"><img src="https://img.shields.io/badge/ESPAÑOL-white?style=for-the-badge" alt="Spanish README.md version"/></a>
    <a href="README-pt.md"><img src="https://img.shields.io/badge/PORTUGUÊS-white?style=for-the-badge" alt="Portuguese README.md version"/></a>
</div>

A GRUB bootloader theme inspired by Cyberpunk 2077.

## Features

* **Beautiful Cyberpunk 2077 aesthetic** for your bootloader.
* **A wide selection of distro/OS logos** to personalize your setup [see below](#available-logos).
* **Revamped Installer:** A clean, user-friendly command-line interface.
* **Smart Detection:** Automatically finds the correct GRUB paths and update commands for most major Linux
  distributions (Debian, Ubuntu, Arch, Fedora, RHEL, and derivatives).
* **Portable:** The installation script can be run from any location on your system.

## Installation & Usage

1. **Clone the repository:**
   ```shell
   git clone https://github.com/adnksharp/CyberGRUB-2077.git
   cd CyberGRUB-2077
   ```

2. **Run the installer:**
   The script must be run with root privileges (`sudo`).

    * **To install with the default 'samurai' logo:**
      ```shell
      sudo ./install.sh
      ```
    * **To install with a specific logo (e.g., 'ubuntu'):**
      ```shell
      sudo ./install.sh --logo ubuntu
      ```

3. **Explore other options:**

    * **To see a list of all available logos:**
      ```shell
      ./install.sh --list
      ```
      (Root privileges are not required to list logos.)

    * **To view the help message:**
      ```shell
      ./install.sh --help
      ```

## Uninstallation

To remove the theme and restore your system's default GRUB appearance, simply run the `uninstall.sh` script with root
privileges:

```shell
sudo ./uninstall.sh
```

The script will automatically remove the theme files, restore the GRUB configuration, and update GRUB for you.

### Sample Outputs

**Default Installation:**

```
$ sudo ./install.sh
╔══════════════════════════════════════════════════════════════════════════════════╗
║ CyberGRUB 2077                                                                   ║
╚══════════════════════════════════════════════════════════════════════════════════╝
╔══════════════════════════════════════════════════════════════════════════════════╗
║ Using logo: samurai                                                              ║
║ ROOT OK                                                                          ║
║ BOOT THEME DIRECTORY OK                                                          ║
║ NEW THEME COPIED                                                                 ║
║ LOGO COPIED                                                                      ║
║ GRUB CONFIG MODIFIED                                                             ║
║ GRUB THEME UPDATED                                                               ║
║                                                                                  ║
║ THE THEME HAS BEEN INSTALLED SUCCESSFULLY                                        ║
║ You will now see it at the next reboot.                                          ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

**Listing Available Logos:**

```
$ ./install.sh --list
╔══════════════════════════════════════════════════════════════════════════════════╗
║ CyberGRUB 2077                                                                   ║
╚══════════════════════════════════════════════════════════════════════════════════╝
╔══════════════════════════════════════════════════════════════════════════════════╗
║ AVAILABLE LOGOS                                                                  ║
║                                                                                  ║
║ 4m                alma              alpine            antergos                   ║
║ antix             arch              artix             bedrock                    ║
║ clear             debian            deepin            elementary                 ║
║ endeavouros       endless           fedora            feren                      ║
║ freebsd           garuda            gentoo            guix                       ║
║ kali              kaos              kubuntu           lfs                        ║
║ linuxmint         linux             lite              lubuntu                    ║
║ mabox             macosx            mageia            manjaro                    ║
║ mate              mx-linux          neon              netrunner                  ║
║ nixos             openmandriva      opensuse          parrot                     ║
║ peppermint        pop               puppy             q4os                       ║
║ qubes             raspios           reborn            redhat                     ║
║ rosa              samurai           septor            slackware                  ║
║ tails             tinycore          ubuntuDDE         ubuntu                     ║
║ unity             void              windows           xubuntu                    ║
║ zorin                                                                            ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

## Available Logos

|         ![4m](./img/logos/4m.png)         |     ![alma](./img/logos/alma.png)     |  ![alpine](./img/logos/alpine.png)  |   ![antergos](./img/logos/antergos.png)   |       ![antix](./img/logos/antix.png)       |         ![arch](./img/logos/arch.png)         |     ![artix](./img/logos/artix.png)     | ![bedrock](./img/logos/bedrock.png) |
|:-----------------------------------------:|:-------------------------------------:|:-----------------------------------:|:-----------------------------------------:|:-------------------------------------------:|:---------------------------------------------:|:---------------------------------------:|:-----------------------------------:|
|      ![clear](./img/logos/clear.png)      |   ![debian](./img/logos/debian.png)   |  ![deepin](./img/logos/deepin.png)  | ![elementary](./img/logos/elementary.png) | ![endeavouros](./img/logos/endeavouros.png) |      ![endless](./img/logos/endless.png)      |    ![fedora](./img/logos/fedora.png)    |   ![feren](./img/logos/feren.png)   |
|    ![freebsd](./img/logos/freebsd.png)    |   ![garuda](./img/logos/garuda.png)   |  ![gentoo](./img/logos/gentoo.png)  |       ![guix](./img/logos/guix.png)       |        ![kali](./img/logos/kali.png)        |         ![kaos](./img/logos/kaos.png)         |   ![kubuntu](./img/logos/kubuntu.png)   |     ![lfs](./img/logos/lfs.png)     |
|  ![linuxmint](./img/logos/linuxmint.png)  |    ![linux](./img/logos/linux.png)    |    ![lite](./img/logos/lite.png)    |    ![lubuntu](./img/logos/lubuntu.png)    |       ![mabox](./img/logos/mabox.png)       |       ![macosx](./img/logos/macosx.png)       |    ![mageia](./img/logos/mageia.png)    | ![manjaro](./img/logos/manjaro.png) |
|       ![mate](./img/logos/mate.png)       | ![mx-linux](./img/logos/mx-linux.png) |    ![neon](./img/logos/neon.png)    |  ![netrunner](./img/logos/netrunner.png)  |       ![nixos](./img/logos/nixos.png)       | ![openmandriva](./img/logos/openmandriva.png) |  ![opensuse](./img/logos/opensuse.png)  |  ![parrot](./img/logos/parrot.png)  |
| ![peppermint](./img/logos/peppermint.png) |      ![pop](./img/logos/pop.png)      |   ![puppy](./img/logos/puppy.png)   |       ![q4os](./img/logos/q4os.png)       |       ![qubes](./img/logos/qubes.png)       |      ![raspios](./img/logos/raspios.png)      |    ![reborn](./img/logos/reborn.png)    |  ![redhat](./img/logos/redhat.png)  |
|       ![rosa](./img/logos/rosa.png)       |  ![samurai](./img/logos/samurai.png)  |  ![septor](./img/logos/septor.png)  |  ![slackware](./img/logos/slackware.png)  |       ![tails](./img/logos/tails.png)       |     ![tinycore](./img/logos/tinycore.png)     | ![ubuntuDDE](./img/logos/ubuntuDDE.png) |  ![ubuntu](./img/logos/ubuntu.png)  |
|      ![unity](./img/logos/unity.png)      |     ![void](./img/logos/void.png)     | ![windows](./img/logos/windows.png) |    ![xubuntu](./img/logos/xubuntu.png)    |       ![zorin](./img/logos/zorin.png)       |                                               |                                         |                                     |

