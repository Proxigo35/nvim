return {
  {
    "johnseth97/codex.nvim",
    opts = {
      autoinstall = true,
    },
    keys = {
      {
        "<leader>v",
        function()
          require("codex").toggle()
        end,
        desc = " Toggle Codex",
      },
    },
  },
}
