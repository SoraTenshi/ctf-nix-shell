{
  description = "A nix-shell for my pentesting purposes";
  

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
      shell_env = (pkgs.buildFHSUserEnv {
        name = "ctf-env";
        runScript = ''
          bash
        '';
      });
    in
    {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [ shell_env ];
        packages = with pkgs; [
          # dependencies
          pwntools
          python310Packages.pwntools
          python310Full
          python-language-server

          # web
          sqlmap

          # pwn
          gdb
          pwndbg
          one_gadget

          # rev
          ghidra
        ];
        shellHook = ''
          export PS1='\e[0;35m\[[\e[0;31mctf\e[0;35m]\]@\w\n\e[0m~ '
          exec ctf-env
        '';
      };
    });
}
