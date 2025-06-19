{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      typescript-language-server
      tailwindcss-language-server
      nil
      prettierd
    ];

    extraLuaConfig = ''
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
      vim.opt.mouse = 'a'

      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      vim.opt.number = true
      vim.opt.relativenumber = false
      vim.opt.cursorline = true
      vim.opt.splitbelow = true
      vim.opt.splitright = true
      vim.opt.showmode = false
      vim.opt.wrap = false

      vim.opt.incsearch = true
      vim.opt.hlsearch = false
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      vim.opt.laststatus = 3
      vim.opt.termguicolors = true

      local opts = {
          noremap = true,
          silent = true,
      }

      vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
      vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
      vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
      vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

      vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
      vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
      vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
      vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

      vim.keymap.set('v', '<', '<gv', opts)
      vim.keymap.set('v', '>', '>gv', opts)

      vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>', opts)
      vim.keymap.set('n', '<A-s-c>', '<Cmd>BufferRestore<CR>', opts)

      vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

      vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

      local hardmode = true
      if hardmode then
          -- Show an error message if a disabled key is pressed
          local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

          -- Disable arrow keys in insert mode with a styled message
          vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('i', '<Del>', '<C-o>' .. msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('i', '<BS>', '<C-o>' .. msg, { noremap = true, silent = false })

          -- Disable arrow keys in normal mode with a styled message
          vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })
          vim.api.nvim_set_keymap('n', '<BS>', msg, { noremap = true, silent = false })
      end



      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.enable('nil_ls', capabilities)
      vim.lsp.enable('ts_ls', capabilities)
      vim.lsp.enable('tailwindcss', capabilities)

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup({
              options = {
                  theme = "16color",
              },
          })
        '';
      }
      vim-pandoc
      vim-pandoc-syntax
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
              highlight = {
                  enable = true,
              }
          }
        '';
      }
      vim-fugitive
      nvim-lspconfig
      nvim-web-devicons
      cord-nvim
      barbar-nvim
      nvim-lspconfig
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          require("conform").setup({
              formatters_by_ft = {
                  javascript = { "prettierd", "prettier", stop_after_first = true },
              },
              format_on_save = {
                  timeout_ms = 500,
                  lsp_format = "fallback",
              },
          })
        '';
      }
      neoscroll-nvim
      nvim-scrollview
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp_status, cmp = pcall(require, "cmp")
          if not cmp_status then
            return
          end

          cmp.setup({
              mapping = cmp.mapping.preset.insert({
                  ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                  ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                  ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                  ["<CR>"] = cmp.mapping.confirm({ select = false }),
              }),
              sources = cmp.config.sources({
                  { name = "nvim_lsp" }, -- LSP
                  { name = "buffer" }, -- text within the current buffer
                  { name = "path" }, -- file system paths
              }),
          })
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          -- Import nvim-autopairs safely
          local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
          if not autopairs_setup then
            return
          end

          -- Configure autopairs
          autopairs.setup({
            check_ts = true, -- Enable treesitter
            ts_config = {
              lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
              javascript = { "template_string" }, -- Don't add pairs in JavaScript template_string treesitter nodes
              java = false, -- Don't check treesitter on Java
            },
          })

          -- Import nvim-autopairs completion functionality safely
          local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
          if not cmp_autopairs_setup then
            return
          end

          -- Import nvim-cmp plugin safely (completions plugin)
          local cmp_setup, cmp = pcall(require, "cmp")
          if not cmp_setup then
            return
          end

          -- Make autopairs and completion work together
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        '';
      }
      tsc-nvim
      tailwind-tools-nvim
    ];
  };
}
