-- if true then
--   return {}
-- end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- plugins/telescope.lua:
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = { "VimEnter" },
    config = function()

      local function get_layout_config()
        local width = vim.o.columns
        if width > 200 then
          return {
            layout_strategy = 'horizontal',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_width = 0.5,
            }
          }
        else
          return {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              -- preview_height = 0.5,
              preview_cutoff = 20,
            }
          }
        end
      end

      local telescope = require("telescope")
      local actions = require('telescope.actions')

      telescope.setup {
        defaults = vim.tbl_deep_extend("force",
        {
          mappings = {
            i = {
              ["<C-c>"] = actions.close
            }
          }
        }, get_layout_config()),
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              }
            }
          }
        }
      }

      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {},
        },
      }
      require("telescope").load_extension("file_browser")
      vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>")
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
      }
      require('telescope').load_extension('fzf')
    end
  },
}
