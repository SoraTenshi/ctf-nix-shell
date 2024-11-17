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
      ctf = pkgs.mkShell {
        name = "ctf-env";
        buildInputs = let
          pythonStuff = pkgs.python311.withPackages (pp: [
            pp.pwntools
            pp.pycryptodome
            pp.python-lsp-server
          ]);
        in with pkgs; [
          # dependencies
          pythonStuff

          # web
          sqlmap
          nikto
          wget
          thc-hydra
          nmap
          masscan
          # python39Packages.impacket

          # pwn
          gdb
          pwndbg
          one_gadget
          metasploit
          exploitdb

          # rev
          # ghidra
          # cutter
          
          # misc
          unzip
          unrar
          gcc

        ];
      };
    in
    {
      devShells.default = ctf;
    });
}
