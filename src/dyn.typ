#import "nasin-sitelen.typ"
#import "extra.typ"

#let accept = state(extra.localize-label("dyn", "accept"), ())

#let mode = state(extra.localize-label("dyn", "mode"), none)

/// Global variable that determines if the library
/// should use English (`kokosila = true`) or
/// toki pona (`kokosila = false`, by default).
/// -> bool
#let kokosila = state(extra.localize-label("dyn", "kokosila"), false)

/// Choose based on the value of the variable.
/// -> any
#let kokosila-switch(
  /// Return this if `kokosila = false` -> any
  tp,
  /// Return this if `kokosila = true` -> any
  en,
) = context {
  if kokosila.get() { en } else { tp }
}

#let punct = state(extra.localize-label("dyn", "punct"), (
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
  if mode.get() == label {
    punct.get().at(label).at(sym)
  } else {
    punct.get().at("_").at(sym)
  }
}

#let o-ante-e-sitelen-lili(label, upd) = {
  punct.update(punct => {
    for (sym, new) in upd {
      punct.at(label).at(sym) = new
    }
    punct
  })
}

// TODO: this does not yet affect spelling
#let o-oke-e-nimi(..words) = {
  import "nimi.typ"
  accept.update(ok => {
    for word in words.pos() {
      if word not in nimi.ale { panic("Word does not exist") }
      ok.push(word)
    }
    ok
  })
}

