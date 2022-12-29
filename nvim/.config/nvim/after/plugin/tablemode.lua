local ok, table_mode = pcall(require, "tablemode")
if not ok then
    return
end

tablemode.setup {}

vim.go [[ let g:table_mode_corner_corner='+' ]]
vim.go [[ let g:table_mode_header_fillchar='=' ]]
