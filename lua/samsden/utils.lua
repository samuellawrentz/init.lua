local M = {}

-- Create autocommand groups based on the passed definitions
function M.define_augroups(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	-- Each definition should contain: trigger, pattern, command
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

M.define_augroups({
	_general_settings = {
		{ "TextYankPost", "*", "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})" },
		{ "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
		{ "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
		{ "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
		{ "VimLeavePre", "*", "set title set titleold=" },
	},
	_filetypedetect = {
		{ "BufNewFile,BufFilePre,BufRead", "*.mdx", "set filetype=markdown" },
	},
	_markdown = { { "FileType", "markdown", "setlocal wrap" }, { "FileType", "markdown", "setlocal spell" } },
	_auto_resize = {
		{ "VimResized", "*", "wincmd =" },
	},
	_qf = {
		{ "FileType", "qf", "set nobuflisted" },
	},
})



return M
