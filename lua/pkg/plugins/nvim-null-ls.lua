return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("plenary")
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = { null_ls.builtins.formatting.clang_format}
		})

		vim.keymap.set("n", "<space>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
	end
}
