#import "../src/lib.typ" as penpo

#let vars(..pairs) = {
  for (base, num) in pairs.named() {
    base
    " "
    for i in range(1, num + 2) {
      base + "/" + str(i)
      " "
    }
    "\n"
  }
}

#let words = vars(
  akesi: 2,
  kala: 2,
  ni: 8,
  olin: 2,
  sewi: 2,
  uta: 2,
  wile: 2,
  meli: 3,
  mije: 3,
  namako: 2,
  soko: 3,
  epiku: 2,
  lanpan: 3,
  linluwi: 4,
  majuna: 2,
  kapesi: 2,
  misa: 6,
  taki: 2,
)

#penpo.pakala.open()

#show: penpo.sitelen-pona
#penpo.accept-words("kapesi", "meli", "mije", "namako", "soko", "epiku", "lanpan", "majuna", "linluwi", "misa", "taki")

#words

meli meli/1 meli/2

#penpo.default-sp-variant(meli: 2)

meli meli/1 meli/2



#penpo.pakala.pini()
