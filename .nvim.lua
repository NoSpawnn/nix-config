local vim = vim

local hostname = vim.fn.hostname()
local username = os.getenv("USER")

vim.lsp.config("nixd", {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                nixos = {
                    expr = string.format(
                        "(builtins.getFlake (toString ./.)).nixosConfigurations.%s.options",
                        hostname
                    ),
                },
                home_manager = {
                    expr = string.format(
                        '(builtins.getFlake (toString ./.)).homeConfigurations."%s@%s".options',
                        username,
                        hostname
                    ),
                },
            },
        },
    },
})
vim.lsp.enable("nixd")

dofile("./dotfiles/.nvim.lua")
