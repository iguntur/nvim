local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({
		"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                colorscheme = "tokyonight",
                -- colorscheme = "catppuccin",
                -- colorscheme = "catppuccin-macchiato",
                -- colorscheme = "catppuccin-frappe",
                -- colorscheme = "catppuccin-latte",
                -- colorscheme = "catppuccin-mocha",
            },
        },

        -- UI
        { import = "lazyvim.plugins.extras.ui.treesitter-context" },
        { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
        -- { import = "lazyvim.plugins.extras.ui.edgy" },

        -- import any extras modules here
        -- coding
        { import = "lazyvim.plugins.extras.coding.mini-surround" },

        -- editor
        { import = "lazyvim.plugins.extras.editor.inc-rename" },

        -- formatting
        { import = "lazyvim.plugins.extras.formatting.prettier" },

        -- linting
        -- { import = "lazyvim.plugins.extras.linting.eslint" },

        -- lang
        { import = "lazyvim.plugins.extras.lang.git" },
        { import = "lazyvim.plugins.extras.lang.docker" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.sql" },
        { import = "lazyvim.plugins.extras.lang.json" },
        -- { import = "lazyvim.plugins.extras.lang.markdown" },
        -- { import = "lazyvim.plugins.extras.lang.python" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.tailwind" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.yaml" },

        -- lsp
        -- { import = "lazyvim.plugins.extras.lsp.none-ls" },

        -- util
        { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

        -- test
        { import = "lazyvim.plugins.extras.test.core" },

        -- dap
        { import = "lazyvim.plugins.extras.dap.core" },

        -- import/override with your plugins
        { import = "plugins" },

        -- import custom plugins
        {
            dir = vim.fn.expand("$HOME/dev/github.com/iguntur/gt.nvim"),
            import = "gt.plugins",
        },
    },

    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },

    install = {
        colorscheme = {
            "tokyonight",
            "habamax",
        },
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
