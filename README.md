# ctf-nix-shell
Toy nix shell for ctfs

## How to use
Since i included the burpsuite in this nix-shell, you either have to execute `nix develop --impure` if you're using flakes.
If you're not using flakes, you either can add the environment variable: `NIXPKGS_ALLOW_UNFREE=1` or add `{ allowUnfree = true; }` to your `~/.config/nixpkgs/config.nix`.
