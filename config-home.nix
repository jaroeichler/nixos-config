{
  config,
  lib,
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
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
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
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

  networking = {
    firewall = {
      # Open ports in the firewall if needed.
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
    hostName = "home";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    # Enable ‘sudo’ for the user.
    extraGroups = ["wheel"];
    isNormalUser = true;
  };

  swapDevices = [];
}
