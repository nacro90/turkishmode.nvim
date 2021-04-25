local core = {}

local charmaps = require('turkishmode.charmaps')
local log = require('turkishmode.log')
local unicode = require('turkishmode.unicode')
local patterns = require('turkishmode.patterns')

local len_context = 10

local function create_context_chars(chars, char_index)

   if char_index > #chars then return '' end

   local context = {' ', ' '}

   local start = math.max(1, char_index - len_context)
   local cursor = start
   for i = cursor, char_index - 1 do
      local cursor_char = chars[i]
      cursor_char = string.gsub(cursor_char, '[%p%s]', ' ')
      cursor_char = string.lower(cursor_char)
      local upcased_turkish = charmaps.upcase_marker_tbl[cursor_char]
      context[#context + 1] = upcased_turkish or cursor_char
   end

   context[#context + 1] = 'X'
   cursor = char_index + 1

   local limit = math.min(#chars, char_index + len_context)
   for i = cursor, limit do
      local cursor_char = chars[i]
      if string.find(cursor_char, '%W') then
         limit = i
         break
      end
      context[#context + 1] = string.lower(cursor_char)
   end

   context[#context + 1] = ' '

   return context, start, limit

end

local function has_pattern_match(chars, index)
   local char = chars[index]
   local asciified_char = charmaps.asciify_tbl[char] or char
   local char_patterns = patterns[string.lower(asciified_char)]

   if not char_patterns then return false end

   local min_rank = math.huge
   local context, start, limit = create_context_chars(chars, index)

   log.debug('context:', context)

   for i = 1, index - start + 3 do
      for j = index - start + 3, limit - start + 3 do
         local pattern_candidate = table.concat(context, '', i, j)
         local rank = char_patterns[pattern_candidate]
         if rank and math.abs(rank) < math.abs(min_rank) then
            min_rank = rank
         end
      end
   end

   return min_rank > 0
end

local function is_toggle_needed(chars, index)
   local char = chars[index]
   local asciified = charmaps.asciify_tbl[char] or char

   local is_need = has_pattern_match(chars, index)

   if asciified == 'I' then is_need = not is_need end
   if char ~= asciified then is_need = not is_need end

   return is_need

end

function core.toggle(char)
   return charmaps.toggle_tbl[char] or char
end

function core.deasciify(str)
   local toggle_tbl = charmaps.toggle_tbl
   local chars = unicode.chars(str)
   for i = 1, #chars do
      local char = chars[i]
      chars[i] = is_toggle_needed(chars, i) and toggle_tbl[char] or char
   end
   return table.concat(chars)
end

function core.asciify(str)
   local asciify_tbl = charmaps.asciify_tbl
   local asciified_chars = {}
   for i, uchar in unicode.enumerate(str) do
      asciified_chars[i] = asciify_tbl[uchar] or uchar
   end
   return table.concat(asciified_chars)
end

return core
