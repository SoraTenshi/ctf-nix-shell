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
        profile = "PS1='\\e[0;35m\\[[\\e[0;31mctf\\e[0;35m]\\]@\\w\\n\\e[0m~ '";
        targetPkgs = pkgs: with pkgs; [
          # dependencies
          pwntools
          python311Packages.pwntools
          python311Packages.python-lsp-server
          python311Full

          # web
          sqlmap
          nikto
          # thc-hydra
          # python39Packages.impacket

          # pwn
          # gdb
          # pwndbg
          one_gadget
          metasploit

          # rev
          # ghidra
          # cutter
          
          # misc
          unzip
        ];
      };
    in
    {
      devShells.default = ctf.env;
    });
}
