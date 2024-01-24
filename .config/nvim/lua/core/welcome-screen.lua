local M = {}

local header = {
	type = "text",
	val = {
		[[⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⢀⣀⣤⣤⠄⢀⣤⠀⣾⣿⣿⣿⠀⣀⠀⢠⣤⣤⣀⡀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⢀⣶⣿⣿⣿⠃⣰⣿⣿⣄⠙⠿⠿⠋⣠⣿⣷⡄⠹⣿⣿⣿⣶⡀⠀⠀⠀   ]],
		[[⠀   ⠀⣰⣿⣿⣿⣿⠇⢰⣿⣿⣿⣿⣷⣶⣶⣾⣿⣿⣿⣿⡀⢹⣿⣿⣿⣿⣄⠀⠀   ]],
		[[⠀   ⢸⣿⣿⡿⠋⠀⠀⣿⡏⠀⠙⠻⣿⣿⣿⣿⠟⠁⠀⣿⣧⠀⠀⠙⢿⣿⣿⡆⠀   ]],
		[[⠀   ⣿⣿⡿⠀⠀⠀⢰⣿⣿⣤⣤⣴⣿⣿⣿⣿⣦⣤⣴⣿⣿⠀⠀⠀⠈⣿⣿⡇⠀   ]],
		[[⠀   ⢹⣿⣇⠀⠀⠀⢸⣿⣿⣿⣿⣷⡙⠻⠟⢩⣿⣿⣿⣿⣿⠀⠀⠀⠀⣼⣿⡇⠀   ]],
		[[⠀   ⠈⠻⣿⣆⠀⠀⠈⠉⠉⠉⣿⣿⣷⡀⢠⣿⣿⡏⠉⠉⠉⠀⠀⠀⣰⣿⠟⠀⠀   ]],
		[[⠀   ⠀⠀⠈⠉⠓⠂⠀⠀⠀⠀⣿⣿⣿⣷⣿⣿⣿⡇⠀⠀⠀⠀⠐⠛⠉⠁⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢿⡟⠈⣿⡿⠈⢿⡇⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠀⠀⢠⣾⡆⠘⢀⡆⠸⠃⣠⠈⠃⢸⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠀⣰⣿⣿⡇⠀⣾⣷⠀⢀⣿⣧⠀⣼⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠸⣿⣿⣿⠇⠸⣿⣿⠀⠸⣿⣿⠆⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀   ]],
		[[⠀   ⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀   ]],
	},
	opts = {
		position = "center",
		hl = "Type",
	},
}

local function get_projects()
	local projects = require("telescope._extensions.project.utils").get_projects()

	local elements = {
		{ type = "text", val = "󰏓  Recent Projects:", opts = { position = "center", hl = "SpecialComment", width = 50 } },
		{ type = "padding", val = 1 },
	}
	for index, value in ipairs(projects) do
		if index == 9 then
			break
		end

		local id = tostring(index)

		local button = {
			type = "button",
			val = "    " .. value.title,
			shortcut = index,
			on_press = function()
				vim.fn.execute("cd " .. value.path, "silent")
				require("extensions.fuzzy-finder.finders").find_files()
			end,
			opts = {
				position = "center",
				shortcut = "[" .. id .. "]",
				cursor = 0,
				width = 50,
				align_shortcut = "left",
				hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #id + 1 }, { "Operator", #id + 1, #id + 2 } },
			},
		}

		table.insert(elements, button)
	end

	return elements
end

local function config()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	lua = require("telescope._extensions.project.utils").get_projects()
	local config = {
		layout = {
			{ type = "padding", val = 2 },
			header,
			{ type = "padding", val = 2 },
			{
				type = "group",
				val = get_projects(),
				opts = { spacing = 0 },
			},
			-- section.buttons,
			-- section.footer,
		},
		opt = {
			margin = 5,
		},
	}

	-- dashboard.section.buttons.val = {
	--   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	--   dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	-- }
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- dashboard.section.footer.val = fortune
	--
	-- dashboard.config.opts.noautocmd = true
	--
	-- vim.cmd([[autocmd User AlphaReady echo 'ready']])

	alpha.setup(config)
end

function M.get_plugin_specs()
	return {
		{
			"goolord/alpha-nvim",
			event = "VimEnter",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = config,
		},
	}
end

return M
