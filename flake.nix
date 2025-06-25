{
  description = "Nix flake for Neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    mnw.url = "github:gerg-l/mnw";
  };

  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      mkMnwSharedConfig = pkgs: {
        neovim = pkgs.neovim-unwrapped;

        aliases = [
          "vi"
          "vim"
        ];

        luaFiles = [ ./nvim/lua/init.lua ];

        providers = {
          ruby.enable = false;
          python3.enable = false;
        };

        plugins = {
          dev.config = {
            pure = ./nvim;
            impure = "/home/codebam/Documents/neovim/nvim";
          };
          start = with pkgs.vimPlugins; [
            gitsigns-nvim
            lazy-nvim
            lualine-nvim
            nvim-bqf
            oil-nvim
          ];
          opt = with pkgs.vimPlugins; [
            avante-nvim
            blink-cmp
            blink-cmp-copilot
            catppuccin-vim
            colorizer
            conform-nvim
            copilot-lua
            friendly-snippets
            git-blame-nvim
            lazydev-nvim
            luasnip
            neogit
            nui-nvim
            nvim-autopairs
            nvim-lspconfig
            nvim-surround
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-web-devicons
            plenary-nvim
            telescope-nvim
            todo-comments-nvim
            treesj
            vim-commentary
            vim-sleuth
            vim-snippets
            vim-obsession
          ];
        };

        extraLuaPackages = luaPkgs: [ luaPkgs.jsregexp ];

        extraBinPath = with pkgs; [
          bash-language-server
          git
          markdown-oxide
          nil
          nixd
          stylua
        ];
      };

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
                config.allowUnfree = true;
              }
            )
          );

      perSystem = forAllSystems (
        pkgs:
        let
          mnwConfigForWrap = mkMnwSharedConfig pkgs;
          neovim = inputs.mnw.lib.wrap pkgs mnwConfigForWrap;
        in
        {
          packages.default = neovim;

          devShells.default = pkgs.mkShell {
            packages = [
              neovim
            ] ++ mnwConfigForWrap.extraBinPath; # Or add them directly
          };

          apps.default = {
            type = "app";
            program = "${neovim}/bin/nvim";
          };
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
          sharedConfigData = mkMnwSharedConfig pkgs;

          homeManagerMnwConfig = {
            inherit (sharedConfigData)
              aliases
              extraBinPath
              extraLuaPackages
              luaFiles
              neovim
              plugins
              providers
              ;
          };
        in
        {
          config.programs.mnw = homeManagerMnwConfig // {
            enable = true;
          };
        }
      );
    };
}
