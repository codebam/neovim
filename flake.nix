{
  description = "Nix flake for Neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    mnw.url = "github:gerg-l/mnw";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      mnw,
      flake-utils,
      home-manager,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        # 1. The closure is now extracted into this `mnwConfig` variable.
        # This makes it reusable for both the local package and the module.
        mnwConfig = {
          neovim = pkgs.neovim-unwrapped;
          aliases = [
            "vi"
            "vim"
          ];
          initLua = ''
            require("config")
          '';
          providers = {
            ruby.enable = false;
            python3.enable = false;
          };
          plugins = {
            dev.codebam = {
              pure = ./nvim;
            };
            start = with pkgs.vimPlugins; [
              avante-nvim
              blink-cmp
              blink-cmp-copilot
              catppuccin-vim
              commentary
              conform-nvim
              copilot-lua
              friendly-snippets
              git-blame-nvim
              gitsigns-nvim
              lazydev-nvim
              lualine-nvim
              luasnip
              neogit
              nvim-autopairs
              nvim-bqf
              nvim-surround
              nvim-treesitter.withAllGrammars
              nvim-treesitter-textobjects
              nvim-web-devicons
              oil-nvim
              plenary-nvim
              sleuth
              telescope-nvim
              todo-comments-nvim
              treesj
            ];
          };
          extraLuaPackages = ps: [ ps.jsregexp ];
          extraBinPath = with pkgs; [
            bash-language-server
            nil
            nixd
            git
            markdown-oxide
          ];
        };

        neovim = mnw.lib.wrap pkgs mnwConfig;

        neovimHomeManagerModule =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            config = {
              home = {
                mnw = {
                  enable = true;
                } // mnwConfig;
              };
            };
          };
      in
      {
        packages.default = neovim;

        devShells.default = pkgs.mkShell {
          packages = [
            neovim
          ];
        };

        apps.default = {
          type = "app";
          program = "${neovim}/bin/nvim";
        };

        homeManagerModules.default = neovimHomeManagerModule;
      }
    );
}
