#import "nasin-sitelen.typ"

#import "pakala.typ"
#import "nimi.typ"

#import "nimisin.typ" as libnimisin
#import libnimisin: nimisin, nimisin-mute

#import "kipisi.typ"

#let tp-mode = state("tp-mode", none)

#let esc(ct) = context {
  let old-mode = tp-mode.get()
  tp-mode.update(none)
  nasin-sitelen.Lasina[#ct]
  tp-mode.update(old-mode)
}

#let only(filter, ct) = context {
  if type(filter) == str {
    let mode = tp-mode.get()
    if mode != none and filter.contains(mode) {
      ct
    }
  } else {
    panic("Invalid filter")
  }
}

#let punct = state("punct", (
  "_": (
    ".": [.],
    ",": [,],
    ":": [:],
    "!": [!],
    "?": [?],
    "\"": smartquote(),
    "(": [(],
    ")": [)],
  ),
  la: (
    ".": [.],
    ",": [,],
    ":": [:],
    "!": [!],
    "?": [?],
    "\"": smartquote(),
    "(": [(],
    ")": [)],
  ),
  sp: (
    ".": [.#h(1mm)],
    ",": [,#h(1mm)],
    ":": [:#h(1mm)],
    "!": [!#h(1mm)],
    "?": [?#h(1mm)],
    "\"": smartquote(quotes: (" te ", " to ")),
    "(": [ ~ #nasin-sitelen.Lasina[---]],
    ")": [#nasin-sitelen.Lasina[---] ~ ],
  ),
))

#let fetch-punct(label, sym) = context {
  if tp-mode.get() == label {
    punct.get().at(label).at(sym)
  } else {
    punct.get().at("_").at(sym)
  }
}

#let update-one-punct(label, sym, new) = {
  punct.update(punct => {
    punct.at(label).at(sym) = new
    punct
  })
}

// TODO: this does not yet affect spelling
#let accept-words(..words) = {
  nimi.accepted-words.update(ok => {
    for word in words.pos() {
      if word not in nimi.ale { panic("Word does not exist") }
      ok.push(word)
    }
    ok
  })
}

// Mode code: "la"
#let sitelen-Lasina(ct) = context {
  let old-mode = tp-mode.get()
  tp-mode.update("la")
  show regex("/../"): none
  show "/la/": linebreak()
  show "\"": fetch-punct("la", "\"")
  show ",": fetch-punct("la", ",")
  show ".": fetch-punct("la", ".")
  show ":": fetch-punct("la", ":")
  // " This line fixes the syntax highlighting on vim
  show "?": fetch-punct("la", "?")
  show "!": fetch-punct("la", "!")
  show "(": fetch-punct("la", "(")
  show ")": fetch-punct("la", ")")
  show regex("\w+(/\d+)?"): word => context {
    if tp-mode.get() == "la" {
      let (base,) = kipisi.of-word(word.text)
      if base in nimi.ale {
        let err = if base in nimi.accepted-words.get() { none } else { pakala.pu-ala-pu(base)}
        if err != none {
          err.log
          text(fill: err.color)[#base]
        } else {
          [#base]
        }
      } else if base == "te" {
        sym.quote.l.double
      } else if base == "to" {
        sym.quote.r.double
      } else if base in libnimisin.spellings.get() {
        [#base]
      } else {
        let err = pakala.pu-ala-pu(base)
        err.log
        text(fill: err.color)[#base]
      }
    } else {
      nasin-sitelen.Lasina[#word]
    }
  }
  nasin-sitelen.Lasina[#ct]
  tp-mode.update(old-mode)
}

#let default-sp-variant(..subst) = context {
  nimi.default-sp-variant.update(default => {
    for (base, var) in subst.named() {
      if base not in nimi.ale { panic("Not a known word") }
      if nimi.ale.at(base).maxvar == none { panic("This word has no variants") }
      if var >= nimi.ale.at(base).maxvar { panic("Default variant too big") }
      default.insert(base, var)
    }
    default
  })
}

// Mode code: "sp"
#let sitelen-pona(ct) = context {
  let old-mode = tp-mode.get()
  tp-mode.update("sp")
  show regex("/../"): none
  show "/sp/": linebreak()
  show "\"": fetch-punct("sp", "\"")
  show ",": fetch-punct("sp", ",")
  show ".": fetch-punct("sp", ".")
  show ":": fetch-punct("sp", ":")
  // " This line fixes the syntax highlighting on vim
  show "?": fetch-punct("sp", "?")
  show "!": fetch-punct("sp", "!")
  show "(": fetch-punct("sp", "(")
  show ")": fetch-punct("sp", ")")
  show regex("\w+(/\d+)?"): word => context {
    if tp-mode.get() == "sp" {
      let (base, var) = kipisi.of-word(word.text)
      if var == none {
        var = nimi.default-sp-variant.get().at(base, default: none)
      }
      if base in nimi.ale {
        let err = if base in nimi.accepted-words.get() { none } else { pakala.pu-ala-pu(base)}
        if err != none {
          err.log
          text(fill: err.color)[#base#var]
        } else {
          [#base#var]
        }
      } else if base in ("te", "to") {
        base
      } else if base in libnimisin.spellings.get() {
        let data = libnimisin.spellings.get().at(base)
        let shorten = base in libnimisin.shortenable.get()
        let spelling = if shorten { data.short } else { data.full }
        [#nasin-sitelen.Nimi(spelling)]
        if not shorten {
          libnimisin.nimisin-kama-lili(base, data.short, spelling)
        }
      } else {
        let (color, log) = pakala.pu-ala-pu(base)
        log
        [#text(fill: color, nasin-sitelen.Lasina[
          #{sym.angle.l}#{base}#{sym.angle.r}
        ])]
      }
    } else {
      nasin-sitelen.Lasina[#word]
    }
  }
  nasin-sitelen.seli-kiwen[#ct]
  tp-mode.update(old-mode)
}

