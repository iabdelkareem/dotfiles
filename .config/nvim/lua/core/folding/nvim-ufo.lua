local function add_folded_lines_number(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

local function goPreviousClosedAndPeek()
	local ufo = require("ufo")
	ufo.goPreviousClosedFold()
	ufo.peekFoldedLinesUnderCursor()
end

local function goNextClosedAndPeek()
	local ufo = require("ufo")
	ufo.goNextClosedFold()
	ufo.peekFoldedLinesUnderCursor()
end

-- TODO: Explore New Features And Re-Configure
local function get_plugin_specs()
	return {
		{
			"kevinhwang91/nvim-ufo",
			cond = not require("utils").is_vscode(),
			dependencies = "kevinhwang91/promise-async",
			config = function()
				vim.o.foldcolumn = "0" -- '0' is not bad
				vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
				vim.o.foldlevelstart = 99
				vim.o.foldenable = true

				local ufo = require("ufo")
				ufo.setup({
					fold_virt_text_handler = add_folded_lines_number,
				})
				vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
				vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
				vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except" })
				vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })
				vim.keymap.set("n", "]f", goNextClosedAndPeek, { desc = "Close folds with" })
				vim.keymap.set("n", "[f", goPreviousClosedAndPeek, { desc = "Close folds with" })

				-- vim.keymap.set("n", "K", function()
				-- 	local dap = require("dap")
				--
				-- 	if dap.session() then
				-- 		require("dap.ui.widgets").hover()
				-- 	elseif require("ufo").peekFoldedLinesUnderCursor() then
				-- 	elseif not vim.tbl_isempty(vim.lsp.get_active_clients({ bufnr = 0 })) then
				-- 		vim.lsp.buf.hover()
				-- 	else
				-- 		vim.api.nvim_feedkeys("K", "n", true)
				-- 	end
				-- end)
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
