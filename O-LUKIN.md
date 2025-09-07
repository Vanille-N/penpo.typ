# nasin lipu penpo

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)

o pona e lipu sina a!

o lukin e [lipu pi pana sona (toki Inli)](docs/main.pdf).

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="logo/penpo-dark.svg">
  <img alt="penpo" src="logo/penpo-light.svg">
</picture>

---

nimi "penpo" li sama "toki pona taso."

## nasin penpo li seme?

nasin lipu penpo li ilo sitelen.
kepeken lipu konwe "Typst" /taɪpst/ la ona li ken pali e lipu
pi pona lukin sama lipu "sama-ni/lipu.pdf".

kepeken "penpo", la...
- sina ken sitelen e lipu wan taso, li kama jo e lipu pi
  sitelen Lasina en sitelen pona lon poka.
- sina ken alasa e pakala lili ale kepeken wawa lili.
- nanpa wan la nimi jan li kama sitelen ale,
  taso nanpa tu en mute la sitelen lili nanpa wan taso
  li kama sitelen. sama lipu su.

sina wile sona e nasin pi kepeken "penpo",
la o lukin e lipu "sama-ni/lipu.typ" en
lipu mute lon "sama-ni/" kin.

## wile tan nasin penpo

- sina wile jo e nasin sitelen
  ["sitelen seli kiwen"](https://www.kreativekorp.com/software/fonts/sitelenselikiwen/).
  ona li ken sitelen pona.
  o pana e lipu ".ttf" lon poka pi lipu sina.

## o lukin

```typ
#import "@preview/penpo:0.1.0"

// pakala lili li lon lipu ni la ona li kama sitelen tan ni
#penpo.pakala.open()

// nimi "penpo" en nimi "namako" li pakala ala
#penpo.o-oke-e-nimi("penpo", "namako")

// nimi Newen li kepeken e sitelen "namako en weka en namako" lon sitelen pona
#penpo.nimisin("Newen", "namako en weka en namako", _lili: "namako namako")

// o sitelen e toki ale kepeken sitelen Lasina en sitelen pona lon poka ona.
#show par: pp => [
  #table(columns: (1fr, 1fr), stroke: none,
    penpo.lasina.sitelen[#pp],
    penpo.pona.sitelen[#pp],
  )
]

toki a!
mi jan Newen.

mi pali e lipu ni tan ni: /sp/
mi wile pana e sona pi kepeken penpo tawa jan mute.
```
![toki a.](sama-ni/main.svg)


