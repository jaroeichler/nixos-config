{modulesPath, ...}: {
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
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [];
    };
    kernelModules = ["amdgpu" "kvm-amd"];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
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

  services = {
    fail2ban.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
