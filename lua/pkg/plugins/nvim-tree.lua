return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()

		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1

		nvimtree.setup({
			view={
				width=30,
			},
			filters={
				custom={".DS_Store"},
			},
			disable_netrw=true,
			hijack_netrw=true,
			hijack_cursor=true,
			update_focused_file={
				enable=true,
				update_root=true,
			},
			root_dirs={"~"},
			prefer_startup_root=true,
			renderer = {
				highlight_git=true,
				indent_markers={
					enable=true,
					icons={
						corner="╰",
						edge="│",
						item="│",
						bottom="─",
						none=" ",
					},
				},
				icons={
					glyphs={
						git={
							unstaged="",
							staged="",
							unmerged="",
							renamed="→",
							untracked="",
							deleted="−",
							ignored= "◌",
						},
					},
				},
			},
		})

		api.tree.open({path="~"})
	end,
}
