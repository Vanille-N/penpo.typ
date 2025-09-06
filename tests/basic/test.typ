#import "/src/lib.typ" as penpo

#penpo.nimisin("Inli", "insa n li ijo", _lili: none)
#penpo.nimisin("Masi", "mun alasa sinpin ijo", _lili: 1)
#penpo.nimisin("Newen", "namako en weka en namako", _lili: "namako namako")

#penpo.nimisin-mute(
  _lili: none,
  Sola: "suno o lukin ala",
  Mekuliju: "majuna e kule uta li insa jasima uta",
  Tela: "toki e lon ala",
  Olinpu: "o lukin insa nena pona unpa",
  Mon: "ma open nena",
  Mewika: "moku esun weka ilo kalama awen",
  Elopa: "esun lawa olin pona awen",
  Losi: "lanpan oko sewi insa",
  Nijon: "nasin ijo jan olin n",
  Loma: "lawa olin mi awen",
  Imalasi: "insa ma ala lon akesi suno ilo",
  Sonko: "soko open ni kiwen o",
  Insanjuwisi: "ilo nasin sona awen nena jo uta wile ilo sona ilo",
  Popo: "pi o pi o",
  Temo: "tawa e mi o",
)

#let paragraph = [
  == o lukin e pakala lili

  namako namako/2

  == mun Masi

  #penpo.only("la")[toki ni li kepeken e sitelen Lasina]
  #penpo.only("sp")[toki ni li kepeken e sitelen pona]

  suno mi la, mun Masi (toki Inli: "#penpo.esc[Mars]") /sp/
  li mun nanpa tu tu lon weka suno Sola. /sp/
  ona li lili nanpa tu. mun Masi la mun Mekuliju taso li lili. /sp/
  ma Tela la, ona li lili. ma pi mun Masi li jo e kiwen mute. /sp/
  ona li lete li jo e kon lili. /sp/
  ona li loje lukin la, nimi ante ona li "mun loje". /sp/
  telo li lon ala ma Masi. taso, kiwen telo lete li lon. /sp/
  ona li jo e nena ma suli. /sp/
  nena ma Olinpu Mon li nena ma nanpa wan lon /sp/
  ma Masi lon kulupu mun suno. /sp/
  nimi pi mun Masi li sama e jan sewi tan nasin sewi Loma. /sp/
  jan sewi ni li jan sewi utala. /sp/

  jan li tawa mun Masi ala. taso, ilo mun mute li tawa mun Masi. /sp/
  ma Mewika en ma Elopa /sp/
  en ma Losi en ma Nijon /sp/
  en ma Imalasi en ma Sonko /sp/
  li tawa e ilo tawa mun Masi. /sp/
  ilo li awen lon selo. ilo ante li ken tawa lon selo. /sp/
  ilo Insanjuwisi /sp/
  (toki Inli: "#penpo.esc[Ingenuity]") li ken tawa lon kon. /sp/
  ilo ante li tawa sike e mun Masi li pali e sitelen pi selo ona. /sp/

  mun lili tu li sike e mun Masi. /sp/
  nimi ona li mun Popo li mun Temo. /sp/
  ona li kiwen li sike lukin ala. /sp/
]

#penpo.pakala.open()

#[
  #show: penpo.lasina.sitelen
  #paragraph
]

#[
  #show: penpo.pona.sitelen
  #paragraph
]

