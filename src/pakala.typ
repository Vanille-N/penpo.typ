// Collection of definitions relating to reporting compilation warnings
// (we emit very few actual compilation errors --- as in, `panic`s ---
// but we provide a method of displaying within the document a log of all
// warnings sorted by severity)
//
// Rough usage:
// - anywhere in the document, invoke `log()`.
//   This is where the log of all warnings will be inserted.
// - at the end of the document, place `pini`.
//   This will create a tag that lets `log()` know when all errors have been
//   received.
// - in functions, invoke `alert` to add all problems to the log.
//   Warnings are identified by a tag and a severity.
//   The tag determines when two warnings are identical, so that the log is not
//   composed of 100 copies of the exact same error message.
//   The severity decides the order in which they appear.

#import "aux.typ"
#import "nimi.typ": ale as nimi-ale
#import "nasin-sitelen.typ"
#import "kokosila.typ": switch

#let (open-aux, pakala, pini) = aux.make-new-log("pakala")

#let open() = open-aux(switch[lipu ni li jo e pakala lili:][The following typos have been detected:])

#let lili-ike(lili, nimi) = {
  let tag = "uppercase("+nimi+")"
  pakala(red, tag, 4, switch[
    "#lili" lon "#nimi" li lili ike
  ]["#lili" in the name "#nimi" should be uppercase])
}

#let suli-ike(lili, nimi) = {
  let tag = "lowercase("+lili+","+nimi+")"
  pakala(red, tag, 5, switch[
    "#lili" lon "#nimi" li suli ike
  ]["#lili" in the name "#nimi" should be lowercase])
}

#let nanpa-ante(nimi, lili-mute) = {
  let tag = "len("+nimi+")"
  pakala(red, tag, 2, switch[
    "#nimi" li ante nanpa sitelen tawa "#nasin-sitelen.Nimi(lili-mute)"
  ]["#nimi" should have the same length as its spelling "#nasin-sitelen.Nimi(lili-mute)"])
}

#let sitelen-ala(nimi) = {
  let tag = "sitelen("+nimi+")"
  pakala(red, tag, 1, switch[
    "#nimi" li lon ala nasin sitelen pona
  ]["#nimi" does not have a known hieroglyph])
}

#let sitelen-ante(lili, sitelen, nimi, lili-mute) = {
  let tag = "spelling("+lili+","+sitelen+","+nimi+")"
  pakala(red, tag, 0, switch[
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
  pakala(red, tag, 3, switch[
    #nimi1 (#nasin-sitelen.Nimi(lili-mute1))
    en #nimi2 (#nasin-sitelen.Nimi(lili-mute2))
    li sama sitelen wan "#nasin-sitelen.seli-kiwen(lili)"
  ][
    #nimi1 (#nasin-sitelen.Nimi(lili-mute1))
    and #nimi2 (#nasin-sitelen.Nimi(lili-mute2))
    have the same initial "#nasin-sitelen.seli-kiwen(lili)"
  ])
}

#let pu-ala-pu(nimi, seme, nanpa-ante: none) = {
  let meta = nimi-ale.at(nimi, default: none)
  let tag = "rarity-"+seme+"("+nimi+")"
  if meta == none {
    pakala(red, tag, 0, switch[
      "#nimi" li lon ala
    ]["#nimi" is not a known word])
  } else if meta.group != "word" {
    none
  } else if meta.rarity == "pu" {
    none
  } else if meta.rarity == "ku" {
    pakala(orange, tag, 7, switch[
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + aux.str-some(nanpa-ante)))
      li lon pu ala
    ][
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi + aux.str-some(nanpa-ante)))
      is not in "pu" (rare word)
    ])
  } else if meta.rarity == "sin" {
    pakala(orange, tag, 6, switch[
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi)) li lon ku suli ala
    ][
      "#nimi" (#nasin-sitelen.seli-kiwen(nimi))
      is not in "ku suli" (obscure word)
    ])
  } else {
    panic[Rarity #meta.rarity is malformed]
  }
}

