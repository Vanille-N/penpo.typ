#import "common.typ": *

#penpo.pakala.open()
#penpo.nimisin("Usawi", "usawi sona ale wile isipin")
#penpo.nimisin("Masi", "mun alasa sinpin ijo", _lili: 1)
#penpo.nimisin-mute(
  _lili: none,
  Eten: "esun tawa esun nena",
  Jutu: "jan uta toki uta",
  Wikipesija: "wile isipin ken isipin pona esun sona isipin jan ale",
  Sola: "suno o lukin ala",
  Mekuliju: "majuna e kule uta li insa jasima uta",
  Tela: "toki e lon ala",
  Olinpu: "o lukin insa nena pona unpa",
  Mon: "ma open nena",
  Mewika: "moku esun weka ilo kalama awen",
  Elopa: "esun lawa olin pona awen",
  Losi: "lanpan oko sewi insa",
  Nijon: "nasin ijo jan olin n",
  Loma: "lawa olin mi awen",
  Imalasi: "insa ma ala lon akesi suno ilo",
  Sonko: "soko open ni kiwen o",
  Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  Popo: "pi o pi o",
  Temo: "tawa e mi o",
  Inli: "insa n li ijo",
)

== General demo

#let words = segment("
= jan Usawi: ma pi lon ala

lon lawa la sina jo e sitelen ni
pali pi musi taso lon ma kasi pi monsi tomo mi
mi tu li toki e
sewi pi ma Eten
tenpo pini la
mi sona ala
e pilin sina
taso mi en

sitelen kule
pi sona ala
en mun lili mute
pi pilin sina
li kama lon ma ni
tawa tomo mi
sina lon insa
li ken ala lukin

jan li toki e olin 
sama ma pi lon ala
taso ona li
kama lon kepeken mi
o weka e selo sina
o pana e ale sina
o kute ala e ona
mi tu li o pali wile

mi tu li o pali wile
o kute ala e ona
mi tu li o pali wile

lon pilin la sina jo e olin tawa mi
mi ken ala sona e kule ona
taso mi lukin e ni
mi tu li toki e
pakala pi ma Eten
lon supa lape mi
li mama e ma pi pona ante 

seli laso en
kiwen suno en
usawi mute
mi li ijo pi wile sina

o luka e mi
ijo ante li
sewi ala a
lon tenpo ni

jan li toki e olin
sama ma pi lon ala
taso ona li
kama lon kepeken mi
jan ante ni li selo
li lukin e apeja taso
li suli ala tawa mi
mi tu li o pali wile

o open open e lupa
toki suwi pi uta mi
li awen, sina o kama
mi tu li o pali wile
seli li kama wawa
sewi li kama tawa mi
mi en sina li sama
mi tu li o pali wile

telo ike lon lawa
ni li olin tawa ona
ona li sona ala
nimi la olin li pona
mi lon poka sina
la ale li kama pona
mi tu li lape la
ijo pi lon ala li kama lon a

o open open e lupa
toki li ala lon uta mi
o awen ala, o kama
mi tu li o pali wile
seli li kama wawa
sewi li lon pakala ni
mi en sina li ale
mi tu li o pali wile

o kute ala e ona
mi tu li o pali wile
o alasa e pona
mi tu li o pali wile
lon ma pi lon ala a
mi tu li o pali wile
olin li lon ala la
mi tu li olin mute

tan: lipu Jutu ",
link("https://www.youtube.com/watch?v=Pnbd0-4rUGE")[`www.youtube.com/watch?v=Pnbd0-4rUGE`],
)


#show-hangul(words)

#let words = segment("
= mun Masi

suno mi la, mun Masi (toki Lasina:", ["Mārs"], ") li mun nanpa tu tu lon weka suno Sola.
ona li lili nanpa tu. mun Masi la mun Mekuliju taso li lili. ma Tela la, ona li lili.
ma pi mun Masi li jo e kiwen mute. ona li lete li jo e kon lili.
ona li loje lukin la, nimi ante ona li te mun loje to.
telo li lon ala ma Masi. taso, kiwen telo lete li lon. ona li jo e nena ma suli.
nena ma Olinpu Mon li nena ma nanpa wan lon ma Masu lon kulupu mun suno.
nimi pi mun Masi li sama e jan sewi tan nasin sewi Loma. jan sewi ni li jan sewi utala.

jan li tawa mun Masi ala. taso, ilo mun mute li tawa mun Masi.
ma Mewika en ma Elopa en ma Losi en ma Nijon en ma Imalasi en ma Sonko
~~ li tawa e ilo tawa mun Masi.
ilo li awen lon selo. ilo ante li ken tawa lon selo.
ilo Insanjuwisi (toki Inli:", ["Ingenuity"], ") li ken tawa lon kon.
ilo ante li tawa sike e mun Masi li pali e sitelen pi selo ona.

mun lili tu li sike e mun Masi. nimi ona li mun Popo li mun Temo.
ona li kiwen li sike lukin ala. 

tan: lipu Wikipesija",
link("https://wikipesija.org/wiki/mun_Masi")[`wikipesija.org/wiki/mun_Masi`],
)

#show-hangul(words)

== On voicedness

#let words = segment("
pakala --- taki --- kiwen --- tenpo
")

#show-hangul(words, voiced: true)
#show-hangul(words, voiced: false)

== On trailing-n segmentation

#let words = segment("
linja --- konwe --- Kenja --- Anja --- nja
")

#show-hangul(words, strict-cvn: true)
#show-hangul(words, strict-cvn: false)

#let words = segment("
pona a. mi kin li kama sona e sitelen Anku, taso mi sona ala e toki Anku.
lon lipu ", [GitHub], " la mi pali e ilo pi sitelen ante.
ni la mi wile sona e ni : sitelen Anku la nimi seme li pona ?")
#show-hangul(words)

#penpo.pakala.pini()

