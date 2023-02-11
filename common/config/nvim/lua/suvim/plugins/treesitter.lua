require'nvim-treesitter.configs'.setup {
    -- A list of parser names
    ensure_installed = { 
        "c", "lua", "vim", "help", 
        "gitattributes", "gitcommit",
        "gitignore", -- needs npm
        "python", "ruby", "rust",
        "sql",  -- needs npm
        "terraform",
        "toml", "yaml",
        "javascript", "typescript", "json",
        "bash", "fish", "comment", 
        "css", "html", "markdown",
        "make", "dockerfile", 
        "eex", "elixir", "heex",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of parsers that will be disabled
        disable = { },
        --
        --
        additional_vim_regex_highlighting = false,
    },
}
