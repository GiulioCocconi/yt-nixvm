{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    file
    killall
    tree
    ripgrep
    terminator
    libsForQt5.konsole
    libsForQt5.kate
    firefox
    git-credential-oauth
  ];

  # time.timeZone = "Europe/Rome";
  # console.keyMap = "it";

  networking.networkmanager.enable = true;

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.whitespace = "trailing-space,space-before-tab";

      credential-helper = [
        "cache --timeout 7200"
        "oauth"
      ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = [ "ext4" ];
  
  virtualisation.virtualbox.guest.enable = true;

  services.xserver.desktopManager.lxqt.enable = true;


  users.users = {
    user = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [ "wheel" ];
    };
  };

  system.stateVersion = "23.11";
}
