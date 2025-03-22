{pkgs, ...}: {
  imports = [./home.nix];

  home.packages = with pkgs; [
    acpi
  ];

  programs.foot.settings.main.font = "JetBrainsMono:size=11";

  wayland.windowManager.hyprland.settings.monitor = [",preferred, auto, 1"];
}
