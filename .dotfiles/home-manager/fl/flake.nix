{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsOld.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    # nixpkgsold.url = "https://channels.nixos.org/?prefix=nixos-23.11/";
  };

  outputs = { self, nixpkgs, nixpkgsOld, ... }:
  let
    pkgs = nixpkgs.packages.x86_64-linux;
    pkgsOld = nixpkgsOld.packages.x86_64-linux;
    legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    pkgs.hello = nixpkgs.legacyPkgs.hello;
    pkgs.default = self.pkgs.hello;

    pkgs.fireland = with pkgs; [
      hyprland
      firefox
    ];
    pkgsOld.default = [ pkgsOld.bottles ];
  };
}
