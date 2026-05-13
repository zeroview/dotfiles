return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = false },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ name = "pi", focus = true })
      end,
      desc = "Sidekick Toggle Pi",
    },
    {
      "<leader>aA",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
  },
}
