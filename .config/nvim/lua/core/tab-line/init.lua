local M = {}

function M.get_plugin_specs()
	-- return require("core.tab-line.harpoon").get_plugin_specs()
	return require("core.tab-line.bufferline").get_plugin_specs()
end

return M
