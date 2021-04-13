local turkishmode = {}

local log = require('turkishmode.log')
local unicode = require('turkishmode.unicode')
local charmaps = require('turkishmode.charmaps')

local core = require('turkishmode.core')

local uv = vim.loop
local api = vim.api

function turkishmode.deasciify_current_line()
   local cur_line = api.nvim_get_current_line()
   local deasciified = core.deasciify(cur_line)
   api.nvim_set_current_line(deasciified)
end

function turkishmode.deasciify_buffer(bufnr)
   bufnr = bufnr or api.nvim_get_current_buf()
   local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
   print(core.deasciify(table.concat(lines, '\n')))
end

function turkishmode.asciify_buffer(bufnr)
   bufnr = bufnr or api.nvim_get_current_buf()
   local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
   for i = 1, #lines do lines[i] = core.asciify(lines[i]) end
   api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
end

function turkishmode.timeit()
   local f = io.open('masal.txt', 'r')
   local str = f:read('*a')
   local start = os.clock()
   core.deasciify(str)
   local finish = os.clock()
   print('time:', finish - start)
   f:close()
end

function turkishmode.attach() end

function turkishmode.flush() end

function turkishmode.detach() end

return turkishmode
