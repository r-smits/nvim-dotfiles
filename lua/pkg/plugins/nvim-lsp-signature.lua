return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind = true,
		handler_opts = { border = "solid", },
		hint_enable = false,
		floating_window = true,
		hi_parameter = "LspSignatureActiveParameter",
		floating_window_above_cur_line = true,
		always_trigger = true,
		fix_pos = false,
		auto_close = .1,
		check_completion_visible = false,
		toggle_key = "<C-7>",
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}
