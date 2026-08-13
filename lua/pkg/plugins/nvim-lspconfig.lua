return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip"
	},
	config = function()
		
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local util = require("lspconfig.util")
		require("lspconfig.ui.windows").default_options.border = "single"

		vim.lsp.config("lua_ls", {
			name = "lua-language-server",
			cmd = { "lua-language-server" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "lua" },
			root_markers = { { ".luarc.json", ".luarc.jsonc" }, util.find_git_ancestor },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME }
					},
					diagnostics = {
						globals = { "vim", "require" }
					}
				}
			}
		})

		vim.lsp.config("clangd", {
			name = "c-language-server",
			cmd = { "clangd" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "c", "cpp" },
			root_markers = { util.find_git_ancestor },
		})

		vim.lsp.config("pylsp", {
			name = "python-language-server",
			cmd = { "pylsp" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "python" },
			root_markers = { util.find_git_ancestor },
		})

		local ensure_installed = {
			"clangd",
			"pylsp",
			"lua_ls",
		}

		require("mason").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pylsp")
		vim.lsp.enable("clangd")

		-- Luasnip is a snippet engine that will trigger once autocomplete starts
		local luasnip = require('luasnip') -- luasnip setup
		local cmp = require('cmp')       -- nvim-cmp setup
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
				['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(
					function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
					{ 'i', 's' }
				),
				['<S-Tab>'] = cmp.mapping(
					function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end,
					{ 'i', 's' }
				),
			}),
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		})

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),

			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				-- Disabled as we are using autocomplete.
				-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<space>sh', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<space>wl',
					function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<space>gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<space>frm',
					function()
						vim.lsp.buf.format { async = true }
					end, opts)
			end,
		})
	end,
}
