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
      mkMnwSharedConfig = pkgs: {
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
            impure = "/etc/nixos/nvim-impure";
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
            lazy-nvim
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

        extraLuaPackages = luaPkgs: [ luaPkgs.jsregexp ];

        extraBinPath = with pkgs; [
          bash-language-server
          nil
          nixd
          git
          markdown-oxide
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
        { pkgs, lib, ... }:
        let
          sharedConfigData = mkMnwSharedConfig pkgs;

          homeManagerMnwConfig = {
            inherit (sharedConfigData)
              aliases
              extraBinPath
              extraLuaPackages
              initLua
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
