local M = {}

local file = vim.fn.stdpath("config") .. "/.theme"

function M.load()
  local f = io.open(file, "r")
  if not f then return "rose-pine" end
  local name = f:read("*l")
  f:close()
  return name and #name > 0 and name or "rose-pine"
end

function M.save(name)
  local f = io.open(file, "w")
  if not f then return end
  f:write(name)
  f:close()
end

function M.apply()
  local ok = pcall(vim.cmd.colorscheme, M.load())
  if not ok then pcall(vim.cmd.colorscheme, "rose-pine") end
end

function M.pick()
  require("fzf-lua").colorschemes({
    actions = {
      ["default"] = function(selected)
        local name = selected[1]
        vim.cmd.colorscheme(name)
        M.save(name)
        vim.notify("theme: " .. name)
      end,
    },
  })
end

return M
