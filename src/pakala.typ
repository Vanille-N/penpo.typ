// Collection of definitions relating to reporting compilation warnings
// (we emit very few actual compilation errors --- as in, `panic`s ---
// but we provide a method of displaying within the document a log of all
// warnings sorted by severity)
//
// Rough usage:
// - anywhere in the document, invoke `open()`.
//   This is where the log of all warnings will be inserted.
// - at the end of the document, place `pini()`.
//   This will create a tag that lets `open()` know when all errors have been
//   received.
// - in functions, invoke `pakala` to add all problems to the log.
//   Warnings are identified by a tag and a severity.
//   The tag determines when two warnings are identical, so that the log is not
//   composed of 100 copies of the exact same error message.
//   The severity decides the order in which they appear.

#import "extra.typ"
#import "nimi.typ": ale as nimi-ale
#import "nasin-sitelen.typ"
#import "dyn.typ": kokosila-switch

#let (open-aux, pakala, pini) = extra.make-new-log(extra.localize-label("pakala", "pakala"))

/// Start collecting errors. Call this wherever you want the error log
/// to appear. -> content
#let open() = open-aux(kokosila-switch[lipu ni li jo e pakala lili:][The following typos have been detected:])

/// Letter is lowercase but should be uppercase.
#let lili-ike(lili, nimi) = {
  let tag = "lowercase("+nimi+")"
  pakala(red, tag, 4, kokosila-switch[
    "#lili" lon "#nimi" li lili ike
  ]["#lili" in the name "#nimi" should be uppercase])
}

#let suli-ike(lili, nimi) = {
  let tag = "uppercase("+lili+","+nimi+")"
  pakala(red, tag, 5, kokosila-switch[
    "#lili" lon "#nimi" li suli ike
  ]["#lili" in the name "#nimi" should be lowercase])
}

#let nanpa-ante(nimi, lili-mute) = {
  let tag = "len("+nimi+")"
  pakala(red, tag, 2, kokosila-switch[
    "#nimi" li ante nanpa sitelen tawa "#nasin-sitelen.Nimi(lili-mute)"
  ]["#nimi" should have the same length as its spelling "#nasin-sitelen.Nimi(lili-mute)"])
}

#let sitelen-ala(nimi) = {
  let tag = "sitelen("+nimi+")"
  pakala(red, tag, 1, kokosila-switch[
    "#nimi" li lon ala nasin sitelen pona
  ]["#nimi" does not have a known hieroglyph])
}

#let sitelen-ante(lili, sitelen, nimi, lili-mute) = {
  let tag = "spelling("+lili+","+sitelen+","+nimi+")"
  pakala(red, tag, 0, kokosila-switch[
    "#sitelen" (#nasin-sitelen.seli-kiwen[#sitelen])
    lon "#nasin-sitelen.Nimi(lili-mute)"
    li ante tawa "#lili" lon "#nimi"
  ][
    "#sitelen" (#nasin-sitelen.seli-kiwen[#sitelen])
    in "#nasin-sitelen.Nimi(lili-mute)"
    does not spell out "#lili" in "#nimi"
  ])
}

#let sama-sitelen-wan(lili, ni1, ni2) = {
  let (nimi1, lili-mute1) = ni1
  let (nimi2, lili-mute2) = ni2
  let tag = "initial("+nimi1+","+nimi2+")"
  pakala(red, tag, 3, kokosila-switch[
    #nimi1 (#nasin-sitelen.Nimi(lili-mute1))
    en #nimi2 (#nasin-sitelen.Nimi(lili-mute2))
    li sama sitelen wan "#nasin-sitelen.seli-kiwen(lili)"
  ][
    #nimi1 (#nasin-sitelen.Nimi(lili-mute1))
    and #nimi2 (#nasin-sitelen.Nimi(lili-mute2))
    have the same initial "#nasin-sitelen.seli-kiwen(lili)"
  ])
}

#let pu-ala-pu(nimi, nanpa-ante: none) = {
  let meta = nimi-ale.at(nimi, default: none)
  let tag = "rarity("+nimi+")"
  if meta == none {
    (color: red, log: pakala(red, tag, 0, kokosila-switch[
      "#nimi" li lon ala
    ]["#nimi" is not a known word]))
  } else if meta.group != "word" {
    none
  } else if meta.rarity == "pu" {
    none
  } else if meta.rarity == "ku" {
    (color: orange, log: pakala(orange, tag, 7, kokosila-switch[
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + extra.str-some(nanpa-ante)))
      li lon pu ala
    ][
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + extra.str-some(nanpa-ante)))
      is not in "pu" (rare word)
    ]))
  } else if meta.rarity == "sin" {
    (color: orange, log: pakala(orange, tag, 6, kokosila-switch[
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + extra.str-some(nanpa-ante)))
      li lon ku suli ala
    ][
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + extra.str-some(nanpa-ante)))
      is not in "ku suli" (obscure word)
    ]))
  } else {
    panic[Rarity #meta.rarity is malformed]
  }
}

