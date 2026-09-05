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
		require("lspconfig.ui.windows").default_options.border = "single"

		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = {
							"lua/?.lua",
							"lua/?init.lua",
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
							-- { vim.fn.stdpath("data") .. "/lazy" },
						}
					},
				})
			end,
			name = "lua-language-server",
			cmd = { "lua-language-server" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "lua" },
			root_markers = {
				{
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					".git",
				},
				vim.fs.dirname(vim.fs.find('.git', { path = ".", upward = true })[1]),
			},
			settings = {
				Lua = {
					codeLens = {
						enable = true
					},
					hint = {
						enable = true,
						semicolon = "Disable",
					},
					diagnostics = {
						globals = {
							"vim",
							"require"
						}
					}
				}
			}
		})
		vim.lsp.config("ruff", {
			name = "ruff",
			cmd = { "ruff", "server" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "python" },
			root_markers = {
				{
					"pyproject.toml",
					"ruff.toml",
					".ruff.toml",
					".git",
				},
				vim.fs.dirname(vim.fs.find('.git', { path = ".", upward = true })[1]),
			}
		})
		vim.lsp.config("clangd", {
			name = "c-language-server",
			cmd = { "clangd" },
			autostart = true,
			capabilities = capabilities,
			filetypes = { "c", "cpp" },
			root_markers = {
				vim.fs.dirname(vim.fs.find('.git', { path = ".", upward = true })[1]),
			},
		})
		vim.lsp.config("basedpyright", {
			name = "basedpyright",
			cmd = { "basedpyright-langserver", "--stdio" },
			capabilities = capabilities,
			filetypes = { "python" },
			root_markers = {
				{
					"Pipfile",
					"Pipfile.lock",
					"requirements.txt",
					".git",
					vim.fs.dirname(vim.fs.find('.git', { path = ".", upward = true })[1]),
				},
			},
			settings = {
				basedpyright = {
					disableLanguageServices = false,
					disableOrganizeImports = false,
					disableTaggedHints = false,
					analysis = {
						diagnosticSeverityOverrides = {
							reportUnknownMemberType = false,
						},
						inlayHints = {
							variableTypes = false,
							callArgumentNames = false,
							callArgumentNamesMatching = false,
							functionReturnTypes = false,
							genericTypes = false,
						},
						useTypingExtensions = false,
						fileEnumerationTimeout = 10,
						autoImportCompletions = true,
						autoFormatStrings = true,
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly"
					},
				}
			}
		})

		local ensure_installed = {
			"ruff",
			"clangd",
			"basedpyright",
			"lua_ls",
		}

		require("mason").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ruff")
		-- vim.lsp.enable("pylsp")
		vim.lsp.enable("basedpyright")
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
				["<D-Up>"] = cmp.mapping.scroll_docs(-4),
				["<D-Down>"] = cmp.mapping.scroll_docs(4),
				["<D-/>"] = cmp.mapping.complete(),
				['<Tab>'] = cmp.mapping(
					function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }
				),
				['<S-Tab>'] = cmp.mapping(
					function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }
				),
			}),
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					col_offset = 0,
					side_padding = 0,
					scrollbar = true,
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					col_offset = 0,
					side_padding = 0,
					scrollbar = true,
				},
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
		})
	end,
}
