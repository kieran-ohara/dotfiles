require'nvim-web-devicons'.setup({})
require'colorizer'.setup()
require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'diff' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'diagnostics' },
    lualine_z = { '' },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = { '' },
    lualine_c = { '' },
    lualine_x = { '' },
    lualine_y = { '' },
    lualine_z = { '' },
  },
})
