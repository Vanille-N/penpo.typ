#import "nasin-sitelen.typ"
#import "extra.typ"
#import "kipisi.typ"

#import "pakala.typ"
#import "nimi.typ"
#import "nimisin.typ"

#import "dyn.typ"

#let default = state(extra.localize-label("sp", "default"), (:))

#let nanpa-ala-li-nanpa(..subst) = context {
  default.update(default => {
    for (base, var) in subst.named() {
      if base not in nimi.ale { panic("Not a known word") }
      if nimi.ale.at(base).maxvar == none { panic("This word has no variants") }
      if var > nimi.ale.at(base).maxvar { panic("Default variant too big") }
      default.insert(base, var)
    }
    default
  })
}

// Mode code: "sp"
#let sitelen(ct) = context {
  let old-mode = dyn.mode.get()
  dyn.mode.update("sp")
  show regex(" */../ *"): " "
  show regex(" */sp/ *"): linebreak()
  show "\"": dyn.fetch-punct("sp", "\"")
  show ",": dyn.fetch-punct("sp", ",")
  show ".": dyn.fetch-punct("sp", ".")
  show ":": dyn.fetch-punct("sp", ":")
  // " This line fixes the syntax highlighting on vim
  show "?": dyn.fetch-punct("sp", "?")
  show "!": dyn.fetch-punct("sp", "!")
  show "(": dyn.fetch-punct("sp", "(")
  show ")": dyn.fetch-punct("sp", ")")
  show regex("\w+(/\d+)?"): word => context {
    if dyn.mode.get() == "sp" {
      let (base, var) = kipisi.kipisi(word.text)
      if var == none {
        var = default.get().at(base, default: none)
      }
      if base in nimi.ale {
        let err = if base in dyn.accept.get() { none } else { pakala.pu-ala-pu(base)}
        if err != none {
          err.log
          text(fill: err.color)[#base#var]
        } else {
          [#base#var]
        }
      } else if base in ("te", "to") {
        base
      } else if base in nimisin.spellings.get() {
        let data = nimisin.spellings.get().at(base)
        let shorten = base in nimisin.shortenable.get()
        let spelling = if shorten and data.short != none { data.short } else { data.full }
        [#nasin-sitelen.Nimi(spelling)]
        if not shorten {
          nimisin.nimisin-kama-lili(base, data.short, spelling)
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
  dyn.mode.update(old-mode)
}

