local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

create_autocmd("LspAttach", {
  group = create_augroup("LspConfig", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if
        client:supports_method("textDocument/formatting") or client:supports_method("textDocument/rangeFormatting")
    then
      create_autocmd("BufWritePre", {
        group = create_augroup("FormatOnSave", {}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Highlight yanked text
create_autocmd("TextYankPost", {
  group = create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

-- Conceal markup in markdown files
create_autocmd("FileType", {
  group = create_augroup("MarkdownConceal", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- Show diagnostics inline
vim.diagnostic.config({ virtual_text = true })
