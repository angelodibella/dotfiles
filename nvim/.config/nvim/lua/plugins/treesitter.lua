return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",
    opts = { 
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
}
