# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader = { efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
  
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "kennedy"; # Define your hostname. # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPorts = [config.services.tailscale.port ];
    enable = true;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port ];
  };
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

 services.displayManager.cosmic-greeter.enable = true;

 services.desktopManager.cosmic.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "sam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	 pkgs.evil-helix
	 pkgs.neovim
	 pkgs.verible
	 pkgs.gcc-arm-embedded
	 pkgs.git
 	 pkgs.fastfetch
 	 pkgs.alacritty
	 pkgs.verilator
	 pkgs.wayland-utils
	 pkgs.wl-clipboard
	 pkgs.zsh
	 pkgs.brave
	 pkgs.valgrind
	 pkgs.fzf
	 pkgs.meson
	 pkgs.lua
	 pkgs.gdb
	 pkgs.gcc
   pkgs.clang
   pkgs.nixd
   pkgs.rustup
   pkgs.python314
   pkgs.pipx
   pkgs.quartus-prime-lite
   pkgs.gh
   pkgs.caffeine-ng
   pkgs.btop
   pkgs.tcl
   pkgs.ngspice
   pkgs.gtkwave
   pkgs.verilator
   pkgs.tailscale-systray
   pkgs.verilator
   pkgs.android-tools
   pkgs.kicad
   pkgs.starship
   pkgs.zathura
   pkgs.typst
   pkgs.stm32cubemx
   pkgs.zed-editor
   pkgs.obs-studio
   pkgs.pulseview
   pkgs.perf
   pkgs.yazi
   pkgs.obsidian
   pkgs.nodejs_24
   pkgs.anki
  ];

  services.tailscale.enable = true;  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
      enableSSHSupport = true;
    };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  # List services that you want to enable:
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
  };
  # Enable the OpenSSH daemon.


  services.openssh = {
  	enable = true;
	ports = [ 22 ];
	settings = {
		PasswordAuthentication = true;
		UseDns = true;
	};
  };

  programs.tmux = {
    enable =  true;
    clock24 = true;

    extraConfig = ''
        set -g  mouse on
      '';
  };

  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "45min";
    options = "--delete-older-than 7d";
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}