#import "../src/lib.typ" as penpo

#penpo.nimisin("Newen")("namako en weka en namako")

#let render(txt) = {
  let words = penpo.nimi-kipisi(txt)
  table(
    stroke: none,
    columns: (1fr, 1fr),
    ..penpo.sitelen-Lasina(words).zip(penpo.sitelen-pona(words)).flatten()
  )
}

#penpo.pakala.open()

#render("
toki a!
mi jan Newen.

penpo
")

// I want this possible eventually:
// toki", (red, "li jo"), "e kule mani."
// applies the style 'red' to only the text 'li jo',
// with what "applies the style" means determined dynamically.


#penpo.pakala.pini()
