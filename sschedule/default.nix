{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    inputs.disko.nixosModules.disko
    ({modulesPath, ...}: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        (modulesPath + "/profiles/qemu-guest.nix")
      ];
    })
    ./disk-config.nix

    ../../../modules/nixos/base
    ../../../modules/nixos/dan
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/ssh.nix

    ({config, pkgs, lib, ...}: {
      nix = {
        # This will add each flake input as a registry
        # To make nix3 commands consistent with your flake
        registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

        # This will additionally add your inputs to the system's legacy channels
        # Making legacy nix commands consistent as well, awesome!
        nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

        settings = {
          experimental-features = ["nix-command" "flakes"];
          auto-optimise-store = true;

          substituters = [
            "https://cache.nixos.org/"
            "https://nur-dannixon.cachix.org"
          ];
          trusted-public-keys = [
            "nur-dannixon.cachix.org-1:EHgimU2oe7pLXRF9Gji96CboWtyaFHC4pv5dMp/CRvw="
          ];
        };
      };

      nixpkgs = {
        config.allowUnfree = true;


        overlays = [
          (final: prev: {
            nur = import inputs.nur {
              nurpkgs = prev;
              pkgs = prev;
            };
          })
        ];
      };

      time.timeZone = lib.mkDefault "Europe/London";
      i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
      i18n.extraLocaleSettings = lib.mkDefault {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
      console.keyMap = lib.mkDefault "uk";

      hardware.enableRedistributableFirmware = true;

      system.stateVersion = lib.mkDefault "23.05";

      boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
      };

      nixpkgs.hostPlatform = "x86_64-linux";

      networking.hostName = "sschedule";

      services.openssh.openFirewall = true;

      users.users = {
        dan = {
          description = "Dan Nixon";
          isNormalUser = true;
          extraGroups = ["wheel"];
          openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+vdIusbvn2f1ME6riwqwU2sfaYeRLYLkV5LAKiFHmOLHFnHtYX1DZ5YWOIlmmGfUx5azzFfxlOYjRAMn3S4JxD3/pyfYUjUJdT2rtQx1TGpI5whV24f0vTDbCxgtpgzBEsdRiQmVY+YpFbfh5hpknmBM2HBGNXZbLJe7PmIXklRNNKl2PkbB7QsVu4OnLcBKGQVRi2hcqCEtYgt9WtxuenvnAt+VHt5Gm2/n/bPFIotBUNYMoIrVjagilltn5KbyXOPNeXKyhZ5P0bYx/ejiQeCVwF3DedGjWES/cjF5LpmtAfNX01i+j13Oj9t01QZauvPUrK4tqEsApOcUt4gCcU062U5LjAgNCXL++2WUpem6y5JxpO9QqIYovsFpXsLvBPUlOHhYdcgUjKTdG5eRh96IWgu2Xo5hBvYHY11Em35tiVa3UNI4ZUKiNzOMe2D5bQkbUOjribxjcUxzpEvP4x+WIpHv9ww+5qvSkaHnnEko5gOloMd3iduKsJi/VTAFIR0L+WJadlEKIIjSOqAQVCo+yyCR2shE7n5oHTriCJ+q2HBqz6d39JBT1u/jNw7TqC42nO+yZ1BXCC3tzJLYhGrPX8AdAXbYLd2BL/9bOYuUX2D8CyvZlM0ujevudsAwsSKeFbLVqJKZ2R+/kDniU/LbojdCZsQrRSo7A1Ml0xw== dannixon"
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIK7s0LdsRToGiVzKkx6Qb9rfVo/vJFLwPFIdLKB6Eb6qAAAADHNzaDpkYW5uaXhvbg== dannixon-sk-f-yellow"
            "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGPvnIg4Zq1LrKS/FiaHhj1bucpzjFkOd7bONizDaJoeKO1t7SOaFQ3akmnyhzwZ3ofiLrYndt7RUj/fuWRuplQ= dannixon-sk-p-yellow"
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDBp50eBJ/i1f3iVzvT5r3Wgw3oNOg1/Ee/VsTrM1EylAAAADHNzaDpkYW5uaXhvbg== dannixon-sk-f-blue"
            "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGnGBOiciPIJpUKrgEx5bqEKu3eKCkeyBNieD/FOH7ArWSPI0S2c2AEhz/zCHFGD9PrQpg2s0ImEG/ZqwHHOUWw= dannixon-sk-p-blue"
          ];
          initialPassword = "for-fucks-sake-change-this";
        };
        emf = {
          description = "EMF Attendee";
          isNormalUser = true;
        };
      };
    })
  ];
}

# https://askubuntu.com/questions/583141/passwordless-and-keyless-ssh-guest-access
# https://www.howtogeek.com/718074/how-to-use-restricted-shell-to-limit-what-a-linux-user-can-do/
