{modulesPath, ...}: {
  imports = [
    ./config.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = [
        "nvme"
        "sd_mod"
        "uas"
        "usb_storage"
        "xhci_pci"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking = {
    firewall = {
      # Open ports in the firewall if needed.
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "thinkpad";
  };

  # Battery management.
  services.thermald.enable = true;
}
