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
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
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

  programs = {
    steam = {
      dedicatedServer.openFirewall = true;
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}
