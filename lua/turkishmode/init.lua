local turkishmode = {}

local core = require "turkishmode.core"

local api = vim.api

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
  local buf_text = table.concat(lines, "\n")
  local deasciified = core.deasciify(buf_text)
  api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(deasciified, "\n"))
end

function turkishmode.asciify_buffer(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
  for i = 1, #lines do
    lines[i] = core.asciify(lines[i])
  end
  api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
end

function turkishmode.attach() end

function turkishmode.flush() end

function turkishmode.detach() end

return turkishmode
