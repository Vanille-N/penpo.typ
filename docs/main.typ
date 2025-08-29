#import "../src/lib.typ" as penpo

#penpo.o-oke-e-nimi("penpo")

#show link: set text(fill: blue.darken(20%))

#align(center)[
  #text(size: 90pt)[#penpo.pona.sitelen[penpo]] \
  #text(size: 30pt)[*penpo*] \

  #text(size: 25pt)[lawa tawa sitelen kepeken toki pona taso]
]

penpo is a spellchecker and transliteration engine for toki pona,
helping typeset text in sitelen Lasina, sitelen pona, and more.
It offers many configuration options, and modularity to enable additional
writing systems.

#[
  #show: pp => [
    #penpo.lasina.sitelen[#pp]

    #penpo.pona.sitelen[#pp]
  ]
  #penpo.nimisin-mute(Lasina: "linja ale sona ilo nasin alasa")
  ilo penpo li ilo lipu, li ken sitelen e toki pona kepeken sitelen Lasina
  en sitelen pona en sitelen ante mute.
  sina ken ante e sitelen lili kepeken wawa lili.
]

#align(bottom)[
  #line(length: 100%)
  #outline()
]

#pagebreak()

#set heading(numbering: (..nums) => {
  if nums.pos().len() <= 2 {
    numbering("A.1 -", ..nums.pos())
  } else {
    ""
  }
})

= Naming and logo

"penpo" means "(pi) toki pona taso"; see #link("https://nimi.li/penpo")[nimi.li/penpo].

The logo of `penpo` is an adjusted and colorized version of the character "penpo" from the font
#link("https://www.kreativekorp.com/software/fonts/sitelenselikiwen/")[sitelen seli kiwen].
A light and a dark version are provided.
The SVG files can be found in `logo/`.

#table(
  columns: (1fr, 1fr),
  align: center,
  stroke: none,
  rect(fill: white, inset: 2mm)[#image("../logo/penpo.svg")],
  rect(fill: black, inset: 2mm)[#image("../logo/penpo-dark.svg")],
)

The package name "`penpo`" should never be capitalized in any context,
even at the start of a sentence.
It can however be freely substituted by any of
- the logo scaled to the font size,
- the regular hieroglyph "#penpo.pona.sitelen[penpo]" in any sitelen pona font,
- any other reasonable transcription of the word "penpo" in the current writing system.

= Getting started

`penpo` provides the modules `lasina` and `pona` as the main features.
Because `lasina` uses the default font, it is mostly useful for providing
spellchecking and punctuation substitution. `pona` does a lot more work
to properly convert text to sitelen pona, and shorten hieroglyphic names.

The nature of these functions as content transformers makes it easy to,
among other things, write text once and have it display as both sitelen Lasina
and sitelen pona.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  toki a. mi pali e lipu ni/3 tan ni/2:
  mi wile pana e sona pi lipu penpo.
  ```
][
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  toki a. mi pali e lipu ni/3 tan ni/2:
  mi wile pana e sona pi lipu penpo.
]

In sitelen pona, you can declare nimisin to be spelled out in hieroglyphs.
By default it is shortened from the second time onwards,
but this can be disabled by `_lili: none`.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #show: penpo.pona.sitelen
  #penpo.nimisin-mute(
    Lasina: "linja ale sona insa ni awen",
    Newen: "namako en weka en namako",
  )
  #penpo.nimisin-mute(
    _lili: none,
    Inli: "isipin ni li isipin",
  )
  ni li sitelen Lasina ala. \
  toki Inli li kepeken sitelen Lasina, \
  taso ni li toki Inli ala. \
  mi jan Newen. \
  jan Newen li olin e sitelen pona.
  ```
][
  #show: penpo.pona.sitelen
  #penpo.nimisin-mute(
    Lasina: "linja ale sona insa ni awen",
    Newen: "namako en weka en namako",
  )
  #penpo.nimisin-mute(
    _lili: none,
    Inli: "isipin ni li isipin",
  )
  ni li sitelen Lasina ala. \
  toki Inli li kepeken sitelen Lasina, \
  taso ni li toki Inli ala. \
  mi jan Newen. \
  jan Newen li olin e sitelen pona.
]

You can use `esc` to temporarily disable reformatting.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  #penpo.nimisin-mute(
    Masi: "mun alasa sona ike",
    Inli: "isipin ni li isipin",
    Wikipesija: "walo ijo kin ijo pona esun sona ijo jo ale",
    Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  )
  ilo Insanjuwisi \
  (toki Inli: "#penpo.esc[Ingenuity]")
  li ken tawa lon kon. 
  #align(right)[
    --- tan lipu Wikipesija,
    #link("https://wikipesija.org/wiki/mun_Masi")[mun Masi]
  ]
  ```
][
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  #penpo.nimisin-mute(
    Masi: "mun alasa sona ike",
    Inli: "isipin ni li isipin",
    Wikipesija: "walo ijo kin ijo pona esun sona ijo jo ale",
    Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  )
  ilo Insanjuwisi \
  (toki Inli: "#penpo.esc[Ingenuity]") li ken tawa lon kon. 
  #align(right)[---~ tan lipu Wikipesija, #link("https://wikipesija.org/wiki/mun_Masi")[mun Masi]]
]

You can use `only` to have text only shown in one of the modes.
`"la"` and `"sp"` are the codes for sitelen Lasina and sitelen pona respectively.
The commands `/la/` and `/sp/` are aliases for `#only("la")[#linebreak()]`
and `#only("sp")[#linebreak()]` respectively, enabling the insertion of linebreaks
in only one of the writing systems.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  toki ni li kepeken e sitelen
  #penpo.only("sp")[pona]
  #penpo.only("la")[Lasina].

  wan /la/ tu /sp/ mute.
  ```
][
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  toki ni li kepeken e sitelen
  #penpo.only("la")[Lasina]#penpo.only("sp")[pona].

  wan /la/ tu /sp/ mute.
]

penpo additionally provides spellchecking and rarity warnings.
You can disable them with the function `o-oke-e-nimi`,
or display a structured error log with `pakala.open` and `pakala.pini`.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  // Put this at the beginning of your document
  #penpo.pakala.open()

  #show: penpo.lasina.sitelen
  // "kalama" has a typo,
  // and "jonke" is a rare word
  kamala jonke li mu tan waso utala.
  #penpo.o-oke-e-nimi("jonke")
  kamala jonke li mu tan waso utala.

  // Put this at the very end of your document
  #penpo.pakala.pini()
  ```
][
  #penpo.pakala.open()

  #show: penpo.lasina.sitelen

  kamala jonke li mu tan waso utala.

  #penpo.o-oke-e-nimi("jonke")
  kamala jonke li mu tan waso utala.

  #penpo.pakala.pini()
]

= kokosila

toki pona is the default language for both error messages and function names,
but English is available.

You can turn the language of error messages to english using
```typ
#penpo.kokosila.toggle()
```

The following functions have an alias:
#table(columns: 2,
  `o-ante-e-sitelen-lili`, `kokosila.update-punct`,
  `o-oke-e-nimi`, `kokosila.allow-words`,
  `nimisin`, `kokosila.spelling`,
  `nimisin-mute`, `kokosila.spellings`,
  `pakala.open`, `kokosila.begin-log`,
  `pakala.pini`, `kokosila.end-log`,
  `pona.nanpa-ala-li-nanpa`, `kokosila.default-sp-variant`,
)

= Advanced options

== nimisin

Shortening is customizable through `_lili`:
- if `_lili` is an integer, the name is shortened to the `_lili` first characters,
- the default is the first character only, equivalent to `_lili: 1`,
- if `_lili` is `none`, the name will not be shortened,
- if `_lili` is a string, it is interpreted literally as the spelling.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #penpo.nimisin("Lasina",
    "linja ale sona ilo nasin alasa")
  ```
][
  #show: penpo.pona.sitelen
  #penpo.nimisin("Lasina", "linja ale sona ilo nasin alasa")
  Lasina Lasina
][
  ```typ
  #penpo.nimisin("Lasina", _lili: 2,
    "linja ale sona ilo nasin alasa")
  ```
][
  #show: penpo.pona.sitelen
  #penpo.nimisin("Lasina", "linja ale sona ilo nasin alasa", _lili: 2)
  Lasina Lasina
][
  ```typ
  #penpo.nimisin("Lasina", _lili: none,
    "linja ala sona ilo nasin alasa")
  ```
][
  #show: penpo.pona.sitelen
  #penpo.nimisin("Lasina", "linja ale sona ilo nasin alasa", _lili: none)
  Lasina Lasina
][
  ```typ
  #penpo.nimisin("Lasina",
    _lili: "linja nasin alasa",
    "linja ala sona ilo nasin alasa")
  ```
][
  #show: penpo.pona.sitelen
  #penpo.nimisin("Lasina", "linja ale sona ilo nasin alasa", _lili: "linja nasin alasa")
  Lasina Lasina
]

== Hieroglyph variants

Some hieroglyphs have variants. They can be accessed by suffixing the word
with `/n` the number of the variant.

`pona.nanpa-ala-li-nanpa` is available to declare the default value.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #show: penpo.pona.sitelen

  olin olin/0 olin/1 olin/2

  #penpo.pona.nanpa-ala-li-nanpa(olin: 1)
  olin olin/0 olin/1 olin/2

  #penpo.pona.nanpa-ala-li-nanpa(olin: 2)
  olin olin/0 olin/1 olin/2
  ```
][
  #show: penpo.pona.sitelen

  olin olin/0 olin/1 olin/2

  #penpo.pona.nanpa-ala-li-nanpa(olin: 1)
  olin olin/0 olin/1 olin/2

  #penpo.pona.nanpa-ala-li-nanpa(olin: 2)
  olin olin/0 olin/1 olin/2
]

Be aware that this feature is currently very closely tied to sitelen seli kiwen,
and there is no uniform convention. Sometimes `/0` is synonymous for `/1`
(e.g. `meli`) and sometimes not (e.g. `olin`).

#pagebreak()

== Punctuation

punctuation symbols can be customized using `o-ante-e-sitelen-lili` with the appropriate
code (`"la"` or `"sp"`).
Punctuation that is available for customization is:
`"."` `","` `":"` `"!"` `"?"` `"\""` `"("` `")"`.
More may be available in the future.

#table(columns: (55%, 45%), stroke: 0.1pt)[
  ```typ
  #penpo.nimisin-mute(
    Masi: "mun alasa sona ike",
    Inli: "isipin ni li isipin",
    Wikipesija: "walo ijo kin ijo pona esun sona ijo jo ale",
    Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  )
  #penpo.o-ante-e-sitelen-lili("la", (
    "\"": smartquote(quotes: ("「", "」")),
  ))
  #penpo.o-ante-e-sitelen-lili("sp", (
    ":": h(1mm),
    "(": penpo.esc[~{],
    ")": penpo.esc[}~],
    ".": h(5mm),
    ",": none,
  ))
  ilo Insanjuwisi \
  (toki Inli: "#penpo.esc[Ingenuity]")
  li ken tawa lon kon. 
  #align(right)[---~ tan lipu Wikipesija,
    #link("https://wikipesija.org/wiki/mun_Masi")[mun Masi]]
  ```
][
  #show: pp => [
    #penpo.lasina.sitelen[#pp] \

    #penpo.pona.sitelen[#pp]
  ]
  #penpo.nimisin-mute(
    Masi: "mun alasa sona ike",
    Inli: "isipin ni li isipin",
    Wikipesija: "walo ijo kin ijo pona esun sona ijo jo ale",
    Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  )
  #penpo.o-ante-e-sitelen-lili("la", (
    "\"": smartquote(quotes: ("「", "」")),
  ))
  #penpo.o-ante-e-sitelen-lili("sp", (
    ":": h(1mm),
    "(": penpo.esc[~{],
    ")": penpo.esc[}~],
    ".": h(5mm),
    ",": none,
  ))
  ilo Insanjuwisi \
  (toki Inli: "#penpo.esc[Ingenuity]") li ken tawa lon kon. 
  #align(right)[---~ tan lipu Wikipesija, #link("https://wikipesija.org/wiki/mun_Masi")[mun Masi]]
]

== Changing fonts (WIP)

This feature is not yet available.
For now only
#link("https://www.kreativekorp.com/software/fonts/sitelenselikiwen/")[sitelen seli kiwen]
is supported, but in the future there are plans to customize the font.

// ----------------------------------------

#import "@preview/tidy:0.4.3"

#let document(base, title) = {
  let docs = tidy.parse-module(read("/src/" + base + ".typ"), name: title)
  tidy.show-module(docs)
}

= Renderers

// TODO

//#document("lasina", "Latin alphabet")
//#document("pona", "sitelen pona")
//#document("hangul", "Hangul alphabet")
//#document("hiragana", "Hiragana alphabet")

= Module documentation

// TODO

//#document("dyn", "Dynamic state")
//#document("extra", "Auxiliary functions")
//#document("kipisi", "")
//#document("lib", "")
//#document("nasin-sitelen", "")
//#document("nimi", "")
//#document("nimisin", "")
//#document("pakala", "")

