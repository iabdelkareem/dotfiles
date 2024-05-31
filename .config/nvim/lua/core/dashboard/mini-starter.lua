local header = [[
  ⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⢀⣀⣤⣤⠄⢀⣤⠀⣾⣿⣿⣿⠀⣀⠀⢠⣤⣤⣀⡀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⢀⣶⣿⣿⣿⠃⣰⣿⣿⣄⠙⠿⠿⠋⣠⣿⣷⡄⠹⣿⣿⣿⣶⡀⠀⠀⠀   
	⠀   ⠀⣰⣿⣿⣿⣿⠇⢰⣿⣿⣿⣿⣷⣶⣶⣾⣿⣿⣿⣿⡀⢹⣿⣿⣿⣿⣄⠀⠀   
	⠀   ⢸⣿⣿⡿⠋⠀⠀⣿⡏⠀⠙⠻⣿⣿⣿⣿⠟⠁⠀⣿⣧⠀⠀⠙⢿⣿⣿⡆⠀   
	⠀   ⣿⣿⡿⠀⠀⠀⢰⣿⣿⣤⣤⣴⣿⣿⣿⣿⣦⣤⣴⣿⣿⠀⠀⠀⠈⣿⣿⡇⠀   
	⠀   ⢹⣿⣇⠀⠀⠀⢸⣿⣿⣿⣿⣷⡙⠻⠟⢩⣿⣿⣿⣿⣿⠀⠀⠀⠀⣼⣿⡇⠀   
	⠀   ⠈⠻⣿⣆⠀⠀⠈⠉⠉⠉⣿⣿⣷⡀⢠⣿⣿⡏⠉⠉⠉⠀⠀⠀⣰⣿⠟⠀⠀   
	⠀   ⠀⠀⠈⠉⠓⠂⠀⠀⠀⠀⣿⣿⣿⣷⣿⣿⣿⡇⠀⠀⠀⠀⠐⠛⠉⠁⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢿⡟⠈⣿⡿⠈⢿⡇⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠀⠀⢠⣾⡆⠘⢀⡆⠸⠃⣠⠈⠃⢸⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠀⣰⣿⣿⡇⠀⣾⣷⠀⢀⣿⣧⠀⣼⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠸⣿⣿⣿⠇⠸⣿⣿⠀⠸⣿⣿⠆⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀   
	⠀   ⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀   ]]

local function get_recent_projects()
	local projects = require("telescope._extensions.project.utils").get_projects()

	local items = {}
	for i = 1, 6, 1 do
		if projects[i] == nil then
			break
		end

		table.insert(items, {
			section = "󰏓  Recent Projects",
			name = projects[i].title,
			action = function()
				vim.fn.execute("cd " .. projects[i].path, "silent")
				require("extensions.fuzzy-finder.finders").find_files()
			end,
		})
	end

	return items
end

local function get_plugin_specs()
	return {
		{
			"echasnovski/mini.starter",
			version = "*",
			config = function()
				local starter = require("mini.starter")
				starter.setup({
					header = header,
					evaluate_single = true,
					items = {
						get_recent_projects(),
						starter.sections.builtin_actions(),
					},
				})
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
