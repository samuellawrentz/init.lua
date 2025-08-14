local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescriptreact = { "biomejs" },
    json = { "biomejs" },
    jsonc = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

-- Auto-fix function using biome
local function biome_fix()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    
    if filename == "" then
        vim.notify("Buffer has no filename", vim.log.levels.WARN)
        return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local content = table.concat(lines, "\n")
    
    -- Use biome check --write for fixing
    local cmd = string.format("biome check --write --stdin-file-path %s", vim.fn.shellescape(filename))
    
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

-- Auto-fix on save for supported file types
vim.api.nvim_create_autocmd("BufWritePre", {
    group = lint_augroup,
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc" },
    callback = biome_fix,
})