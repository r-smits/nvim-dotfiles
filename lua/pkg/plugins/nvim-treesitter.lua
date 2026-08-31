return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter")
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"cpp",
				"lua",
				"python",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			}
		})
	end
}
