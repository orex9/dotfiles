return {
  require('lspconfig').ruff.setup {
    init_options = {
      settings = {
        lineLength = 150,
        lint = {
          ignore = { 'E501' },
        },
      },
    },
  },
}
