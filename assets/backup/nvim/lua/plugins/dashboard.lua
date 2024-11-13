if true then
  return {}
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        header = {
          " _  _ ___ _____   _____ __  __ ",
          "| \\| | __/ _ \\ \\ / /_ _|  \\/  |",
          "| .` | _| (_) \\ V / | || |\\/| |",
          "|_|\\_|___\\___/ \\_/ |___|_|  |_|",
        },
        shortcut = {
          -- action can be a function type
          -- { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
        },
        center = {},
        packages = { enable = true }, -- show how many plugins neovim loaded
        footer = {},
        project = { enable = true, limit = 8 },
      },
      -- config
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
