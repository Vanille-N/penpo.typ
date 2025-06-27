#import "common.typ": *

#penpo.pakala.open()
#penpo.nimisin("Eten", "esun tawa esun nena")
#penpo.nimisin("Usawi", "usawi sona ale wile isipin")

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
")

== General demo

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



#penpo.pakala.pini()

---


#let words = segment("
toki. sina ken ala ken toki pona kepeken sitelen Anku ?

mi wile sona e ijo.
")

#show-hangul(words)

