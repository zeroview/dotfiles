-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Setup PowerShell to be the default terminal on Windows
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy Bypass -Command "
  vim.opt.shellxquote = ""
  vim.opt.shellquote = ""
  vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
end
