vim.lsp.config("ocaml-lsp", {
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocamllex", "reason", "dune" },
  root_dir = vim.fs.root(0, { "dune-project", "dune-workspace", "*.opam" }),
})
