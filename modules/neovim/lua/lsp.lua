local function bufmap(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- LSP settings
-- log file location: $HOME/.local/share/nvim/lsp.log
-- Add nvim-lspconfig plugin
local nvim_lsp = require 'lspconfig'


-- vim.lsp.set_log_level("debug")
local on_attach = function(_client, bufnr)

  local wk = require("which-key")

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  })

  -- local overridden_hover = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  local overridden_hover = vim.lsp.handlers.hover
  vim.lsp.handlers['textDocument/hover'] = function(...)
    local buf = overridden_hover(...)
    bufmap(buf, 'n', 'K', '<Cmd>wincmd p<CR>', { noremap = true, silent = true })
  end


  -- Mappings.
  local opts = { noremap = true, silent = true }

  wk.register({
    b = {
      f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Buffer" },
    },
    c = {  
      name = "Code",
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Actions" },
      l = { '<cmd>lua vim.lsp.codelens.run()<CR>', "Code Lens" },
      s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help" },
    },
    d = {
      name = "Document", 
      s =  { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbol" },
    },
    D = {
      name = "Diagnostics",
      b = { "<cmd>lua vim.diagnostic.setloclist()<CR>", 'Buffer diagnostics' },
      l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', "Line diagnostics" },
      a = { '<cmd>lua vim.diagnostic.setqflist()<CR>', "All workspace diagnostics" },
      e = { '<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>', "All workspace errors" },
      w = { '<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>', "All workspace warnings" },
      p = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', "Previous error" },
      n = { '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', "Next error" } ,
    },
    g = {
      name = "Go to...",
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
      D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
      i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
      r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References' },
      t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
    },
    r = {
        name = "Refactor",
        n = { 'cmd>lua vim.lsp.buf.rename()<CR>', "Rename" },
    },
    K = { '<Cmd>lua vim.lsp.buf.hover()<CR>', "Hover" },

  }, { prefix = "<localleader>", buffer = bufnr })

  -- DAP
  --bufmap(bufnr, "n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
  --bufmap(bufnr, "n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
  --bufmap(bufnr, "n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
  --bufmap(bufnr, "n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
  --bufmap(bufnr, "n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
  --bufmap(bufnr, "n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
  --bufmap(bufnr, "n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])

  FormatRange = function()
    local start_pos = vim.api.nvim_buf_get_mark(0, '<')
    local end_pos = vim.api.nvim_buf_get_mark(0, '>')
    vim.lsp.buf.range_formatting({}, start_pos, end_pos)
  end

  vim.cmd [[
    command! -range FormatRange  execute 'lua FormatRange()'
  ]]

  vim.cmd [[
    command! Format execute 'lua vim.lsp.buf.formatting()'
  ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  'clangd',
  'gopls',
  'rust_analyzer',
  'tsserver',
  'rnix',
  'hls',
  'pyright',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local pid = vim.fn.getpid()

local function on_cwd()
  return vim.loop.cwd()
end

-- TypeScript
--nvim_lsp.typescript.setup {
--  on_attach = on_attach, 
--  capabilities = capabilities,
--}
-- require("typescript").setup({
--    disable_commands = false, -- prevent the plugin from creating Vim commands
--    debug = false, -- enable debug logging for commands
--    server = { -- pass options to lspconfig's setup method
--        on_attach = ...,
--    },
--})

-- C# / .NET (Omnisharp)
local omnisharp_bin = "omnisharp"
nvim_lsp.omnisharp.setup{
    default_config = {
	filetypes = { 'cs', 'vb', 'fs', 'fsx', 'razor' },
	init_options = {},
    },
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    --root_dir = on_cwd,
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Lua 
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  cmd = { 'lua-language-server' },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 2000,
        preloadFileSize = 1000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.dartls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}


nvim_lsp.texlab.setup {
  on_attach = on_attach,
  settings = {
    latex = {
      rootDirectory = '.',
      build = {
        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '-pvc' },
        forwardSearchAfter = true,
        onSave = true,
      },
      forwardSearch = {
        executable = 'zathura',
        args = { '--synctex-forward', '%l:1:%f', '%p' },
        onSave = true,
      },
    },
  },
}

-- Metals
--
local metals_config = require("metals").bare_config()

metals_config.on_attach = function(client, bufnr)
  --require("metals").setup_dap()
  bufmap(bufnr, "n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
  on_attach(client, bufnr)
end


metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

--metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
--metals_config.on_attach = on_attach
metals_config.init_options.statusBarProvider = "on"


-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Rust bits

require('rust-tools').setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        --hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                --checkOnSave = {
                --    command = "clippy"
                --},
            }
        }
    },
})

-- For debugging when needed
-- vim.lsp.set_log_level("debug")

