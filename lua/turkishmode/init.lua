local turkishmode = {}

local core = require('turkishmode.core')
local unicode = require('turkishmode.unicode')

local api = vim.api

local fn = vim.fn

function turkishmode.deasciify_current_line()
   local cur_line = api.nvim_get_current_line()
   local deasciified = core.deasciify(cur_line)
   api.nvim_set_current_line(deasciified)
end

function turkishmode.asciify_current_line()
   local cur_line = api.nvim_get_current_line()
   local asciified = core.asciify(cur_line)
   api.nvim_set_current_line(asciified)
end

function turkishmode.deasciify_buffer(bufnr)
   bufnr = bufnr or api.nvim_get_current_buf()
   local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
   local buf_text = table.concat(lines, '\n')
   local deasciified = core.deasciify(buf_text)
   api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(deasciified, '\n'))
end

function turkishmode.asciify_buffer(bufnr)
   bufnr = bufnr or api.nvim_get_current_buf()
   local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
   for i = 1, #lines do lines[i] = core.asciify(lines[i]) end
   api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
end

local function get_line(bufnr, linenr)
   return unpack(api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, true))
end

function turkishmode.toggle_char_at(linenr, colnr)
   local bufnr = api.nvim_get_current_buf()
   local line = get_line(bufnr, linenr)
   local midright = line:sub(colnr + 1)
   local left = line:sub(1, colnr)
   local char = unicode.first(midright)
   local right = midright:sub(char:len() + 1)
   line = left .. core.toggle(char) .. right
   api.nvim_buf_set_lines(bufnr, linenr - 1, linenr, true, { line })
end

function turkishmode.toggle_current_char()
   local winnr = api.nvim_get_current_win()
   local linenr, colnr = unpack(api.nvim_win_get_cursor(winnr))
   turkishmode.toggle_char_at(linenr, colnr)
end

function turkishmode.deasciify_current_word()
   local winnr = api.nvim_get_current_win()
   local bufnr = api.nvim_get_current_buf()
   local linenr, colnr = api.nvim_win_get_cursor(winnr)
   local word = fn.expand('<cword>')
   word = core.deasciify(word)
   local line = get_line(bufnr, linenr)
end

function turkishmode.attach() end

-- function turkishmode.flush() end

-- function turkishmode.detach() end

return turkishmode
