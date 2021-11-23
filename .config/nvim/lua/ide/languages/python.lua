local M = {}

function M.get_lsp_configs()
	return {
		pylsp = {},
	}
end

function M.get_plugin_specs()
	return {
		{
			"mfussenegger/nvim-dap-python",
			ft = "python",
			config = function()
				local mason = require("mason-registry")
				local package = mason.get_package("debugpy")
				if package:is_installed() == false then
					package:install()
				end
				require("dap-python").setup(package:get_install_path() .. "/venv/bin/python")
			end,
		},
	}
end

return M
