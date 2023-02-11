local lsp = require('lsp-zero')
lsp.preset('recommended')

-- needs 
lsp.ensure_installed({
    'bashls',
    'sumneko_lua',
    'dockerls',
    'elixirls',
    'emmet_ls',
    'html',
    'tsserver',
    'marksman',
    'pyright',
    'rust_analyzer',
    'tailwindcss',
    'rnix',
})

vim.opt.signcolumn = 'yes'

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- lsp.configure('elixirls', {
--   settings = {
--     suggestSpecs = false,
--     dialyzerEnabled = true,
--     signatureAfterComplete = false,
--     fetchDeps = false,
--     enableTestLenses = false,
--   },
-- })

lsp.setup()
