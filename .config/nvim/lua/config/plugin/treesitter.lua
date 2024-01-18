return function()
  local configs = require("nvim-treesitter.configs")
  configs.setup {
    ensure_installed = { "html", "json", "c", "cpp", "css", "bash", "lua", "java", "python", "javascript", "latex", "markdown" },
    sync_install = false,
    auto_install = true,

    ignore_install = { },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" }
    },
  }
end
