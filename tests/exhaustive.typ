#import "common.typ": *

// TODO: Hangul and Kanji: still transliterate
// even if not a known word, as long as it's a valid
// word.

// TODO: almost every one of those errors should be saying x4

#penpo.pakala.open()

#let words = segment("n a an o on e en u un i in pa pan po pon pe pen pu pun pi pin ka kan ko kon ke ken ku kun ki kin sa san so son se sen su sun si sin ta tan to ton te ten tu tun ma man mo mon me men mu mun mi min na nan no non ne nen nu nun ni nin la lan lo lon le len lu lun li lin wa wan we wen wi win ja jan jo jon je jen ju jun ala ale anu ijo ike ilo ona uta ali oko nja oke owe unu anpa ante awen esun insa jaki jelo kala kama kasi kili kule kute lape laso lawa lete lili lipu loje luka lupa mama mani moku moli musi mute nasa nena nimi noka olin open pali pana pini pipi poka poki pona sama seli selo seme sewi sike sina sona suli suno supa suwi taso tawa telo toki tomo unpa walo waso wawa weka wile leko meli mije soko meso jami kiki misa pake pika powe puwa soto taki teje akesi alasa kiwen linja lukin monsi nanpa nasin pilin tenpo utala tonsi epiku apeja jonke konwe ojuta penpo usawi kalama kulupu pakala palisa pimeja sijelo sinpin soweli kipisi namako jasima lanpan majuna isipin kapesi kulijo melome mijomi pakola wekama kepeken sitelen monsuta linluwi nimisin omekapo misikeke kokosila mulapisu wasoweli kamalawala kijetesantakalu")

#show-Lasina(words)
#show-pona(words)
#show-hangul(words)
#show-kanji(words)

#penpo.pakala.pini()
