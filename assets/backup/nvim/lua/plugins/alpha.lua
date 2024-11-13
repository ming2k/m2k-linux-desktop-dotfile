if true then
  return {}
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "goolord/alpha-nvim",
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    dashboard.section.header.opts = {
      position = "center",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button(
        "f",
        "  Find file",
        ":cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>"
      ),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("q", "󰿅  Quit", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = "Powered by Hero Ming PROUNDLY!"
    -- 发送遥测信息（可选）
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    -- 布局
    dashboard.config.layout = {
      { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
      dashboard.section.header,
      { type = "padding", val = 5 },
      dashboard.section.buttons,
      { type = "padding", val = 3 },
      dashboard.section.footer,
    }
    alpha.setup(dashboard.opts)

  end,
}
