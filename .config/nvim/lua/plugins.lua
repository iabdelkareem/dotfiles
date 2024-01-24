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
extend_plugin_specs(plugins, "theme")
extend_plugin_specs(plugins, "core")
extend_plugin_specs(plugins, "coding")
extend_plugin_specs(plugins, "extensions")

require("lazy").setup(plugins, { dev = { path = "~/personal/repos" } })

-- plenary
