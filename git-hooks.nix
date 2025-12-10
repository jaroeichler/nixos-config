{ pkgs, ... }:
let
  excludes = [ ];
in
{
  # General.
  check-case-conflict = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/check-case-conflict";
    inherit excludes;
    name = "check-case-conflict";
    types = [ "text" ];
  };
  detect-private-key = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/detect-private-key";
    inherit excludes;
    name = "detect-private-key";
    types = [ "text" ];
  };
  end-of-file-fixer = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/end-of-file-fixer";
    inherit excludes;
    name = "end-of-file-fixer";
    types = [ "text" ];
  };
  fix-byte-order-marker = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/fix-byte-order-marker";
    inherit excludes;
    name = "fix-byte-order-marker";
  };
  mixed-line-ending = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/mixed-line-ending";
    inherit excludes;
    name = "mixed-line-ending";
    types = [ "text" ];
  };
  trailing-whitespace-fixer = {
    enable = true;
    entry = "${pkgs.python311Packages.pre-commit-hooks}/bin/trailing-whitespace-fixer";
    inherit excludes;
    name = "trailing-whitespace";
    types = [ "text" ];
  };

  # Nix.
  nixfmt = {
    enable = true;
    args = [
      "--width=100"
      "--indent=2"
      "--strict"
      "--verify"
    ];
  };
  deadnix.enable = true;
  statix.enable = true;
}
