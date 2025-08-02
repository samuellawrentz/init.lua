local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Auto-fix function using eslint_d
local function eslint_fix()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  
  if filename == "" then
    vim.notify("Buffer has no filename", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, "\n")
  
  local cmd = string.format("eslint_d --stdin --fix-to-stdout --stdin-filename %s", vim.fn.shellescape(filename))
  
  local result = vim.fn.system(cmd, content)
  if vim.v.shell_error == 0 and result ~= content then
    local fixed_lines = vim.split(result, "\n")
    -- Remove trailing empty line if it exists
    if #fixed_lines > 0 and fixed_lines[#fixed_lines] == "" then
      table.remove(fixed_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, fixed_lines)
  end
end

-- Auto-fix on save for JS/TS files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lint_augroup,
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = eslint_fix,
})