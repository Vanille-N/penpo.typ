#let Lasina(t) = {
  text(font: "libertinus serif")[#t]
}

#let seli-kiwen(t) = {
  text(font: "sitelen seli kiwen asuki")[#t]
}

#let Nimi(spelling) = {
  seli-kiwen[
    [#{
      for chr in spelling { [#chr ] }
    }]
  ]
}


