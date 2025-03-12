return {
  -- snippets
  -- {
  --   'L3MON4D3/LuaSnip',
  --   dependencies = {
  --     'rafamadriz/friendly-snippets',
  --     config = function()
  --       require('luasnip.loaders.from_vscode').lazy_load()
  --       require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
  --       require('luasnip').filetype_extend('typescript', { 'javascript' })
  --       require('luasnip').filetype_extend('typescriptreact', { 'javascriptreact' })
  --     end,
  --   },
  --   opts = {
  --     history = true,
  --     delete_check_events = 'TextChanged',
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     {
  --       '<tab>',
  --       function()
  --         return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
  --       end,
  --       expr = true, silent = true, mode = 'i',
  --     },
  --     { '<tab>',   function() require('luasnip').jump(1) end,   mode = 's' },
  --     { '<s-tab>', function() require('luasnip').jump( -1) end, mode = { 'i', 's' } },
  --   },
  -- },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = 'deepseek',
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "TEN_DEEPSEEK_API_KEY",
          endpoint = "https://api.lkeap.cloud.tencent.com/v1",
          model = "deepseek-v3",
        },
      },
      -- auto_suggestions_provider = 'openai', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      -- openai = {
      --   endpoint = 'https://api.deepseek.com/v1',
      --   model = 'deepseek-chat',
      --   timeout = 30000, -- Timeout in milliseconds
      --   temperature = 0,
      --   max_tokens = 4096,
      --   -- ['local'] = false,
      --   api_key_name = 'DEEPSEEK_API_KEY',
      -- },
      -- file_selector = {
      --   provider = 'telescope',
      -- },
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
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
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
    'saghen/blink.cmp',
    dependencies = {
      -- 'rafamariz/friendly-snippets',
      'fang2hou/blink-copilot',



      'onsails/lspkind-nvim',
      'nvim-web-devicons',
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          draw = {
            gap = 2,
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local lspkind = require('lspkind')
                  lspkind.init({
                    symbol_map = {
                      Copilot = '',
                    },
                  })

                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = lspkind.symbolic(ctx.kind, {
                      mode = 'symbol',
                    })
                  end

                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },

            -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            -- nvim-cmp style menu
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
          },
        },
      },

      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-e: Hide menu
      -- C-k: Toggle signature help
      --
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'enter',
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },

        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },

        },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
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
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup({})
    end,
  },
  {
    'fedepujol/move.nvim',
    opts = {
      --- Config
    },
  },
}
