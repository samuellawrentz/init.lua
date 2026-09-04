local M = {}

local file = vim.fn.stdpath("config") .. "/.theme"

function M.apply()
  local ok, lines = pcall(vim.fn.readfile, file)
  local name = ok and lines[1] ~= "" and lines[1] or "rose-pine"
  if not pcall(vim.cmd.colorscheme, name) then vim.cmd.colorscheme("rose-pine") end
end

function M.pick()
  require("fzf-lua").colorschemes({
    actions = {
      ["default"] = function(selected)
        vim.cmd.colorscheme(selected[1])
        vim.fn.writefile({ selected[1] }, file)
        vim.notify("theme: " .. selected[1])
      end,
    },
  })
end

return M
