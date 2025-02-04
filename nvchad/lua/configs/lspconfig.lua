-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  ruff = {},
  jedi_language_server = {},
  clangd = {},
  lua_ls = {},
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for lsp, opts in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = opts,
  }
end
