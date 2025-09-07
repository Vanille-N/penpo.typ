# penpo

[![tok](https://img.shields.io/badge/lang-tok-green.svg)](O-LUKIN.md)

A toki pona spellchecker and transliteration library.

See the [documentation](docs/main.pdf)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="logo/penpo-dark.svg">
  <img alt="penpo" src="logo/penpo-light.svg">
</picture>

---

## Features

penpo provides
- spellchecking and warnings for obscure words,
- automatic transliteration to sitelen pona (available), and other alphabets (wip),
- the ability to write text once and have it rendered in different writing systems,
- a uniform interface for punctuation symbols across alphabets.

## Prerequisites

- the sitelen pona font
  ["sitelen seli kiwen"](https://www.kreativekorp.com/software/fonts/sitelenselikiwen/)
  is required, and must be downloaded manually.
  See an example usage in [sama-ni/](sama-ni/).

## Example

```typ
#import "@preview/penpo:0.1.0"

// Show the error log
#penpo.pakala.open()

// Silence the rarity warnings on "penpo" and "namako"
#penpo.o-oke-e-nimi("penpo", "namako")

// Transliterate "Newen" into hieroglyphic spelling
#penpo.nimisin("Newen", "namako en weka en namako", _lili: "namako namako")

// Show both sitelen Lasina and sitelen pona side by side
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
![short toki pona greeting in sitelen Lasina and sitelen pona side by side](sama-ni/main.svg)


