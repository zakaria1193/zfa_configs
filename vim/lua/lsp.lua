local lsp = require'lspconfig'

-- Python
lsp.pyright.setup{}

-- Dockerfile
lsp.dockerls.setup{}

-- Cmake
lsp.cmake.setup{}

-- Bash
lsp.bashls.setup{}

-- css
lsp.cssls.setup{cmd = { "css-languageserver", "--stdio" } }

-- html
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.html.setup { capabilities = capabilities }

-- Javascript / Typescript
lsp.tsserver.setup{}

--

-- Lua
--lsp.sumneko_lua.setup{}

-- C
--lsp.ccls.setup {
  --init_options = {
    --compilationDatabaseDirectory = "build";
    --index = {
      --threads = 2; -- default is 0 , we use 2 cores to speed up indexing
    --};
    --clang = {
      --excludeArgs = { "-frounding-math"} ;
    --};
  --}
--}
