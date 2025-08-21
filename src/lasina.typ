#import "nasin-sitelen.typ"
#import "extra.typ"
#import "kipisi.typ"

#import "pakala.typ"
#import "nimi.typ"
#import "nimisin.typ"

#import "dyn.typ"

// Mode code: "la"
#let sitelen(ct) = context {
  let old-mode = dyn.mode.get()
  dyn.mode.update("la")
  show regex("/../"): none
  show "/la/": linebreak()
  show "\"": dyn.fetch-punct("la", "\"")
  show ",": dyn.fetch-punct("la", ",")
  show ".": dyn.fetch-punct("la", ".")
  show ":": dyn.fetch-punct("la", ":")
  // " This line fixes the syntax highlighting on vim
  show "?": dyn.fetch-punct("la", "?")
  show "!": dyn.fetch-punct("la", "!")
  show "(": dyn.fetch-punct("la", "(")
  show ")": dyn.fetch-punct("la", ")")
  show regex("\w+(/\d+)?"): word => context {
    if dyn.mode.get() == "la" {
      let (base,) = kipisi.of-word(word.text)
      if base in nimi.ale {
        let err = if base in dyn.accept.get() { none } else { pakala.pu-ala-pu(base)}
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
      } else if base in nimisin.spellings.get() {
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
  dyn.mode.update(old-mode)
}

