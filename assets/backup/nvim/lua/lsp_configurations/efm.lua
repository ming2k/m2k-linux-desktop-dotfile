return {
  init_options = {documentFormatting = true},
  filetypes = {"markdown"},
  settings = {
    -- rootMarkers = {".git/"},
    languages = {
      markdown = {
        {
          formatCommand = "prettier --stdin-filepath ${INPUT}",
          formatStdin = true
        },
        {
          lintCommand = "markdownlint -s",
          lintStdin = true,
          lintFormats = {
            "%f:%l %m",
            "%f:%l:%c %m",
            "%f: %l: %m"
          }
        }
      }
    }
  }
}
