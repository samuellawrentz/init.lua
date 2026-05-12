local M = {}

local function find_repos(root)
  local out = vim.fn.systemlist({
    "find", root, "-maxdepth", "4", "-type", "d", "-name", ".git", "-prune",
  })
  local repos = {}
  for _, git_dir in ipairs(out) do
    table.insert(repos, vim.fn.fnamemodify(git_dir, ":h"))
  end
  return repos
end

local function changed_files(repo)
  local lines = vim.fn.systemlist({ "git", "-C", repo, "status", "--porcelain" })
  local files = {}
  for _, line in ipairs(lines) do
    local status, path = line:match("^(..)%s+(.+)$")
    if path then
      path = path:gsub('^"', ''):gsub('"$', '')
      local arrow = path:find(" %-> ")
      if arrow then path = path:sub(arrow + 4) end
      table.insert(files, { repo = repo, path = path, status = vim.trim(status) })
    end
  end
  return files
end

function M.pick()
  local cwd = vim.fn.getcwd()
  local repos = find_repos(cwd)
  if #repos == 0 then
    vim.notify("no git repos under " .. cwd, vim.log.levels.WARN)
    return
  end

  local entries, lookup = {}, {}
  for _, repo in ipairs(repos) do
    local rel_repo = vim.fn.fnamemodify(repo, ":t")
    for _, f in ipairs(changed_files(repo)) do
      local label = string.format("%s  %s › %s", f.status, rel_repo, f.path)
      table.insert(entries, label)
      lookup[label] = f
    end
  end

  if #entries == 0 then
    vim.notify("no changes across " .. #repos .. " repos", vim.log.levels.INFO)
    return
  end

  require("fzf-lua").fzf_exec(entries, {
    prompt = "WorkspaceDiff> ",
    actions = {
      ["default"] = function(selected)
        local f = lookup[selected[1]]
        if not f then return end
        vim.cmd("edit " .. vim.fn.fnameescape(f.repo .. "/" .. f.path))
        vim.cmd("Gitsigns diffthis")
      end,
    },
  })
end

return M
