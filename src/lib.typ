#import "nasin-sitelen.typ"

#import "pakala.typ"

#import "nimisin.typ": nimisin, nimisin-mute

#import "dyn.typ"
#import dyn: o-ante-e-sitelen-lili, o-oke-e-nimi

#let esc(ct) = context {
  let old-mode = dyn.mode.get()
  dyn.mode.update(none)
  nasin-sitelen.Lasina[#ct]
  dyn.mode.update(old-mode)
}

#let only(filter, ct) = context {
  if type(filter) == str {
    let cur = dyn.mode.get()
    if cur != none and filter.contains(cur) {
      ct
    }
  } else {
    panic("Invalid filter")
  }
}

#import "lasina.typ"
#import "pona.typ"
