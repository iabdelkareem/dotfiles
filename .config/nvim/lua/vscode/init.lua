if not require("utils").is_vscode() then
	return
end

local keymap_opts = function(desc) return { noremap = true, silent = true, nowait = true, desc = desc } end
local vscode = require("vscode-neovim")
vim.keymap.set("n", "-", function() vscode.call("workbench.action.closeActiveEditor") end, keymap_opts("Close"))
vim.keymap.set("n", "<leader>w", function() vscode.call("workbench.action.files.save") end, keymap_opts("Save"))
vim.keymap.set("n", "<leader>fe", function() vscode.call("workbench.files.action.focusFilesExplorer") end, keymap_opts("Files Explorer"))

vim.keymap.set("n", "L", function() vscode.call("workbench.action.nextEditorInGroup") end, keymap_opts("Next Editor"))
vim.keymap.set("n", "H", function() vscode.call("workbench.action.previousEditorInGroup") end, keymap_opts("Next Editor"))

vim.keymap.set("n", "<leader>cf", function() vscode.call("editor.action.formatDocument") end, keymap_opts("Format Document"))
vim.keymap.set("n", "gr", function() vscode.call("editor.action.referenceSearch.trigger") end, keymap_opts("Find References"))

vim.keymap.set("n", "<leader>ff", function() vscode.call("workbench.action.quickOpen") end, keymap_opts("Find File"))
vim.keymap.set("n", "<leader>fg", function() vscode.call("workbench.action.findInFiles") end, keymap_opts("Search in Files"))
