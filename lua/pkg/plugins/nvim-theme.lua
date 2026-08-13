return {
	-- "projekt0n/github-nvim-theme",
	-- "ellisonleao/gruvbox.nvim"
	-- "morhetz/gruvbox",
	"catppuccin/nvim",

	
	-- "altercation/vim-colors-solarized",
	-- "EdenEast/nightfox.nvim",
	-- "catppuccin/nvim",
	-- "embark-theme/vim",
	lazy = false,
	priority = 1000,
	config = function()
		-- local nightfox = require('nightfox').setup({})
		-- local embark = require("embark")
		-- local catppuccin = require("catppuccin")
		-- catppuccin.setup({})
		--	vim.cmd("colo catppuccin")
		-- local gruvbox = require("gruvbox").setup()
		-- vim.cmd("colorscheme nightfox")
		-- vim.cmd.colorscheme("gruvbox")
		vim.cmd.colorscheme("catppuccin-frappe")
		-- vim.cmd.colorscheme("vim-colors-solarized")
		-- vim.cmd.colorscheme("github_dark")
	end
}
