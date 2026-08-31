return {

	-- Scrolling
	vim.keymap.set("n", "<ScrollWheelUp>",
		"<cmd>lua require('neoscroll').scroll(-0.1, {move_cursor=false; duration=25})<CR>"),
	vim.keymap.set("n", "<ScrollWheelDown>",
		"<cmd>lua require('neoscroll').scroll(0.1, {move_cursor=false; duration=25})<CR>"),

	-- Search
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" }),

	-- Telescope
	vim.keymap.set('n', '<space>r', require('telescope.builtin').lsp_references, { desc = 'All references' }),
	vim.keymap.set("n", "<space>b", "<cmd>Telescope buffers<CR>", { desc = "all open buffers" }),
	vim.keymap.set("n", "<space>g", "<cmd>Telescope live_grep<CR>"),
	vim.keymap.set("n", "<space>f", "<cmd>Telescope find_files<CR>"),
	
	-- Venv
	vim.keymap.set("n", ",v", "<cmd>VenvSelect<cr>"),

	-- LSP(s)
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float),
	vim.keymap.set("n", "<space>s", vim.diagnostic.show),
	vim.keymap.set("n", "K", vim.lsp.buf.hover),
	vim.keymap.set('n', 'gh', vim.lsp.buf.declaration),   -- for header files
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition),    -- for actual code
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation), -- for inheritance
	vim.keymap.set('n', '<space>sh', vim.lsp.buf.signature_help),
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition),
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename),
	vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action),
	vim.keymap.set('n', '<space>gr', vim.lsp.buf.references),

	-- Debugging
	vim.keymap.set("n", "<space>db", "<cmd>DapToggleBreakpoint<CR>"),
	vim.keymap.set("n", "<space>dr", "<cmd>DapContinue<CR>"),
	vim.keymap.set("n", "<space>dl", "<cmd>DapShowLog<CR>"),

	-- Formatting
	vim.keymap.set('n', '<space>fm', function() vim.lsp.buf.format { async = true } end),

	-- Tree
	vim.keymap.set("n", "<space>tt", "<cmd>NvimTreeToggle<CR>"),
	vim.keymap.set("n", "<space>fa", "<cmd>NvimTreeCollapse<CR>"),
	vim.keymap.set("n", "<space>ff", "<cmd>NvimTreeCollapseKeepBuffers<CR>"),
	vim.keymap.set("n", "<space>//", "<cmd>NvimTreeFindFile<CR>"),

	-- Misc
	vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = "unindent with shift+tab" })

}
