function SplitPrompt()
    local choice = vim.fn.input("Split direction (w=top, s=bottom, d=right, a=left): ")
    if choice == "w" then
        vim.cmd("split")
    elseif choice == "s" then
        vim.cmd("split")
        vim.cmd("wincmd j")
    elseif choice == "d" then
        vim.cmd("vsplit")
    elseif choice == "a" then
        vim.cmd("vsplit")
        vim.cmd("wincmd h")
    else
        print("Invalid choice! Use w, s, d, or a.")
    end
end

return SplitPrompt
