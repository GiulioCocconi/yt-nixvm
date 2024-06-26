{
  description = "NixOS system for youtube videos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {disko, ...}@inputs: {
    nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./system-config.nix
        ./hardware-config.nix
      ];
    };
  };
}
