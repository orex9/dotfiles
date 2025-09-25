return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      window = {
        width = 30,
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
        use_libuv_file_watcher = true,
      },
    }
  end,
}
