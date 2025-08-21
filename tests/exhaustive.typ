#import "../src/lib.typ" as penpo

// TODO: Hangul and Kanji: still transliterate
// even if not a known word, as long as it's a valid
// word.

// TODO: almost every one of those errors should be saying x4

#penpo.pakala.open()

#let paragraph = [
= nimi lili
n a an o on e en u un i in /sp/
pa pan po pon pe pen pu pun pi pin /sp/
ka kan ko kon ke ken ku kun ki kin /sp/
sa san so son se sen su sun si sin /sp/
ta tan to ton te ten tu tun /sp/
ma man mo mon me men mu mun mi min /sp/
na nan no non ne nen nu nun ni nin /sp/
la lan lo lon le len lu lun li lin /sp/
wa wan we wen wi win /sp/
ja jan jo jon je jen ju jun

= nimi ale
ala ale anu ijo ike ilo ona uta ali oko nja oke owe unu anpa ante awen esun insa jaki jelo kala kama kasi kili kule kute lape laso lawa lete lili lipu loje luka lupa mama mani moku moli musi mute nasa nena nimi noka olin open pali pana pini pipi poka poki pona sama seli selo seme sewi sike sina sona suli suno supa suwi taso tawa telo toki tomo unpa walo waso wawa weka wile leko meli mije soko meso jami kiki misa pake pika powe puwa soto taki teje akesi alasa kiwen linja lukin monsi nanpa nasin pilin tenpo utala tonsi epiku apeja jonke konwe ojuta penpo usawi kalama kulupu pakala palisa pimeja sijelo sinpin soweli kipisi namako jasima lanpan majuna isipin kapesi kulijo melome mijomi pakola wekama kepeken sitelen monsuta linluwi nimisin omekapo misikeke kokosila mulapisu wasoweli kamalawala kijetesantakalu

= sitelen lili

, . : ? ! - "a" ( )
te to 
]

#[
  #show: penpo.lasina.sitelen
  #paragraph
]

#[
  #show: penpo.pona.sitelen
  #show ".": [ #sym.dot ]
  #paragraph
]

#[
  #penpo.update-one-punct("la", ".", [ #sym.dot ])
  #penpo.update-one-punct("la", "\"", smartquote(quotes: ("⟨", "⟩")))
  #show: penpo.lasina.sitelen
  #paragraph
]

#[
  #show: penpo.pona.sitelen
  #paragraph
]

#penpo.pakala.pini()
