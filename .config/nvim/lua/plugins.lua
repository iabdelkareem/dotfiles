local function ensure_lazy_nvim_installed()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

local function extend_plugin_specs(table, module)
	if type(module) == "string" then
		module = require(module)
	end

	return vim.list_extend(table, module.get_plugin_specs())
end

vim.u.extend_plugin_specs = extend_plugin_specs

ensure_lazy_nvim_installed()

local plugins = {}
extend_plugin_specs(plugins, "keymaps")
extend_plugin_specs(plugins, "theme")
extend_plugin_specs(plugins, "file-tree")
extend_plugin_specs(plugins, "motions")
extend_plugin_specs(plugins, "tabline")
extend_plugin_specs(plugins, "statusline")
extend_plugin_specs(plugins, "window")
extend_plugin_specs(plugins, "finder")
extend_plugin_specs(plugins, "sessions")
extend_plugin_specs(plugins, "terminal")
extend_plugin_specs(plugins, "git")
extend_plugin_specs(plugins, "ide")
extend_plugin_specs(plugins, "search")
extend_plugin_specs(plugins, "quickfix")
extend_plugin_specs(plugins, "save")
extend_plugin_specs(plugins, "extensions")
extend_plugin_specs(plugins, "folding")
extend_plugin_specs(plugins, "startup")

require("lazy").setup(plugins, { dev = { path = "~/personal/repos" } })

-- plenary
