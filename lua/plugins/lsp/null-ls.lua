-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
    formatting.clang_format,
    formatting.gofmt,
    formatting.goimports,
    formatting.goimports_reviser,
    formatting.golines,
    formatting.blue, -- python
    formatting.isort, -- sort imports alphabetically
    formatting.jq, -- json
    formatting.eslint,
    -- formatting.standardjs,
    formatting.stylua, -- lua formatter
    formatting.terrafmt, -- format terraform block in markdown
    formatting.terraform_fmt, -- terraform_fmt
    formatting.deno_fmt, -- will use the source for all supported file types
    formatting.deno_fmt.with({
      filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
    }),

    -- diagnostics
    diagnostics.npm_groovy_lint, -- lint, format and auto-fix groovy, jenkinsfile, and gradle files
    diagnostics.cpplint, --check c/c++ files for style issues following google's c++ style guide
    diagnostics.tfsec, -- security scanner for terraform code
    diagnostics.terraform_validate, -- terraform validate
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
      end,
    }),
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
