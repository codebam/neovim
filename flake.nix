{
  description = "Nix flake for Neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    mnw.url = "github:gerg-l/mnw";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      mnw,
      home-manager,
      ...
    }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
          (
            system:
            function (
              import nixpkgs {
                inherit system;
                config.allowUnfree = true; # As per the target example structure
              }
            )
          );

      perSystem = forAllSystems (
        pkgs:
        let
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
              dev.config = {
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

          neovim = inputs.mnw.lib.wrap pkgs mnwConfig;

          neovimHomeManagerModule =
            {
              config,
              lib,
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

    in
    {
      packages = nixpkgs.lib.mapAttrs (_systemName: systemOutputs: systemOutputs.packages) perSystem;
      devShells = nixpkgs.lib.mapAttrs (_systemName: systemOutputs: systemOutputs.devShells) perSystem;
      apps = nixpkgs.lib.mapAttrs (_systemName: systemOutputs: systemOutputs.apps) perSystem;

      homeManagerModules.default = (
        { pkgs, ... }:
        let
          hmMnwConfig = {
            neovim = pkgs.neovim-unwrapped;
          };
        in
        {
          config.home.mnw = {
            enable = true;
          } // hmMnwConfig;
        }
      );
    };
}
