require("opencode-context").setup({
  -- Tmux settings
  tmux_target = nil,  -- Manual override: "main:1.0"
  auto_detect_pane = true,  -- Auto-find opencode pane in current window (default: true)
})