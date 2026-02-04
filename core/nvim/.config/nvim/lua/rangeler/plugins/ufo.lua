return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        local icons = require 'rangeler.utils.icons'
        local ok, ufo = pcall(require, 'ufo')
        if not ok then
            return
        end
        ufo.setup {
            open_fold_hl_timeout = 150,
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local foldedLines = endLnum - lnum
                local suffix = ('  ' .. '󱦶' .. ' ' .. '%d lines'):format(foldedLines)
                local suffixWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - suffixWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local text = chunk[1]
                    local hl = chunk[2]
                    local chunkWidth = vim.fn.strdisplaywidth(text)

                    if curWidth + chunkWidth <= targetWidth then
                        table.insert(newVirtText, { text, hl })
                        curWidth = curWidth + chunkWidth
                    else
                        text = truncate(text, targetWidth - curWidth)
                        table.insert(newVirtText, { text, hl })
                        break
                    end
                end

                table.insert(newVirtText, { suffix, 'Comment' })
                return newVirtText
            end,
        }
    end,
}
