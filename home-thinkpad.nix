{pkgs, ...}: {
  imports = [./home.nix];

  home.packages = with pkgs; [
    acpi
  ];

  wayland.windowManager.hyprland.settings.monitor = [",preferred, auto, 1"];
}
