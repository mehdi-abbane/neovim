vim.wo.number = true
vim.opt.pumheight = 10
vim.o.relativenumber = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"


local html_content = [[
<p>This is a <b>bold</b> text and this is <i>italic</i>.</p>
<p>Here is a <a href="https://neovim.io">link</a>.</p>
<p>This is <u>underlined</u>.</p>
<p>This is <color rgb="#FF0000">red text</color>.</p>
<hr>
<p>Line break after this:<br>New line.</p>
]]
