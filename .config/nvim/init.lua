vim.g.mapleader = " "
vim.g.netrw_banner = 0

-- Indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 2

vim.opt.termguicolors = true
vim.opt.colorcolumn = '100'

vim.opt.number = true
vim.opt.ruler = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backup = false
vim.opt.writebackup = false
-- ~/.local/state/nvim/undo/
vim.opt.undofile = true

vim.opt.autoread = true
vim.opt.scrolloff = 5

vim.opt.wildmenu = true
vim.opt.wildmode = { "list", "longest" }
vim.opt.wildignore = '*.png,*.jpg,*.jpeg,*.gif,*.o'

vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = "tab:»-"
vim.opt.updatetime = 100

vim.opt.diffopt:append('iwhite')
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- Key mapping
-- vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<cr>")
-- vim.keymap.set("n", "<Leader>e", ":tabe %%")

vim.keymap.set("i", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("v", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("s", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("x", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("c", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("o", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("l", "<C-k>", "<ESC>", { silent = true })
vim.keymap.set("t", "<C-k>", "<ESC>", { silent = true })

vim.keymap.set("n", "<S-h>", "^", { silent = true })
vim.keymap.set("n", "<S-l>", "$", { silent = true })

-- Move to right tab
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { silent = true })

-- Move to left tab
vim.keymap.set("n", "<C-p>", ":bprev<CR>", { silent = true })

-- Swap current tab and right tab
vim.keymap.set("n", "<M-n>", ":tabm +1<CR>", { silent = true })
vim.keymap.set("n", "<Leader>n", ":tabm +1<CR>", { silent = true })

-- Swap current tab and left tab
vim.keymap.set("n", "<M-p>", ":tabm -1<CR>", { silent = true })
vim.keymap.set("n", "<Leader>p", ":tabm -1<CR>", { silent = true })

-- Close current buffer
vim.keymap.set("n", "<C-c>", ":bd %<CR>", { silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Reload config
vim.keymap.set("n", "<Leader>R", ":source<CR>", { silent = true })

-- lazy.nvim
-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- C/C++
      lspconfig.clangd.setup({})

      -- Go
      lspconfig.gopls.setup({})

      -- Python
      lspconfig.pyright.setup({})
      lspconfig.ruff.setup({})

      -- Rust
      lspconfig.rust_analyzer.setup({})

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function ()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
        { { name = 'nvim_lsp' } },
        { { name = 'path' } }
        ),
      })
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        })
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      {'nvim-lua/plenary.nvim'}
    },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<C-l>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

      local telescopeConfig = require("telescope.config")
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<ESC>'] = actions.close,
              ['<C-u>'] = false,
            },
          },
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        }
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'RRethy/base16-nvim',
    },
    config = true,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function(lazy, opts)
      require('bufferline').setup(opts)
      -- Move to right tab
      vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>", { silent = true })

      -- Move to left tab
      vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>", { silent = true })

      -- Swap current tab and right tab
      vim.keymap.set("n", "<M-n>", ":BufferLineMoveNext<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>n", ":BufferLineMoveNext<CR>", { silent = true })

      -- Swap current tab and left tab
      vim.keymap.set("n", "<M-p>", ":BufferLineMovePrev<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>p", ":BufferLineMovePrev<CR>", { silent = true })
    end,
    opts = {
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        separator_style = "thin",
      }
    }
  },
  {
    'RRethy/base16-nvim',
    config = function()
      if vim.env.BASE16_THEME ~= nil then
        vim.cmd.colorscheme('base16-' .. vim.env.BASE16_THEME)
      else
        vim.cmd.colorscheme('base16-eighties')
      end
    end
  },
})
