#import "@preview/tidy:0.4.3"

#rect(fill: black, inset: 1cm)[
#image("../logo/penpo-dark.svg")
]
#rect(fill: white, inset: 1cm)[
#image("../logo/penpo.svg")
]

= Getting started

= Advanced options

= Module documentation

#let document(base, title) = {
  let docs = tidy.parse-module(read("/src/" + base + ".typ"), name: title)
  tidy.show-module(docs)
}

#document("lib", "Root")
#document("nimi", "Dictionary")
#document("nasin-sitelen", "Fonts")
#document("nimisin", "External words")
#document("pakala", "Error reporting")
//#document("kipisi", "Word segmentation")
//#document("kokosila", "Toggle English localization")
//#document("aux", "Auxiliary functions")
