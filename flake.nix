{
  description = "";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    mnw.url = "github:gerg-l/mnw";
  };

  outputs =
    {
      self,
      nixpkgs,
      mnw,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          (mnw.lib.wrap pkgs {
            neovim = pkgs.neovim-unwrapped;
            aliases = [
              "vi"
              "vim"
            ];
            initLua = ''
              																								require("codebam")
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
                blink-cmp
                catppuccin-vim
                commentary
                conform-nvim
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
            ];
          })
        ];
      };
    };
}
