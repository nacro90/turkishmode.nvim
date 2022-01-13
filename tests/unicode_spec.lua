local unicode = require('turkishmode.unicode')

describe('unicode', function()

   it('Iterate unicode str with turkish chars', function()
      local unicode_str = 'öğret alım üzüme çalış'
      local expected = {
         'ö',
         'ğ',
         'r',
         'e',
         't',
         ' ',
         'a',
         'l',
         'ı',
         'm',
         ' ',
         'ü',
         'z',
         'ü',
         'm',
         'e',
         ' ',
         'ç',
         'a',
         'l',
         'ı',
         'ş',
      }
      local collected_chars = {}
      for char in unicode.iter(unicode_str) do
         collected_chars[#collected_chars + 1] = char
      end
      assert.are.same(expected, collected_chars)
   end)

   it('Iterate unicode str with ascii chars', function()
      local unicode_str = 'uzumlu kek'
      local expected = {'u', 'z', 'u', 'm', 'l', 'u', ' ', 'k', 'e', 'k'}
      local collected_chars = {}
      for char in unicode.iter(unicode_str) do
         collected_chars[#collected_chars + 1] = char
      end
      assert.are.same(expected, collected_chars)
   end)

   it('Enumerate chars of unicode str', function()
      local unicode_str = 'üzümlü kek'
      local expected_chars = {
         'ü',
         'z',
         'ü',
         'm',
         'l',
         'ü',
         ' ',
         'k',
         'e',
         'k',
      }
      local expected_i = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
      local collected_chars = {}
      local collected_i = {}
      for i, char in unicode.enumerate(unicode_str) do
         collected_chars[#collected_chars + 1] = char
         collected_i[#collected_i + 1] = i
      end
      assert.are.same(expected_chars, collected_chars)
      assert.are.same(expected_i, collected_i)
   end)

   it('Substring of unicode', function()
      local unicode_str = 'üzümlü kek'
      local expected = 'zümlü k'
      local result = unicode.sub(unicode_str, 2, 8)
      assert.are.equals(expected, result)
   end)

   it('Substring of ascii', function()
      local unicode_str = 'üzümlü kek'
      local expected = 'züml'
      local result = unicode.sub(unicode_str, 2, 5)
      assert.are.equals(expected, result)
   end)

   it('Negative substring start index', function()
      local unicode_str = 'üzümlü kek'
      local expected = 'üzüml'
      local result = unicode.sub(unicode_str, -3, 5)
      assert.are.equals(expected, result)
   end)

   it('Too big substring end index', function()
      local unicode_str = 'üzümlü kek'
      local expected = 'ümlü kek'
      local result = unicode.sub(unicode_str, 3, 24)
      assert.are.equals(expected, result)
   end)

   it('Length of unicode string', function()
      local unicode_str = 'öğret alım üzüme çalıştığı'
      local expected_chars = 26
      local chars_result = unicode.len(unicode_str)
      assert.are.equals(expected_chars, chars_result)
   end)

   it('Char table of unicode string', function()
      local unicode_str = 'üzümlü kek'
      local expected = {'ü', 'z', 'ü', 'm', 'l', 'ü', ' ', 'k', 'e', 'k'}
      local result = unicode.chars(unicode_str)
      assert.are.same(expected, result)
   end)

   it('Char at unicode str', function()
      local unicode_str = 'üzümlü kek'
      local expected_char = 'ü'
      local expected_byte_position = 4
      local result_char, result_byte_position = unicode.char_at_idx(unicode_str, 3)
      assert.are.equals(expected_char, result_char)
      assert.are.equals(expected_byte_position, result_byte_position)
   end)

   it('Char at negative index should be empty string', function()
      local unicode_str = 'üzümlü kek'
      local expected = ''
      local result = unicode.char_at_idx(unicode_str, -1)
      assert.are.same(expected, result)
   end)

   it('Char at too large index should be empty string', function()
      local unicode_str = 'üzümlü kek'
      local expected_char = ''
      local given_position = 27
      local expected_position = 13
      local result_char, result_byte_position = unicode.char_at_idx(unicode_str, given_position)
      assert.are.same(expected_char, result_char)
      assert.are.same(expected_position, result_byte_position)
   end)

   describe('is_ascii()', function()

      it('should return true when given an ascii byte', function()
         assert.is_true(unicode.is_ascii('a'))
      end)

      it('should return false when given an non-ascii char', function()
         assert.is_false(unicode.is_ascii('ü'))
      end)

   end)

   describe('first()', function()

      it('should return the first char when given ascii initial', function()
         local str = 'abcd'
         local expected = 'a'
         local actual = unicode.first(str)
         assert.are.equals(expected, actual)
      end)

      it('should return the first char when given non-ascii initial', function()
         local str = 'üzümlü'
         local expected = 'ü'
         local actual = unicode.first(str)
         assert.are.equals(expected, actual)
      end)

   end)

end)
