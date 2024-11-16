{
  description = "A nix-shell for my pentesting purposes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnsupportedSystem = true;
      };
      ctf = pkgs.buildFHSEnv {
        name = "ctf-env";
        targetPkgs = pkgs: let
          pythonStuff = pkgs.python311Full.withPackages (pp: [
            pp.pwntools
            pp.pycryptodome
          ]);
        in with pkgs; [
          # dependencies
          pythonStuff
          python311Packages.python-lsp-server
          python311Packages.pip
          pwntools

          # web
          sqlmap
          nikto
          wget
          thc-hydra
          # python39Packages.impacket

          # pwn
          gdb
          pwndbg
          one_gadget
          metasploit

          # rev
          # ghidra
          # cutter
          
          # misc
          unzip
          gcc
        ];
      };
    in
    {
      devShells.default = ctf.env;
    });
}
