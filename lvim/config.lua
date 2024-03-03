lvim.format_on_save.enabled = true
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- python
	{ name = "black" },
	{ name = "isort" },
	-- lua
	{ name = "stylua" },
	-- golang
	{ name = "goimports" },
	{ name = "gofumpt" },
	-- shell
	{ name = "shfmt" },
	-- frontend
	{
		name = "prettier",
		args = { "--print-width", "100" },
		filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- python
	{ name = "flake8", filetypes = { "python" } },
	-- frontend
	{ name = "eslint", filetypes = { "javascript", "typescript" } },
	-- shell
	{
		name = "shellcheck",
		args = { "--severity", "warning" },
	},
	-- spell
	{ name = "codespell", filetypes = { "javascript", "python" } },
	-- json
	{ name = "jsonlint", filetypes = { "json" } },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "proselint",
	},
})

lvim.plugins = {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- language server
					"bash-language-server",
					"pyright",
					"lua-language-server",
					"vim-language-server",
					"marksman",
					"html-lsp",
					"typescript-language-server",
					"css-lsp",
					"json-lsp",
					-- formatter
					"black",
					"isort",
					"stylua",
					"shfmt",
					"prettier",
					-- linter
					"flake8",
					"eslint_d",
					"shellcheck",
					"codespell",
					"markdownlint",
					"proselint",
					"jsonlint",
					-- dap
					"debugpy",
				},
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					auto_trigger = true,
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			require("outline").setup()
		end,
	},
	"stevearc/dressing.nvim",
	-- python
	"AckslD/swenv.nvim",
	{ "microsoft/python-type-stubs" },
	{ "python/typeshed" },
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
			require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
		end,
	},
	"nvim-neotest/neotest",
	{
		"nvim-neotest/neotest-python",
		dependencies = "nvim-neotest/neotest",
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = {
							justMyCode = false,
							console = "integratedTerminal",
						},
						args = { "--log-level", "DEBUG", "--quiet" },
						runner = "pytest",
					}),
				},
			})
		end,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
				enabled = true,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc",
						},
					},
				},
			})
		end,
	},
	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_echo_preview_url = 1
		end,
	},
	-- frontend
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true,
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
}

lvim.autocommands = {
	{
		"FileType",
		{
			pattern = { "*.zsh" },
			callback = function()
				require("nvim-treesitter.highlight").attach(0, "bash")
			end,
		},
	},
}

lvim.builtin.which_key.vmappings["d"] = {
	name = "Debug",
	s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
}
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
	"Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	"Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	t = { "<cmd>TroubleToggle<cr>", "Toggle" },
	f = { "<cmd>TroubleToggle definitions<cr>", "Definitions" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
}
lvim.builtin.which_key.mappings["o"] = { "<cmd>Outline<cr>", "Toggle Outline" }
-- pyright with stubs
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local pluginsPath = join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt")
local opts = {
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "workspace",
			useLibraryCodeForTypes = true,
			stubPath = join_paths(pluginsPath, "python-type-stubs"),
			typeshedPath = join_paths(pluginsPath, "typeshed"),
		},
	},
}
require("lvim.lsp.manager").setup("pyright", opts)
-- do not show __pycache__
lvim.builtin.nvimtree.setup.filters.custom = { "__pycache__" }
