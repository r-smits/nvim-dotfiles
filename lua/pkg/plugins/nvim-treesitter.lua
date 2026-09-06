return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter').setup()

		-- install the parsers you want
		local ensure_installed = {
			'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query',
			'python', 'json', 'yaml', 'bash', 'markdown', 'markdown_inline',
		}
		require('nvim-treesitter').install(ensure_installed)

		-- highlighting/indent/folding aren't automatic anymore — turn them on yourself
		vim.api.nvim_create_autocmd('FileType', {
			pattern = '*',
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start()
					vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
