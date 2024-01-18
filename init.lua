-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

os.setlocale "en_US.UTF-8"

vim.opt.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  tab = "▷─",
  trail = "~",
  space = "⋅",
  eol = "↵",
}
vim.opt.list = true
vim.o.exrc = true

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatStatus", function()
  local message = ""

  if vim.b.disable_autoformat or vim.g.disable_autoformat then
    message = "autoformat-on-save `disabled` globally"
  else
    message = "autoformat-on-save `enabled` globally"
  end

  require("lazy.util").info(message, { title = "conform.nvim", lang = "markdown" })
end, {
  desc = "Print autoformat-on-save status",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    require("lazygit.utils").project_root_dir()
  end,
})
