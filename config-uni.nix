{
  config,
  modulesPath,
  ...
}: {
  imports = [
    ./config.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [];
    };
    kernelModules = [];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

  networking = {
    firewall = {
      # Open ports in the firewall if needed.
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
    hostName = "uni";
  };

  # System services.
  services = {
    # Detect printers.
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    # Printing.
    printing.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    # Enable ‘sudo’ for the user.
    extraGroups = ["wheel"];
    isNormalUser = true;
  };
}
