-- change default mappings
local list = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  { key = "h",                                 action = "close_node" },
  { key = "p",                                 action = "preview" },
  { key = "<C-r>",                             action = "refresh" },
  { key = "<C-x>",                             action = "split" },
  { key = "<C-v>",                             action = "vsplit" },
  { key = "<C-t>",                             action = "tabnew" },
  { key = "yn",                                action = "copy_name" },
  { key = "yp",                                action = "copy_path" },
  { key = "yy",                                action = "copy_absolute_path" },
  { key = "a",                                 action = "create" },
  { key = "d",                                 action = "remove" },
  { key = "r",                                 action = "rename" },
  { key = "?",                                 action = "toggle_help" },
}

require'nvim-tree'.setup {
  view = {
    side = 'left',
    mappings = {
      custom_only = true,
      list = list
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = false,
      }
    }
  }
}
