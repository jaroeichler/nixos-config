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
    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

  networking = {
    firewall = {
      # Open ports in the firewall if needed.
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "thinkpad";
  };

  programs = {};

  # Battery management.
  services.thermald.enable = true;
}
