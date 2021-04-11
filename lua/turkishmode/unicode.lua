local unicode = {}

local function iter(str) return str:gmatch('([%z\1-\127\194-\244][\128-\191]*)') end

function unicode.enumerate(str)
   return coroutine.wrap(function()
      local i = 1
      for uchar in iter(str) do
         coroutine.yield(i, uchar)
         i = i + 1
      end
   end)
end

function unicode.sub(str, i, j)
   local tbl = {}
   local cursor = 1
   local matcher = iter(str)
   while cursor < i do
      matcher()
      cursor = cursor + 1
   end
   repeat
      tbl[cursor - i + 1] = matcher()
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

function unicode.char_at(str, i)
   local cursor = 1
   local matcher = str:ugmatch()
   local uchar
   repeat
      uchar = matcher()
      cursor = cursor + 1
   until cursor > i or not uchar
   return uchar
end

unicode.iter = iter
return unicode
