{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
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
  ];

  # time.timeZone = "Europe/Rome";
  # console.keyMap = "it";

  networking.networkmanager.enable = true;

  # Fixes https://github.com/NixOS/nixpkgs/issues/195777
  system.activationScripts = with pkgs; {
    restart-udev = "${systemd}/bin/systemctl restart systemd-udev-trigger.service";
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

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