{
  description = "A nix-shell for my pentesting purposes";
  nixConfig.bash-prompt = "\[ctf\]~ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , flake-compat
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      nixpkgs.config.allowUnfree = true;
      shell_env = (pkgs.buildFHSUserEnv {
        name = "ctf-env";
      });
    in
    rec {
      devShell = pkgs.mkShell {
        inputsFrom = [ shell_env ];
        packages = with pkgs; [
          # dependencies
          pwntools
          python310Packages.pwntools
          python310Full
          python-language-server

          # web
          sqlmap
          # requires unfree!
          burpsuite

          # pwn
          gdb
          pwndbg
          one_gadget

          # rev
          ghidra
        ];

      };
    });
}
