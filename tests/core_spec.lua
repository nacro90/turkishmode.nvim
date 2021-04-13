local core = require('turkishmode.core')

local function eq(left, right) return assert.are.same(left, right) end

describe('Deasciification', function()

   it('Deasciify simple sentence 1', function()
      local input =
         'Acimasizca acelya gorunen bir sacmaliktansa acilip sacilmak...'
      local expected =
         'Acımasızca açelya görünen bir saçmalıktansa açılıp saçılmak...'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify simple sentence 2', function()
      local input = 'Acisindan bagirip cagirarak sacma sozler soylemek.'
      local expected =
         'Acısından bağırıp çağırarak saçma sözler söylemek.'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify heavy deasciification', function()
      local input = 'Bogurtuler opucukler.'
      local expected = 'Böğürtüler öpücükler.'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify with caps', function()
      local input = 'BUYUKCE BIR TOPAC TOPARLAGI VE DE YUMAGI yumagi.'
      local expected =
         'BÜYÜKÇE BİR TOPAÇ TOPARLAĞI VE DE YUMAĞI yumağı.'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify unusual text', function()
      local input = 'BUYUKCE      BIR  (--)   TOPAC /// TOPARLAGI\n\n VE DE YUMAGI yumagi.'
      local expected =
         'BÜYÜKÇE      BİR  (--)   TOPAÇ /// TOPARLAĞI\n\n VE DE YUMAĞI yumağı.'
      eq(core.deasciify(input), expected)
   end)


   it('Deasciify long text', function()
      local input =
         'Bilgisayarlarda uc adet bellek turu bulunur. Islemci icerisinde yer alan yazmaclar, son derece hizli ancak cok sinirli hafizaya sahiptirler. Islemcinin cok daha yavas olan ana bellege olan erisim gereksinimini gidermek icin kullanilirlar. Ana bellek ise Rastgele erisimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak uzere ikiye ayrilir. RAM\'a istenildigi zaman yazilabilir ve icerigi ancak guc surdugu surece korunur. ROM\'sa sâdece okunabilen ve onceden yerlestirilmis bilgiler icerir. Bu icerigi gucten bagimsiz olarak korur. Ornegin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanimini duzenleyen BIOS ROM\'da yer alir.'
      local expected =
         'Bilgisayarlarda üç adet bellek turu bulunur. İşlemci içerisinde yer alan yazmaçlar, son derece hızlı ancak çok sınırlı hafızaya sahiptirler. İşlemcinin çok daha yavaş olan ana bellege olan erişim gereksinimini gidermek için kullanılırlar. Ana bellek ise Rastgele erişimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak üzere ikiye ayrılır. RAM\'a istenildiği zaman yazılabilir ve içeriği ancak güç sürdüğü sürece korunur. ROM\'sa sâdece okunabilen ve önceden yerleştirilmiş bilgiler içerir. Bu içeriği güçten bağımsız olarak korur. Örneğin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanımını düzenleyen BİOS ROM\'da yer alır.'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify long and heavy deasciification with quotes', function()
      local input =
         '1969 yilinda 15 yasindayken 1000 lira transfer parasi alarak Camialti Spor Kulubu\'nde amator futbolcu oldu. Daha sonra IETT Spor Kulubu\'nun amator futbolcusu oldu. 1976 yilinda, IETT sampiyon oldugunda, Osman da bu takimda oynamaktaydi. Erokspor Kulubunde de futbola devam etti ve 16 yillik futbol yasamini 12 Eylul 1980 Askeri Darbesi sonrasinda birakti ve daha fazla siyasi faaliyet...'
      local expected =
         '1969 yılında 15 yaşındayken 1000 lira transfer parası alarak Camialtı Spor Kulübü\'nde amatör futbolcu oldu. Daha sonra İETT Spor Kulübü\'nün amatör futbolcusu oldu. 1976 yılında, İETT şampiyon olduğunda, Osman da bu takımda oynamaktaydı. Erokspor Kulübünde de futbola devam etti ve 16 yıllık futbol yaşamını 12 Eylül 1980 Askeri Darbesi sonrasında bıraktı ve daha fazla siyasi faaliyet...'
      eq(core.deasciify(input), expected)
   end)

   it('Deasciify with new line', function()
      local input = 'Dusman sizce\nuzulmeli mi yoksa uzumu\nbagindan mi yemeli?'
      local expected =
         'Düşman sizce\nüzülmeli mi yoksa üzümü\nbağından mı yemeli?'
      eq(core.deasciify(input), expected)
   end)

end)

describe('Asciification', function()

   it('Asciify simple sentence 1', function()
      local input =
         'Acımasızca açelya görünen bir saçmalıktansa açılıp saçılmak...'
      local expected =
         'Acimasizca acelya gorunen bir sacmaliktansa acilip sacilmak...'
      eq(core.asciify(input), expected)
   end)

   it('Asciify simple sentence 2', function()
      local input = 'Acısından bağırıp çağırarak saçma sözler söylemek.'
      local expected =
         'Acisindan bagirip cagirarak sacma sozler soylemek.'
      eq(core.asciify(input), expected)
   end)

   it('Asciify heavy deasciification', function()
      local input = 'Böğürtüler öpücükler.'
      local expected = 'Bogurtuler opucukler.'
      eq(core.asciify(input), expected)
   end)

   it('Asciify with caps', function()
      local input = 'BÜYÜKÇE BİR TOPAÇ TOPARLAĞI VE DE YUMAĞI yumağı.'
      local expected =
         'BUYUKCE BIR TOPAC TOPARLAGI VE DE YUMAGI yumagi.'
      eq(core.asciify(input), expected)
   end)

   it('Asciify long text', function()
      local input =
         'Bilgisayarlarda üç adet bellek turu bulunur. İşlemci içerisinde yer alan yazmaçlar, son derece hızlı ancak çok sınırlı hafızaya sahiptirler. İşlemcinin çok daha yavaş olan ana bellege olan erişim gereksinimini gidermek için kullanılırlar. Ana bellek ise Rastgele erişimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak üzere ikiye ayrılır. RAM\'a istenildiği zaman yazılabilir ve içeriği ancak güç sürdüğü sürece korunur. ROM\'sa sâdece okunabilen ve önceden yerleştirilmiş bilgiler içerir. Bu içeriği güçten bağımsız olarak korur. Örneğin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanımını düzenleyen BİOS ROM\'da yer alır.'
      local expected =
         'Bilgisayarlarda uc adet bellek turu bulunur. Islemci icerisinde yer alan yazmaclar, son derece hizli ancak cok sinirli hafizaya sahiptirler. Islemcinin cok daha yavas olan ana bellege olan erisim gereksinimini gidermek icin kullanilirlar. Ana bellek ise Rastgele erisimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak uzere ikiye ayrilir. RAM\'a istenildigi zaman yazilabilir ve icerigi ancak guc surdugu surece korunur. ROM\'sa sâdece okunabilen ve onceden yerlestirilmis bilgiler icerir. Bu icerigi gucten bagimsiz olarak korur. Ornegin herhangi bir veri veya komut RAM\'da bulunurken, bilgisayar donanimini duzenleyen BIOS ROM\'da yer alir.'
      eq(core.asciify(input), expected)
   end)

   it('Asciify long and heavy deasciification with quotes', function()
      local input =
         '1969 yılında 15 yaşındayken 1000 lira transfer parası alarak Camialtı Spor Kulübü\'nde amatör futbolcu oldu. Daha sonra İETT Spor Kulübü\'nün amatör futbolcusu oldu. 1976 yılında, İETT şampiyon olduğunda, Osman da bu takımda oynamaktaydı. Erokspor Kulübünde de futbola devam etti ve 16 yıllık futbol yaşamını 12 Eylül 1980 Askeri Darbesi sonrasında bıraktı ve daha fazla siyasi faaliyet...'
      local expected =
         '1969 yilinda 15 yasindayken 1000 lira transfer parasi alarak Camialti Spor Kulubu\'nde amator futbolcu oldu. Daha sonra IETT Spor Kulubu\'nun amator futbolcusu oldu. 1976 yilinda, IETT sampiyon oldugunda, Osman da bu takimda oynamaktaydi. Erokspor Kulubunde de futbola devam etti ve 16 yillik futbol yasamini 12 Eylul 1980 Askeri Darbesi sonrasinda birakti ve daha fazla siyasi faaliyet...'
      eq(core.asciify(input), expected)
   end)

   it('Asciify with new line', function()
      local input = 'Düşman sizce\nüzülmeli mi yoksa üzümü\nbağından mı yemeli?'
      local expected =
         'Dusman sizce\nuzulmeli mi yoksa uzumu\nbagindan mi yemeli?'
      eq(core.asciify(input), expected)
   end)

end)
