local unicode = {}

local function iter(str) return str:gmatch('([%z\1-\127\194-\244][\128-\191]*)') end

local function enumerate(str)
   return coroutine.wrap(function()
      local i = 1
      for uchar in iter(str) do
         coroutine.yield(i, uchar)
         i = i + 1
      end
   end)
end

function unicode.sub(str, i, j)
   i = math.max(1, i)
   local tbl = {}
   local cursor = 1
   local iterator = iter(str)
   while cursor < i do
      iterator()
      cursor = cursor + 1
   end
   repeat
      tbl[cursor - i + 1] = iterator()
      cursor = cursor + 1
   until cursor > j
   return table.concat(tbl)
end

function unicode.len(str)
   local i = 0
   for _ in iter(str) do i = i + 1 end
   return i
end

function unicode.chars(str)
   local tbl = {}
   for char in iter(str) do tbl[#tbl + 1] = char end
   return tbl
end

function unicode.char_at_idx(str, i)
   if i < 1 then return '', i end
   local bytes = 1
   local next_bytes = 0
   for cursor, char in enumerate(str) do
      bytes = bytes + next_bytes
      next_bytes = #char
      if cursor == i then return char, bytes end
   end
   return '', bytes
end

unicode.iter = iter
unicode.enumerate = enumerate
return unicode
