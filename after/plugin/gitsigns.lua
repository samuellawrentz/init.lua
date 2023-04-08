require('gitsigns').setup {
  word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 5000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 500,
  max_file_length = 10000, -- Disable if file is longer than this (in lines)
}
