return {
  -- snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
        require('luasnip').filetype_extend('typescript', { 'javascript' })
        require('luasnip').filetype_extend('typescriptreact', { 'javascriptreact' })
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    -- stylua: ignore
    keys = {
      {
        '<tab>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true, silent = true, mode = 'i',
      },
      { '<tab>',   function() require('luasnip').jump(1) end,   mode = 's' },
      { '<s-tab>', function() require('luasnip').jump( -1) end, mode = { 'i', 's' } },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = 'openai',
      auto_suggestions_provider = 'openai', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      openai = {
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
        -- ['local'] = false,
        api_key_name = 'DEEPSEEK_API_KEY',
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = 'copen',
        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
        --- Disable by setting to -1.
        override_timeoutlen = 500,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make BUILD_FROM_SOURCE=true',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'main',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  --   },
  --   opts = {
  --     show_help = 'yes', -- Show help text for CopilotChatInPlace, default: yes
  --     debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
  --     disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
  --     language = 'Chinese', -- Copilot answer language settings when using default prompts. Default language is English.
  --     -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
  --     -- temperature = 0.1,
  --   },
  --   build = function()
  --     vim.cmd('UpdateRemotePlugins')
  --     vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
  --   end,
  --   event = 'VeryLazy',
  --   keys = {
  --     { '<leader>ccc', ':CopilotChat ', desc = 'CopilotChat - Chat start' },
  --     { '<leader>ccm', '<cmd>CopilotChat 是什么意思<cr>', desc = 'CopilotChat - code experimental' },
  --     { '<leader>ccb', ':CopilotChatBuffer ', desc = 'CopilotChat - Chat with current buffer' },
  --     { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
  --     { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
  --     {
  --       '<leader>ccn',
  --       '<cmd>CopilotChat 给这个变量命名<cr>',
  --       desc = 'CopilotChat - Variable naming',
  --     },
  --     {
  --       '<leader>ccd',
  --       '<cmd>CopilotChat 给这段代码补全注释<cr>',
  --       desc = 'CopilotChat - Variable naming',
  --     },
  --     {
  --       '<leader>ccf',
  --       '<cmd>CopilotChat 给这个方法命名<cr>',
  --       desc = 'CopilotChat - Function naming',
  --     },
  --     {
  --       '<leader>ccT',
  --       '<cmd>CopilotChatVsplitToggle<cr>',
  --       desc = 'CopilotChat - Toggle Vsplit', -- Toggle vertical split
  --     },
  --     {
  --       '<leader>ccx',
  --       ':CopilotChatInPlace<cr>',
  --       mode = 'x',
  --       desc = 'CopilotChat - Run in-place code',
  --     },
  --     {
  --       '<leader>ccr',
  --       '<cmd>CopilotChatReset<cr>', -- Reset chat history and clear buffer.
  --       desc = 'CopilotChat - Reset chat history and clear buffer',
  --     },
  --   },
  -- },
  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      -- lspkind
      'onsails/lspkind-nvim',
    },
    opts = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          {
            name = 'copilot',
            group_index = 1,
            priority = 100,
          },
          { name = 'nvim_lsp', max_item_count = 20 },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = {
              nvim_lsp = 'Lsp',
              luasnip = 'Snip',
              buffer = 'Buf',
              path = 'Path',
            },
            before = function(entry, vim_item)
              vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
              return vim_item
            end,
          }),
        },
        experimental = {
          ghost_text = false,
          -- ghost_text = {
          --   hl_group = 'LspCodeLens',
          -- },
        },
      }
    end,
  },

  -- auto pairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },

  -- surround
  {
    'echasnovski/mini.surround',
    config = function()
      -- use gz mappings instead of s to prevent conflict with leap
      require('mini.surround').setup({})
    end,
  },

  -- comments
  { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  },

  -- better text-objects
  {
    'echasnovski/mini.ai',
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = 'VeryLazy',
  },

  -- better cursors
  {
    'mg979/vim-visual-multi',
  },

  -- splitjoin
  {
    'AndrewRadev/splitjoin.vim',
  },
  {
    'bennypowers/splitjoin.nvim',
    lazy = true,
    keys = {
      {
        'gj',
        function()
          require('splitjoin').join()
        end,
        desc = 'Join the object under cursor',
      },
      {
        'g,',
        function()
          require('splitjoin').split()
        end,
        desc = 'Split the object under cursor',
      },
    },
  },

  -- change text case
  {
    'johmsalas/text-case.nvim',
    config = function()
      require('textcase').setup({})
    end,
  },
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'DiffviewOpen' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', desc = 'DiffviewFileHistory' },
    },
    opts = function()
      local close = require('diffview.actions').close
      return {
        keymaps = {
          view = {
            { 'n', 'q', close, desc = 'Close View' },
          },
          file_panel = {
            { 'n', 'q', close, desc = 'Close View' },
          },
          file_history_panel = {
            { 'n', 'q', close, desc = 'Close View' },
          },
        },
      }
    end,
  },
}
