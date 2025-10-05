{lib, ...}: let
  inherit (lib.kernel) unset module;
in {
  # Based on https://codeberg.org/ranguli/gentoo-popcorn-kernel
  #
  # most snippits are here

  no-acer = {
    CONFIG_ACERHDF = unset;
    CONFIG_ACER_WIRELESS = unset;
    CONFIG_ACER_WMI = unset;
  };

  no-afs-rxrpc = {
    CONFIG_AF_RXRPC = unset;
    CONFIG_AFS_FS = unset;
  };

  no-agp = {
    CONFIG_AGP = unset;
    CONFIG_INTEL_GTT = module;
  };

  no-amateur-radio = {
    CONFIG_HAMRADIO = unset;
  };
  no-amd = {
    CONFIG_X86_AMD_PLATFORM_DEVICE = unset;
    CONFIG_X86_MCE_AMD = unset;
    CONFIG_PERF_EVENTS_AMD_POWER = unset;
    CONFIG_PERF_EVENTS_AMD_UNCORE = unset;
    CONFIG_PERF_EVENTS_AMD_BRS = unset;
    CONFIG_MICROCODE_AMD = unset;
    CONFIG_AMD_MEM_ENCRYPT = unset;
    CONFIG_AMD_NUMA = unset;
    CONFIG_X86_AMD_PSTATE = unset;
    CONFIG_X86_POWERNOW_K8 = unset;
    CONFIG_X86_AMD_FREQ_SENSITIVITY = unset;
    CONFIG_KVM_AMD = unset;
    CONFIG_PATA_AMD = unset;
    CONFIG_NET_VENDOR_AMD = unset;
    CONFIG_HW_RANDOM_AMD = unset;
    CONFIG_I2C_AMD756 = unset;
    CONFIG_I2C_AMD8111 = unset;
    CONFIG_I2C_AMD_MP2 = unset;
    CONFIG_SPI_AMD = unset;
    CONFIG_PINCTRL_AMD = unset;
    CONFIG_GPIO_AMDPT = unset;
    CONFIG_AGP_AMD64 = unset;
    CONFIG_DRM_RADEON = unset;
    CONFIG_DRM_AMDGPU = unset;
    CONFIG_SND_SOC_AMD_ACP = unset;
    CONFIG_SND_SOC_AMD_ACP3x = unset;
    CONFIG_SND_SOC_AMD_RENOIR = unset;
    CONFIG_SND_SOC_AMD_ACP5x = unset;
    CONFIG_SND_SOC_AMD_ACP6x = unset;
    CONFIG_SND_SOC_AMD_RPL_ACP6x = unset;
    CONFIG_SND_SOC_AMD_PS = unset;
    CONFIG_AMD_SFH_HID = unset;
    CONFIG_AMD_PTDMA = unset;
    CONFIG_AMD_PMF = unset;
    CONFIG_AMD_PMC = unset;
    CONFIG_AMD_IOMMU = unset;
    CONFIG_SOUNDWIRE_AMD = unset;
    CONFIG_NTB_AMD = unset;
    CONFIG_AMD_HSMP = unset;
  };

  no-android = {
    CONFIG_X86_ANDROID_TABLETS = unset;
    CONFIG_ANDROID_BINDER_IPC = unset;
    CONFIG_BT_AOSPEXT = unset;
  };

  no-apple-hardware = {
    CONFIG_MACINTOSH_DRIVERS = unset;
    CONFIG_APPLE_GMUX = unset;
    CONFIG_MOUSE_APPLETOUCH = unset;
    CONFIG_MOUSE_BCM5974 = unset;
    CONFIG_KEYBOARD_APPLESPI = unset;
    CONFIG_SENSORS_APPLESMC = unset;
    CONFIG_DEV_APPLETALK = unset;
  };

  no-asus = {
    CONFIG_SENSORS_ATK0110 = unset;
    CONFIG_SENSORS_ASUS_WMI = unset;
    CONFIG_SENSORS_ASUS_EC = unset;
    CONFIG_HID_ASUS = unset;
    CONFIG_ASUS_LAPTOP = unset;
    CONFIG_ASUS_WIRELESS = unset;
    CONFIG_ASUS_WMI = unset;
    CONFIG_ASUS_TF103C_DOCK = unset;
  };

  no-atheros-qualcomm-wlan = {
    CONFIG_WLAN_VENDOR_ATH = unset;
  };

  no-broadcom-wlan = {
    CONFIG_WLAN_VENDOR_BROADCOM = unset;
  };

  no-canbus = {
    CONFIG_CAN = unset;
  };

  no-ceph = {
    CONFIG_CEPH_FS = unset;
    CONFIG_BLK_DEV_RBD = unset;
    CONFIG_CEPH_LIB = unset;
  };

  no-chrome-hardware = {
    CONFIG_CHROME_PLATFORMS = unset;
  };

  no-smb-cifs = {
    CONFIG_CIFS = unset;
  };

  no-coda = {
    CONFIG_CODA_FS = unset;
  };

  no-f2fs = {
    CONFIG_F2FS_FS = unset;
  };

  no-firewire = {
    CONFIG_FIREWIRE = unset;
    CONFIG_FIREWIRE_NOSY = unset;
  };

  no-fpga = {
    CONFIG_FPGA = unset;
  };

  no-fujitsu = {
    CONFIG_FUJITSU_ES = unset;
    CONFIG_TOUCHSCREEN_FUJITSU = unset;
    CONFIG_AMILO_RFKILL = unset;
    CONFIG_FUJITSU_LAPTOP = unset;
    CONFIG_FUJITSU_TABLET = unset;
    CONFIG_INPUT_APANEL = unset;
  };

  no-gameport = {
    CONFIG_JOYSTICK_ANALOG = unset;
    CONFIG_JOYSTICK_A3D = unset;
    CONFIG_JOYSTICK_ADI = unset;
    CONFIG_JOYSTICK_COBRA = unset;
    CONFIG_JOYSTICK_GF2K = unset;
    CONFIG_JOYSTICK_GRIP = unset;
    CONFIG_JOYSTICK_GRIP_MP = unset;
    CONFIG_JOYSTICK_GUILLEMOT = unset;
    CONFIG_JOYSTICK_INTERACT = unset;
    CONFIG_JOYSTICK_SIDEWINDER = unset;
    CONFIG_JOYSTICK_TMDC = unset;
    CONFIG_JOYSTICK_JOYDUMP = unset;
    CONFIG_GAMEPORT = unset;
  };

  no-gfs = {
    CONFIG_GFS2_FS = unset;
  };

  no-gnss-gps = {
    CONFIG_GNSS = unset;
  };

  no-hp = {
    CONFIG_HP_ILO = unset;
    CONFIG_SENSORS_HP_WMI = unset;
    CONFIG_HP_WATCHDOG = unset;
    CONFIG_X86_PLATFORM_DRIVERS_HP = unset;
  };
  no-huawei = {
    CONFIG_HUAWEI_WMI = unset;
  };

  no-hyperv = {
    CONFIG_HYPERV = unset;
  };

  no-hypervisor-guest = {
    CONFIG_HYPERVISOR_GUEST = unset;
  };

  no-infiniband = {
    CONFIG_INFINIBAND = unset;
  };

  no-intersil-wlan = {
    CONFIG_WLAN_VENDOR_INTERSIL = unset;
  };

  no-jfs = {
    CONFIG_JFS_FS = unset;
  };

  no-lenovo-yoga = {
    CONFIG_YOGABOOK = unset;
    CONFIG_LENOVO_YMC = unset;
  };

  no-lg-laptop = {
    CONFIG_LG_LAPTOP = unset;
  };

  no-marvell-wlan = {
    CONFIG_WLAN_VENDOR_MARVELL = unset;
  };

  no-microchip-wlan = {
    CONFIG_WLAN_VENDOR_MICROCHIP = unset;
  };

  no-mediatek-wlan = {
    CONFIG_WLAN_VENDOR_MEDIATEK = unset;
  };

  no-mellanox = {
    CONFIG_MELLANOX_PLATFORM = unset;
    CONFIG_NET_VENDOR_MELLANOX = unset;
  };

  no-microsoft-surface = {
    CONFIG_TOUCHSCREEN_SURFACE3_SPI = unset;
    CONFIG_SURFACE_PLATFORMS = unset;
  };

  no-misc-char-devices = {
    CONFIG_IPMI_DEVICE_INTERFACE = unset;
    CONFIG_IPMI_SSIF = unset;
    CONFIG_IPMI_IPMB = unset;
    CONFIG_IPMI_WATCHDOG = unset;
    CONFIG_IPMI_POWEROFF = unset;
    CONFIG_SSIF_IPMI_BMC = unset;
    CONFIG_TELCLOCK = unset;
  };

  # maybe not a great idea to use
  # im not sure exacly what this disables
  no-misc-input = {
    CONFIG_INPUT_MISC = unset;
  };

  no-nfc = {
    CONFIG_NFC = unset;
  };

  no-nfs = {
    CONFIG_NFS_FS = unset;
    CONFIG_NFSD = unset;
  };

  no-nilfs2 = {
    CONFIG_NILFS2_FS = unset;
  };

  no-ocfs2 = {
    CONFIG_OCFS2_FS = unset;
  };

  no-old-keyboard-mice = {
    CONFIG_INPUT_VIVALDIFMAP = module;
    CONFIG_KEYBOARD_ATKBD = unset;
    CONFIG_MOUSE_PS2 = unset;
    CONFIG_MOUSE_SERIAL = unset;
    CONFIG_MOUSE_VSXXXAA = unset;
  };

  no-old-odd-joysticks = {
    CONFIG_JOYSTICK_ADC = unset;
    CONFIG_JOYSTICK_IFORCE = unset;
    CONFIG_JOYSTICK_WARRIOR = unset;
    CONFIG_JOYSTICK_MAGELLAN = unset;
    CONFIG_JOYSTICK_SPACEORB = unset;
    CONFIG_JOYSTICK_SPACEBALL = unset;
    CONFIG_JOYSTICK_STINGER = unset;
    CONFIG_JOYSTICK_ZHENHUA = unset;
    CONFIG_JOYSTICK_PSXPAD_SPI = unset;
    CONFIG_JOYSTICK_PXRC = unset;
  };

  no-old-partition-types = {
    CONFIG_AIX_PARTITION = unset;
    CONFIG_OSF_PARTITION = unset;
    CONFIG_MAC_PARTITION = unset;
    CONFIG_MINIX_SUBPARTITION = unset;
    CONFIG_SOLARIS_X86_PARTITION = unset;
    CONFIG_UNIXWARE_DISKLABEL = unset;
    CONFIG_SGI_PARTITION = unset;
    CONFIG_SUN_PARTITION = unset;
  };

  no-parallel-port = {
    CONFIG_PARPORT = unset;
  };
  no-pci-audio-devices = {
    CONFIG_SND_AD1889 = unset;
    CONFIG_SND_ALS300 = unset;
    CONFIG_SND_ALS4000 = unset;
    CONFIG_SND_ALI5451 = unset;
    CONFIG_SND_ASIHPI = unset;
    CONFIG_SND_ATIIXP = unset;
    CONFIG_SND_ATIIXP_MODEM = unset;
    CONFIG_SND_AU8810 = unset;
    CONFIG_SND_AU8820 = unset;
    CONFIG_SND_AU8830 = unset;
    CONFIG_SND_AZT3328 = unset;
    CONFIG_SND_BT87X = unset;
    CONFIG_SND_CA0106 = unset;
    CONFIG_SND_CMIPCI = unset;
    CONFIG_SND_OXYGEN = unset;
    CONFIG_SND_CS4281 = unset;
    CONFIG_SND_CS46XX = unset;
    CONFIG_SND_CTXFI = unset;
    CONFIG_SND_DARLA20 = unset;
    CONFIG_SND_GINA20 = unset;
    CONFIG_SND_LAYLA20 = unset;
    CONFIG_SND_DARLA24 = unset;
    CONFIG_SND_GINA24 = unset;
    CONFIG_SND_LAYLA24 = unset;
    CONFIG_SND_MONA = unset;
    CONFIG_SND_MIA = unset;
    CONFIG_SND_ECHO3G = unset;
    CONFIG_SND_INDIGO = unset;
    CONFIG_SND_INDIGOIO = unset;
    CONFIG_SND_INDIGODJ = unset;
    CONFIG_SND_INDIGOIOX = unset;
    CONFIG_SND_INDIGODJX = unset;
    CONFIG_SND_EMU10K1 = unset;
    CONFIG_SND_EMU10K1X = unset;
    CONFIG_SND_ENS1370 = unset;
    CONFIG_SND_ENS1371 = unset;
    CONFIG_SND_ES1938 = unset;
    CONFIG_SND_ES1968 = unset;
    CONFIG_SND_FM801 = unset;
    CONFIG_SND_HDSP = unset;
    CONFIG_SND_HDSPM = unset;
    CONFIG_SND_ICE1712 = unset;
    CONFIG_SND_ICE1724 = unset;
    CONFIG_SND_KORG1212 = unset;
    CONFIG_SND_LOLA = unset;
    CONFIG_SND_LX6464ES = unset;
    CONFIG_SND_MAESTRO3 = unset;
    CONFIG_SND_MIXART = unset;
    CONFIG_SND_NM256 = unset;
    CONFIG_SND_PCXHR = unset;
    CONFIG_SND_RIPTIDE = unset;
    CONFIG_SND_RME32 = unset;
    CONFIG_SND_RME96 = unset;
    CONFIG_SND_RME9652 = unset;
    CONFIG_SND_SE6X = unset;
    CONFIG_SND_SONICVIBES = unset;
    CONFIG_SND_TRIDENT = unset;
    CONFIG_SND_VIA82XX = unset;
    CONFIG_SND_VIA82XX_MODEM = unset;
    CONFIG_SND_VIRTUOSO = unset;
    CONFIG_SND_VX222 = unset;
    CONFIG_SND_YMFPCI = unset;
  };

  no-pci-media = {
    CONFIG_GPIO_BT8XX = unset;
    CONFIG_MEDIA_CAMERA_SUPPORT = unset;
    CONFIG_MEDIA_ANALOG_TV_SUPPORT = unset;
    CONFIG_MEDIA_DIGITAL_TV_SUPPORT = unset;
    CONFIG_MEDIA_RADIO_SUPPORT = unset;
    CONFIG_MEDIA_PLATFORM_SUPPORT = unset;
    CONFIG_MEDIA_TEST_SUPPORT = unset;
    CONFIG_MEDIA_PCI_SUPPORT = unset;
  };

  no-pcmcia = {
    CONFIG_PCCARD = unset;
  };

  no-plan9 = {
    CONFIG_9P_FS = unset;
    CONFIG_NET_9P = unset;
  };

  no-ppp-slip = {
    CONFIG_PPP = unset;
    CONFIG_SLIP = unset;
  };

  no-quantenna-wlan = {
    CONFIG_WLAN_VENDOR_QUANTENNA = unset;
  };

  no-ralink-wlan = {
    CONFIG_WLAN_VENDOR_RALINK = unset;
  };

  no-realtek-wlan = {
    CONFIG_WLAN_VENDOR_REALTEK = unset;
  };

  no-redpine-wlan = {
    CONFIG_WLAN_VENDOR_RSI = unset;
  };

  no-reiserfs = {
    CONFIG_REISER_FS = unset;
  };

  no-remote-control = {
    CONFIG_INPUT_ATI_REMOTE2 = unset;
    CONFIG_INPUT_KEYSPAN_REMOTE = unset;
    CONFIG_RC_CORE = unset;
  };

  no-samsung = {
    CONFIG_BATTERY_SAMSUNG_SDI = unset;
    CONFIG_HID_SAMSUNG = unset;
    CONFIG_SAMSUNG_LAPTOP = unset;
    CONFIG_SAMSUNG_Q10 = unset;
  };

  no-serial-oddballs = {
    CONFIG_SERIAL_8250 = unset;
    CONFIG_SERIAL_JSM = unset;
    CONFIG_SERIAL_SC16IS7XX = unset;
    CONFIG_SERIAL_ARC = unset;
    CONFIG_SERIAL_NONSTANDARD = unset;
    CONFIG_IPWIRELESS = unset;
    CONFIG_N_GSM = unset;
    CONFIG_NOZOMI = unset;
    CONFIG_SERIAL_DEV_BUS = unset;
    CONFIG_MWAVE = unset;
    CONFIG_XILLYBUS = unset;
    CONFIG_XILLYUSB = unset;
    CONFIG_DMA_VIRTUAL_CHANNELS = module;
  };

  no-st-wlan = {
    CONFIG_WLAN_VENDOR_ST = unset;
  };

  no-synopsis-dma = {
    CONFIG_DW_DMAC_CORE = module;
    CONFIG_DW_DMAC = unset;
    CONFIG_DW_DMAC_PCI = unset;
    CONFIG_DW_EDMA = unset;
  };

  no-ti-wlan = {
    CONFIG_WLAN_VENDOR_TI = unset;
  };

  no-toshiba-hardware = {
    CONFIG_ACPI_TOSHIBA = unset;
    CONFIG_TOSHIBA_BT_RFKILL = unset;
    CONFIG_TOSHIBA_HAPS = unset;
    CONFIG_TOSHIBA_WMI = unset;
  };

  no-touch-keys-sensors = {
    CONFIG_KEYBOARD_QT1050 = unset;
    CONFIG_KEYBOARD_QT1070 = unset;
    CONFIG_KEYBOARD_GPIO = unset;
    CONFIG_KEYBOARD_TM2_TOUCHKEY = unset;
    CONFIG_KEYBOARD_CYPRESS_SF = unset;
  };

  no-touchscreen = {
    CONFIG_INPUT_TOUCHSCREEN = unset;
  };

  no-usb-modem-hdmi-cec = {
    CONFIG_CEC_CH7322 = unset;
    CONFIG_CEC_SECO = unset;
    CONFIG_USB_PULSE8_CEC = unset;
    CONFIG_USB_RAINSHADOW_CEC = unset;
    CONFIG_USB_ACM = unset;
  };

  no-usb-network-adapters = {
    CONFIG_USB_NET_DRIVERS = unset;
    CONFIG_USB_NET_RNDIS_WLAN = unset;
  };

  no-usb-oddballs = {
    CONFIG_USB_MON = unset;
    CONFIG_USB_STORAGE_DATAFAB = unset;
    CONFIG_USB_STORAGE_FREECOM = unset;
    CONFIG_USB_STORAGE_ISD200 = unset;
    CONFIG_USB_STORAGE_USBAT = unset;
    CONFIG_USB_STORAGE_SDDR09 = unset;
    CONFIG_USB_STORAGE_SDDR55 = unset;
    CONFIG_USB_STORAGE_JUMPSHOT = unset;
    CONFIG_USB_STORAGE_ALAUDA = unset;
    CONFIG_USB_STORAGE_ONETOUCH = unset;
    CONFIG_USB_STORAGE_KARMA = unset;
    CONFIG_USB_STORAGE_CYPRESS_ATACB = unset;
    CONFIG_USB_MDC800 = unset;
    CONFIG_USB_MICROTEK = unset;

    CONFIG_USB_SERIAL = module;

    CONFIG_USB_SERIAL_AIRCABLE = unset;
    CONFIG_USB_SERIAL_ARK3116 = unset;
    CONFIG_USB_SERIAL_BELKIN = unset;
    CONFIG_USB_SERIAL_WHITEHEAT = unset;
    CONFIG_USB_SERIAL_DIGI_ACCELEPORT = unset;
    CONFIG_USB_SERIAL_CP210X = unset;
    CONFIG_USB_SERIAL_CYPRESS_M8 = unset;
    CONFIG_USB_SERIAL_EMPEG = unset;
    CONFIG_USB_SERIAL_VISOR = unset;
    CONFIG_USB_SERIAL_IPAQ = unset;
    CONFIG_USB_SERIAL_IR = unset;
    CONFIG_USB_SERIAL_EDGEPORT = unset;
    CONFIG_USB_SERIAL_EDGEPORT_TI = unset;
    CONFIG_USB_SERIAL_F8153X = unset;
    CONFIG_USB_SERIAL_IPW = unset;
    CONFIG_USB_SERIAL_IUU = unset;
    CONFIG_USB_SERIAL_KEYSPAN_PDA = unset;
    CONFIG_USB_SERIAL_KEYSPAN = unset;
    CONFIG_USB_SERIAL_KLSI = unset;
    CONFIG_USB_SERIAL_KOBIL_SCT = unset;
    CONFIG_USB_SERIAL_MCT_U232 = unset;
    CONFIG_USB_SERIAL_MOS7720 = unset;
    CONFIG_USB_SERIAL_MOS7840 = unset;
    CONFIG_USB_SERIAL_NAVMAN = unset;
    CONFIG_USB_SERIAL_PL2303 = unset;
    CONFIG_USB_SERIAL_OTI6858 = unset;
    CONFIG_USB_SERIAL_QCAUX = unset;
    CONFIG_USB_SERIAL_QUALCOMM = unset;
    CONFIG_USB_SERIAL_SPCP8X5 = unset;
    CONFIG_USB_SERIAL_SAFE = unset;
    CONFIG_USB_SERIAL_SIERRAWIRELESS = unset;
    CONFIG_USB_SERIAL_SYMBOL = unset;
    CONFIG_USB_SERIAL_TI = unset;
    CONFIG_USB_SERIAL_CYBERJACK = unset;
    CONFIG_USB_SERIAL_OPTION = unset;
    CONFIG_USB_SERIAL_OMNINET = unset;
    CONFIG_USB_SERIAL_OPTICON = unset;
    CONFIG_USB_SERIAL_XSENS_MT = unset;
    CONFIG_USB_SERIAL_SSU100 = unset;
    CONFIG_USB_SERIAL_QT2 = unset;
    CONFIG_USB_SERIAL_UPD78F0730 = unset;
    CONFIG_USB_SERIAL_XR = unset;
    CONFIG_USB_EMI62 = unset;
    CONFIG_USB_EMI26 = unset;
    CONFIG_USB_ADUTUX = unset;
    CONFIG_USB_SEVSEG = unset;
    CONFIG_USB_LEGOTOWER = unset;
    CONFIG_USB_LCD = unset;
    CONFIG_USB_IDMOUSE = unset;
    CONFIG_USB_APPLEDISPLAY = unset;
    CONFIG_USB_SISUSBVGA = unset;
    CONFIG_USB_TRANCEVIBRATOR = unset;
    CONFIG_USB_IOWARRIOR = unset;
    CONFIG_USB_ISIGHTFW = unset;
    CONFIG_USB_YUREX = unset;
    CONFIG_USB_EZUSB_FX2 = unset;
    CONFIG_USB_CHAOSKEY = unset;
    CONFIG_USB_ATM = unset;
  };

  no-vmware = {
    CONFIG_VSOCKETS = unset;
    CONFIG_VMWARE_VMCI = unset;
    CONFIG_VMWARE_PVSCSI = unset;
    CONFIG_INFINIBAND_VMWARE_PVRDMA = unset;
  };

  no-x86-extended-platform = {
    CONFIG_X86_EXTENDED_PLATFORM = unset;
  };

  no-xen = {
    CONFIG_XEN = unset;
    CONFIG_KVM_XEN = unset;
  };

  no-xilinx-dma = {
    CONFIG_XILINX_XDMA = unset;
  };

  no-zonefs = {
    CONFIG_ZONEFS_FS = unset;
  };

  no-zydas-wlan = {
    CONFIG_WLAN_VENDOR_ZYDAS = unset;
  };
}
