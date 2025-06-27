#import "../src/lib.typ" as penpo

#let segment(..txt) = {
  penpo.kipisi.nimi-li-seme(penpo.nimi-kipisi(..txt.pos()))
}

#let show-Lasina(words) = {
  table(
    stroke: none,
    columns: 1,
    ..penpo.sitelen-Lasina(words)
  )
}

#let show-pona(words) = {
  table(
    stroke: none,
    columns: 1,
    ..penpo.sitelen-pona(words)
  )
}

#let show-hiragana(words) = {
  table(
    stroke: none,
    columns: 1,
    ..penpo.hiragana.sitelen(words)
  )
}

#let show-hangul(words, ..args) = {
  table(
    stroke: none,
    columns: 1,
    ..penpo.hangul.sitelen(words, ..args.named())
  )
}
