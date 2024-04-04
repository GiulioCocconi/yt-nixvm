{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    file
    killall
    tree
    ripgrep
    libsForQt5.konsole
    libsForQt5.kate
    firefox
    git-credential-oauth
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "vm";

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.whitespace = "trailing-space,space-before-tab";

      credential.helper = [
        "cache --timeout 7200"
        "oauth"
      ];
    };
  };

  fonts.packages = with pkgs; [
    iosevka
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    channel.enable = false;

    nixPath = [
      "nixpkgs=${pkgs.path}"
    ];

    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };

    settings.nix-path = config.nix.nixPath;
  };

  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = [ "ext4" ];

  virtualisation.virtualbox.guest.enable = true;

  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.sddm.enable = true;


  users.users = {
    user = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [ "wheel" ];
    };
  };

  system.stateVersion = "23.11";
}
