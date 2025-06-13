#import "../src/lib.typ" as penpo

#let render(..txt) = {
  let words = penpo.kipisi.nimi-li-seme(penpo.nimi-kipisi(..txt.pos()))
  table(
    stroke: none,
    columns: (1fr, 1fr),
    ..penpo.sitelen-Lasina(words).zip(penpo.sitelen-pona(words)).flatten()
  )
}

