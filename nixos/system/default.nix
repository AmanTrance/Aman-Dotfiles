{ pkgs, ...  }@inputs :
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  networking = { 
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 43307 43308 ];
      allowedUDPPorts = [ ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  services = {
    xserver = {
      enable = true;

      displayManager = {
        lightdm.enable = true; 
      };

      desktopManager = {
        xfce.enable = true;
      };

      xkb.layout = "us";
    };

    printing.enable = false;

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    openssh.enable = true;
    flatpak.enable = true;
  };

  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics.enable = true;
  };

  security.rtkit.enable = true;

  users.users.amanfreecs = {
    isNormalUser = true;
    description = "amanfreecs";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvrtd" "docker" ];
  };

  nixpkgs.config = {
    allowUnfree = true;	
  };
}
