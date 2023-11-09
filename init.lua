-- Set the leader key to space
vim.g.mapleader = ' '

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

  -- Telescope core plugin
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'}  -- Required dependency for Telescope
    }
  }

  -- Telescope fzf native plugin for fast sorting
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Telescope file browser extension
  use 'nvim-telescope/telescope-file-browser.nvim'

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

  -- Git commands
  use 'tpope/vim-fugitive'
end)

-- General settings
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.clipboard = 'unnamedplus'       -- Use the system clipboard

require('telescope').setup()

-- Load Telescope file browser extension and fzf
require('telescope').load_extension('file_browser')
require('telescope').load_extension('fzf')

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

-- Shortcut for setting key mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Telescope mappings
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)  -- Find files
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)  -- Live grep (search text in files)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)    -- List open buffers
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)   -- Search help tags
map('n', '<leader>fe', '<cmd>Telescope file_browser<CR>', opts) -- Open file browser

-- Git fugitive mappings
map('n', '<leader>gs', ':Git<CR>', opts)  -- Git status
map('n', '<leader>gc', ':Git commit<CR>', opts)  -- Git commit dialog
map('n', '<leader>gp', ':Git push<CR>', opts)  -- Git push
map('n', '<leader>gl', ':Git pull<CR>', opts)  -- Git pull
map('n', '<leader>gb', ':Git branch<CR>', opts)  -- List branches
map('n', '<leader>gd', ':Gdiffsplit<CR>', opts)  -- Git diff for the current file
map('n', '<leader>gr', ':Gread<CR>', opts)  -- Revert current file to last commit
map('n', '<leader>gw', ':Gwrite<CR>', opts)  -- Stage the current file
map('n', '<leader>gS', ':Git stash<CR>', opts)  -- Stash changes
map('n', '<leader>gA', ':Git add .<CR>', opts)  -- Stage all changes
map('n', '<leader>gP', ':Git stash pop<CR>', opts)  -- Apply stashed changes

-- LSP Saga mappings
map('n', 'gh', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>', opts) -- LSP finder
map('n', 'K', '<cmd>lua require\'lspsaga.hover\'.render_hover_doc()<CR>', opts) -- Hover documentation
map('n', 'gs', '<cmd>lua require\'lspsaga.signaturehelp\'.signature_help()<CR>', opts) -- Signature help
map('n', 'gr', '<cmd>lua require\'lspsaga.rename\'.rename()<CR>', opts) -- Rename symbol
map('n', 'gd', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>', opts) -- Preview definition
map('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>', opts) -- Jump to prev diagnostic
map('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>', opts) -- Jump to next diagnostic

-- ToggleTerm mappings
map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', opts)  -- Toggle terminal

-- Gitsigns mappings
-- These are provided by the plugin, but here are some examples:
map('n', '<leader>hn', '<cmd>lua require\'gitsigns\'.next_hunk()<CR>', opts) -- Next hunk
map('n', '<leader>hp', '<cmd>lua require\'gitsigns\'.prev_hunk()<CR>', opts) -- Prev hunk
map('n', '<leader>hs', '<cmd>lua require\'gitsigns\'.stage_hunk()<CR>', opts) -- Stage hunk
map('n', '<leader>hu', '<cmd>lua require\'gitsigns\'.undo_stage_hunk()<CR>', opts) -- Undo stage hunk
map('n', '<leader>hr', '<cmd>lua require\'gitsigns\'.reset_hunk()<CR>', opts) -- Reset hunk
map('n', '<leader>hR', '<cmd>lua require\'gitsigns\'.reset_buffer()<CR>', opts) -- Reset buffer
map('n', '<leader>hp', '<cmd>lua require\'gitsigns\'.preview_hunk()<CR>', opts) -- Preview hunk
map('n', '<leader>hb', '<cmd>lua require\'gitsigns\'.blame_line()<CR>', opts) -- Blame line

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
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  
  -- LSP Saga mappings (example)
  buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', opts)
  -- ... and more LSP Saga specific mappings
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


-- Additional example mappings
-- These are placeholders and can be replaced with actual commands and mappings as needed
-- vim.api.nvim_set_keymap('n', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('i', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('v', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('x', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('s', '<desired_key>', '<desired_command>', opts)
-- vim.api.nvim_set_keymap('o', '<desired_key>', '<desired_command>', opts)

-- Ensure that you source this file or restart Neovim to apply the changes.

