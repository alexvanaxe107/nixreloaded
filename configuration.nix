# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, nixunstable, avafonts, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#      ./local-configuration.nix
    ];

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  #boot.loader.grub.efiInstallAsRemovable = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.useOSProber = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  nixpkgs.config.allowUnfree = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.displayManager.startx.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "br";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # Enable pipewire instead of pulseaudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.groups.i2c.gid = 1000;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.alexvanaxe = {
     uid=1000; # The uid has to be the same as arch
     isNormalUser = true;
     extraGroups = [ "wheel" "video" "i2c" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [

     ];
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.alexfunaxe = {
     uid=1001;
     isNormalUser = true;
     extraGroups = [ "wheel" "video" "i2c" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [

     ];
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.alexworkaxe = {
     uid=1002;
     isNormalUser = true;
     extraGroups = [ "wheel" "video" "i2c" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [

     ];
   };

  programs.light.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     # Desktops apps
     light
     # Control the monitor
     ddcutil

     libnotify
     #utilities
     bc
     vim
     wget
     alacritty
     git
     firefox
     pavucontrol
     file

     xorg.xhost

     # Helpers
    tldr
    

     # Adminitration
     killall
     htop
     xorg.xbacklight

     # Installing the new version of the e2fsck
     (import nixunstable {system = system;}).e2fsprogs

     # monitors
     lm_sensors
   ];

  # To enable the font we need to put it in a different config.
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    symbola
    font-awesome
    hack-font
    roboto-mono
    hermit
    mononoki
    overpass
    terminus_font_ttf
    orbitron

    jetbrains-mono
    (nerdfonts.override { fonts = [ "Iosevka" "NerdFontsSymbolsOnly" "CascadiaCode" ]; })

    avafonts.defaultPackage.${system}
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8096 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

