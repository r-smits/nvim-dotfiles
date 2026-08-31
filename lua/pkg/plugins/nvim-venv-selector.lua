return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			version = "*",
			dependencies = { "nvim-lua/plenary.nvim" }
		},
	},
	ft = "python",
		opts = {
		options = {},
		search = {}
	},
}
