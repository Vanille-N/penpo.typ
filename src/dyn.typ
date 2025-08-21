#import "nasin-sitelen.typ"
#import "extra.typ"

#import "pakala.typ"
#import "nimi.typ"

#import "nimisin.typ" as libnimisin
#import libnimisin: nimisin, nimisin-mute

#import "kipisi.typ"

#let accept = state(extra.localize-label("dyn", "accept"), ())

#let mode = state(extra.localize-label("dyn", "mode"), none)

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

#let update-one-punct(label, sym, new) = {
  punct.update(punct => {
    punct.at(label).at(sym) = new
    punct
  })
}

// TODO: this does not yet affect spelling
#let accept-words(..words) = {
  nimi.accept.update(ok => {
    for word in words.pos() {
      if word not in nimi.ale { panic("Word does not exist") }
      ok.push(word)
    }
    ok
  })
}

