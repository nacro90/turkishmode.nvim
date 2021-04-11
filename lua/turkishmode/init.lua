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

function turkishmode.test()
   local inputs = {
      'Acimasizca acelya gorunen bir sacmaliktansa acilip sacilmak...',
      'Acisindan bagirip cagirarak sacma sozler soylemek.',
      'Bogurtuler opucukler.',
      'BUYUKCE BIR TOPAC TOPARLAGI VE DE YUMAGI yumagi.',
      'Bilgisayarlarda uc adet bellek turu bulunur. Islemci icerisinde yer alan yazmaclar, son derece hizli ancak cok sinirli hafizaya sahiptirler. Islemcinin cok daha yavas olan ana bellege olan erisim gereksinimini gidermek icin kullanilirlar. Ana bellek ise Rastgele erisimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak uzere ikiye ayrilir. RAM\'a istenildigi zaman yazilabilir ve icerigi ancak guc surdugu surece korunur. ROM\'sa sâdece okunabilen ve onceden yerlestirilmis bilgiler icerir. Bu icerigi gucten bagimsiz olarak korur. Ornegin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanimini duzenleyen BIOS ROM\'da yer alir.',
      '1969 yilinda 15 yasindayken 1000 lira transfer parasi alarak Camialti Spor Kulubu\'nde amator futbolcu oldu. Daha sonra IETT Spor Kulubu\'nun amator futbolcusu oldu. 1976 yilinda, IETT sampiyon oldugunda, Osman da bu takimda oynamaktaydi. Erokspor Kulubunde de futbola devam etti ve 16 yillik futbol yasamini 12 Eylul 1980 Askeri Darbesi sonrasinda birakti ve daha fazla siyasi faaliyet...',
   }
   local expecteds = {
      'Acımasızca açelya görünen bir saçmalıktansa açılıp saçılmak...',
      'Acısından bağırıp çağırarak saçma sözler söylemek.',
      'Böğürtüler öpücükler.',
      'BÜYÜKÇE BİR TOPAÇ TOPARLAĞI VE DE YUMAĞI yumağı.',
      'Bilgisayarlarda üç adet bellek turu bulunur. İşlemci içerisinde yer alan yazmaçlar, son derece hızlı ancak çok sınırlı hafızaya sahiptirler. İşlemcinin çok daha yavaş olan ana bellege olan erişim gereksinimini gidermek için kullanılırlar. Ana bellek ise Rastgele erişimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak üzere ikiye ayrılır. RAM\'a istenildiği zaman yazılabilir ve içeriği ancak güç sürdüğü sürece korunur. ROM\'sa sâdece okunabilen ve önceden yerleştirilmiş bilgiler içerir. Bu içeriği güçten bağımsız olarak korur. Örneğin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanımını düzenleyen BİOS ROM\'da yer alır.',
      '1969 yılında 15 yaşındayken 1000 lira transfer parası alarak Camialtı Spor Kulübü\'nde amatör futbolcu oldu. Daha sonra İETT Spor Kulübü\'nün amatör futbolcusu oldu. 1976 yılında, İETT şampiyon olduğunda, Osman da bu takımda oynamaktaydı. Erokspor Kulübünde de futbola devam etti ve 16 yıllık futbol yaşamını 12 Eylül 1980 Askeri Darbesi sonrasında bıraktı ve daha fazla siyasi faaliyet...',
   }

   for i, input in ipairs(inputs) do
      local result = core.deasciify(input)
      if result ~= expecteds[i] then
         log.error('test failed for', i, ':: expected:', expecteds[i],
            ', result:', result)
      end
   end
end

function turkishmode.attach() end

function turkishmode.flush() end

function turkishmode.detach() end

return turkishmode
