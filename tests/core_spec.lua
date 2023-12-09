local core = require "turkishmode.core"

local function eq(left, right)
  return assert.are.equals(left, right)
end

describe("Deasciification", function()
  it("Deasciify simple sentence 1", function()
    local input = "Acimasizca acelya gorunen bir sacmaliktansa acilip sacilmak..."
    local expected = "Acımasızca açelya görünen bir saçmalıktansa açılıp saçılmak..."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify simple sentence 2", function()
    local input = "Acisindan bagirip cagirarak sacma sozler soylemek."
    local expected = "Acısından bağırıp çağırarak saçma sözler söylemek."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify heavy deasciification", function()
    local input = "Bogurtuler opucukler."
    local expected = "Böğürtüler öpücükler."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify with caps", function()
    local input = "BUYUKCE BIR TOPAC TOPARLAGI VE DE YUMAGI yumagi."
    local expected = "BÜYÜKÇE BİR TOPAÇ TOPARLAĞI VE DE YUMAĞI yumağı."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify unusual text", function()
    local input = "BUYUKCE      BIR  (--)   TOPAC /// TOPARLAGI\n\n VE DE YUMAGI yumagi."
    local expected =
    "BÜYÜKÇE      BİR  (--)   TOPAÇ /// TOPARLAĞI\n\n VE DE YUMAĞI yumağı."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify long text", function()
    local input =
    "Bilgisayarlarda uc adet bellek turu bulunur. Islemci icerisinde yer alan yazmaclar, son derece hizli ancak cok sinirli hafizaya sahiptirler. Islemcinin cok daha yavas olan ana bellege olan erisim gereksinimini gidermek icin kullanilirlar. Ana bellek ise Rastgele erisimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak uzere ikiye ayrilir. RAM'a istenildigi zaman yazilabilir ve icerigi ancak guc surdugu surece korunur. ROM'sa sâdece okunabilen ve onceden yerlestirilmis bilgiler icerir. Bu icerigi gucten bagimsiz olarak korur. Ornegin herhangi bir veri veya komut RAM'da bulunurken, bilgisayar donanimini duzenleyen BIOS ROM'da yer alir."
    local expected =
    "Bilgisayarlarda üç adet bellek turu bulunur. İşlemci içerisinde yer alan yazmaçlar, son derece hızlı ancak çok sınırlı hafızaya sahiptirler. İşlemcinin çok daha yavaş olan ana bellege olan erişim gereksinimini gidermek için kullanılırlar. Ana bellek ise Rastgele erişimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak üzere ikiye ayrılır. RAM'a istenildiği zaman yazılabilir ve içeriği ancak güç sürdüğü sürece korunur. ROM'sa sâdece okunabilen ve önceden yerleştirilmiş bilgiler içerir. Bu içeriği güçten bağımsız olarak korur. Örneğin herhangi bir veri veya komut RAM'da bulunurken, bilgisayar donanımını düzenleyen BİOS ROM'da yer alır."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify long and heavy deasciification with quotes", function()
    local input =
    "1969 yilinda 15 yasindayken 1000 lira transfer parasi alarak Camialti Spor Kulubu'nde amator futbolcu oldu. Daha sonra IETT Spor Kulubu'nun amator futbolcusu oldu. 1976 yilinda, IETT sampiyon oldugunda, Osman da bu takimda oynamaktaydi. Erokspor Kulubunde de futbola devam etti ve 16 yillik futbol yasamini 12 Eylul 1980 Askeri Darbesi sonrasinda birakti ve daha fazla siyasi faaliyet..."
    local expected =
    "1969 yılında 15 yaşındayken 1000 lira transfer parası alarak Camialtı Spor Kulübü'nde amatör futbolcu oldu. Daha sonra İETT Spor Kulübü'nün amatör futbolcusu oldu. 1976 yılında, İETT şampiyon olduğunda, Osman da bu takımda oynamaktaydı. Erokspor Kulübünde de futbola devam etti ve 16 yıllık futbol yaşamını 12 Eylül 1980 Askeri Darbesi sonrasında bıraktı ve daha fazla siyasi faaliyet..."
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify with new line", function()
    local input = "Dusman sizce\nuzulmeli mi yoksa uzumu\nbagindan mi yemeli?"
    local expected = "Düşman sizce\nüzülmeli mi yoksa üzümü\nbağından mı yemeli?"
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify with new line 2", function()
    local input = "Sehre girmeden yol kenarinda agaclikli bir bahce gormus. "
        .. "Bahcenin ortasinda kocaman bir havuz varmis. Etrafta da kimsecikler yokmus.\n"
        .. "Gidip havuzun kenarina oturmus. Elleri titreye titreye ucuncu limonu cikarip kesmis.\n"
        .. "Bu sefer, icinden, evvelkilerden daha guzel, ayin ondordu gibi bir kiz cikmis. Baslamis:\n"
        .. "Su! Su! demeye…"
    local expected = "Şehre girmeden yol kenarında ağaçlıklı bir bahçe görmüş. Bahçenin ortasında kocaman bir havuz varmış. Etrafta da kimsecikler yokmuş.\n"
        .. "Gidip havuzun kenarına oturmuş. Elleri titreye titreye üçüncü limonu çıkarıp kesmiş.\n"
        .. "Bu sefer, içinden, evvelkilerden daha güzel, ayın ondördü gibi bir kız çıkmış. Başlamış:\n"
        .. "Şu! Şu! demeye…"
    eq(expected, core.deasciify(input))
  end)

  it("Deasciify with interesting punctuation", function()
    local input = "Baslamis: Su! Su! demeye…"
    local expected = "Başlamış: Şu! Şu! demeye…"
    eq(expected, core.deasciify(input))
  end)
end)

describe("Asciification", function()
  it("Asciify simple sentence 1", function()
    local input = "Acımasızca açelya görünen bir saçmalıktansa açılıp saçılmak..."
    local expected = "Acimasizca acelya gorunen bir sacmaliktansa acilip sacilmak..."
    eq(expected, core.asciify(input))
  end)

  it("Asciify simple sentence 2", function()
    local input = "Acısından bağırıp çağırarak saçma sözler söylemek."
    local expected = "Acisindan bagirip cagirarak sacma sozler soylemek."
    eq(expected, core.asciify(input))
  end)

  it("Asciify heavy deasciification", function()
    local input = "Böğürtüler öpücükler."
    local expected = "Bogurtuler opucukler."
    eq(expected, core.asciify(input))
  end)

  it("Asciify with caps", function()
    local input = "BÜYÜKÇE BİR TOPAÇ TOPARLAĞI VE DE YUMAĞI yumağı."
    local expected = "BUYUKCE BIR TOPAC TOPARLAGI VE DE YUMAGI yumagi."
    eq(expected, core.asciify(input))
  end)

  it("Asciify long text", function()
    local input =
    "Bilgisayarlarda üç adet bellek turu bulunur. İşlemci içerisinde yer alan yazmaçlar, son derece hızlı ancak çok sınırlı hafızaya sahiptirler. İşlemcinin çok daha yavaş olan ana bellege olan erişim gereksinimini gidermek için kullanılırlar. Ana bellek ise Rastgele erişimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak üzere ikiye ayrılır. RAM'a istenildiği zaman yazılabilir ve içeriği ancak güç sürdüğü sürece korunur. ROM'sa sâdece okunabilen ve önceden yerleştirilmiş bilgiler içerir. Bu içeriği güçten bağımsız olarak korur. Örneğin herhangi bir veri veya komut RAM'da bulunurken, bilgisayar donanımını düzenleyen BİOS ROM'da yer alır."
    local expected =
    "Bilgisayarlarda uc adet bellek turu bulunur. Islemci icerisinde yer alan yazmaclar, son derece hizli ancak cok sinirli hafizaya sahiptirler. Islemcinin cok daha yavas olan ana bellege olan erisim gereksinimini gidermek icin kullanilirlar. Ana bellek ise Rastgele erisimli bellek (REB veya RAM, Random Access Memory) ve Salt okunur bellek (SOB veya ROM, Read Only Memory) olmak uzere ikiye ayrilir. RAM'a istenildigi zaman yazilabilir ve icerigi ancak guc surdugu surece korunur. ROM'sa sâdece okunabilen ve onceden yerlestirilmis bilgiler icerir. Bu icerigi gucten bagimsiz olarak korur. Ornegin herhangi bir veri veya komut RAM'da bulunurken, bilgisayar donanimini duzenleyen BIOS ROM'da yer alir."
    eq(expected, core.asciify(input))
  end)

  it("Asciify long and heavy deasciification with quotes", function()
    local input =
    "1969 yılında 15 yaşındayken 1000 lira transfer parası alarak Camialtı Spor Kulübü'nde amatör futbolcu oldu. Daha sonra İETT Spor Kulübü'nün amatör futbolcusu oldu. 1976 yılında, İETT şampiyon olduğunda, Osman da bu takımda oynamaktaydı. Erokspor Kulübünde de futbola devam etti ve 16 yıllık futbol yaşamını 12 Eylül 1980 Askeri Darbesi sonrasında bıraktı ve daha fazla siyasi faaliyet..."
    local expected =
    "1969 yilinda 15 yasindayken 1000 lira transfer parasi alarak Camialti Spor Kulubu'nde amator futbolcu oldu. Daha sonra IETT Spor Kulubu'nun amator futbolcusu oldu. 1976 yilinda, IETT sampiyon oldugunda, Osman da bu takimda oynamaktaydi. Erokspor Kulubunde de futbola devam etti ve 16 yillik futbol yasamini 12 Eylul 1980 Askeri Darbesi sonrasinda birakti ve daha fazla siyasi faaliyet..."
    eq(expected, core.asciify(input))
  end)

  it("Asciify with new line", function()
    local input = "Düşman sizce\nüzülmeli mi yoksa üzümü\nbağından mı yemeli?"
    local expected = "Dusman sizce\nuzulmeli mi yoksa uzumu\nbagindan mi yemeli?"
    eq(expected, core.asciify(input))
  end)

  it("Toggle turkish char", function()
    local unicode_char = "ü"
    local expected_char = "u"
    eq(expected_char, core.toggle(unicode_char))
  end)

  it("Toggle ascii char that does not have mapping in turkish chars", function()
    local unicode_char = "k"
    local expected_char = "k"
    eq(expected_char, core.toggle(unicode_char))
  end)

  it("Toggle ascii char that has mapping in turkish chars", function()
    local unicode_char = "u"
    local expected_char = "ü"
    eq(expected_char, core.toggle(unicode_char))
  end)
end)
