function themify(scheme)
	colorscheme = scheme or "base16-onedark"
	vim.cmd.colorscheme(colorscheme)
end

themify()

-- keymap
vim.keymap.set("n", "<leader>td", function() themify("base16-onedark") end)
vim.keymap.set("n", "<leader>tl", function() themify("base16-one-light") end)

