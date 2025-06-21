# Neovim using Minimal Neovim wrapper

## To use:

- Set up Nix: https://nixos.org/download/
- Set up Flakes: https://wiki.nixos.org/wiki/Flakes#Nix_standalone
- Clone this repo
- Run `nix develop`
- Run neovim with either: `vi`, `vim`, or `nvim`
- `nix run github:codebam/neovim` to run neovim directly without cloning the repo

## To use as a home-manager module:

- include mnw in your `flake.nix`

```nix
    mnw.url = "github:gerg-l/mnw";
```

- include this in the inputs of your `flake.nix`

```nix
    neovim = {
      url = "github:codebam/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mnw.follows = "mnw";
    };
```

- import both the home-manager modules wherever you put your `./home.nix`

```nix
                  inputs.mnw.homeManagerModules.default
                  inputs.neovim.homeManagerModules.default
```
