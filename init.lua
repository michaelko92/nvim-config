-- This is your Neovim configuration file in Lua

-- Set up packer.nvim for plugin management
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Language Server Protocol (LSP) configurations
  use 'neovim/nvim-lspconfig'

  -- Autocompletion plugin
  use 'hrsh7th/nvim-cmp'

  -- LSP-based snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Telescope and its file browser extension
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
    }
  }

  -- Enhanced status line
  use 'nvim-lualine/lualine.nvim'

  -- Enhanced buffer line
  use 'akinsho/bufferline.nvim'

  -- Git integration
  use 'lewis6991/gitsigns.nvim'

  -- Toggleable terminal window
  use 'akinsho/toggleterm.nvim'

  -- LSP Saga for a better UI
  use 'glepnir/lspsaga.nvim'

  -- Which-key for keybinding prompts
  use 'folke/which-key.nvim'

  -- Autopairs, integrates with nvim-cmp
  use 'windwp/nvim-autopairs'

  -- Color schemes
  use 'morhetz/gruvbox'

  -- Comments plugin
  use 'numToStr/Comment.nvim'
  
  -- Surround plugin, e.g., changing brackets, quotes
  use 'tpope/vim-surround'
end)

-- General settings
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.clipboard = 'unnamedplus'       -- Use the system clipboard

-- Telescope configuration
require('telescope').setup{
  extensions = {
    file_browser = {
      -- Configuration for file browser
    }
  }
}
-- Load Telescope file browser extension
require('telescope').load_extension('file_browser')

-- Lualine configuration
require('lualine').setup {
  options = {
    theme = 'gruvbox'
  }
}

-- Bufferline configuration
require('bufferline').setup{}

-- Gitsigns configuration
require('gitsigns').setup{}

-- Toggleterm configuration
require('toggleterm').setup{}

-- LSP Saga configuration
require('lspsaga').init_lsp_saga{}

-- Which-key configuration
require('which-key').setup{}

-- Nvim-autopairs configuration
require('nvim-autopairs').setup{}

-- Comment.nvim configuration
require('Comment').setup{}

-- Key mappings for LSP functions with LSP Saga
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua require\'lspsaga.hover\'.render_hover_doc()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gs', '<cmd>lua require\'lspsaga.signaturehelp\'.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require\'lspsaga.rename\'.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>', opts)

-- Key mappings for Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>Telescope file_browser<CR>', opts)

-- Key mappings for Toggleterm
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>ToggleTerm<CR>', opts)

-- Apply the gruvbox color scheme
vim.cmd[[colorscheme gruvbox]]

-- Autocompletion setup
-- You would need to configure nvim-cmp with a completion engine
-- Here is a placeholder for the configuration
-- require('cmp').setup{}

-- Nvim-autopairs integration with nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- Setup for LSP features like autocompletion, go-to-definition, etc.
-- Placeholder for LSP configuration
-- local lspconfig = require('lspconfig')
-- lspconfig.<language_server>.setup{
--   on_attach = on_attach,
--   -- Other language server specific settings
-- }

-- Import the nvim-lspconfig plugin's config module
local lspconfig = require('lspconfig')

-- Function to run every time an LSP server attaches to a buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- "K" to show hover information about the symbol under the cursor
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true, silent=true})

  -- "<leader>rn" to rename the symbol under the cursor
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap=true, silent=true})

  -- "gD" to jump to the definition
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap=true, silent=true})

  -- "gd" to jump to the definition
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=true})

  -- "gi" to list all implementations for the symbol under the cursor
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap=true, silent=true})

  -- "gr" to list all references for the symbol under the cursor
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap=true, silent=true})

  -- "[d" and "]d" to navigate through diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap=true, silent=true})

  -- "<leader>ca" to show code actions
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap=true, silent=true})

  -- "gl" to show line diagnostics
  buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap=true, silent=true})

  -- "F2" to rename the symbol under the cursor
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap=true, silent=true})
end

-- Python lsp server configuration
lspconfig.pyright.setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- Can be "off", "basic", or "strict"
      }
    }
  }
}
-- Comment.nvim key mappings to toggle comments
-- `gc` to comment out a line (works in normal and visual modes)
vim.api.nvim_set_keymap("n", "gc", ":CommentToggle<CR>", opts)
vim.api.nvim_set_keymap("v", "gc", ":CommentToggle<CR>", { noremap = true })

-- vim-surround key mappings are not needed, as the plugin uses vim's "operator pending" mode

-- Save the file with Ctrl + S
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', opts)
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', opts)

-- Additional example mappings
-- These are placeholders and can be replaced with actual commands and mappings as needed
-- vim.api.nvim_set_keymap('n', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('i', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('v', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('x', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('s', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('o', '<desired_key>', '<desired_command>', opts)

-- Ensure that you source this file or restart Neovim to apply the changes.

