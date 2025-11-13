-- Disable ts_ls formatting - use prettier (via efm) for formatting
return {
  on_attach = function(client)
   client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
