#import "common.typ": *

#penpo.nimisin("Inli", "insa n li ijo", _lili: none)
#penpo.nimisin("Masi", "mun alasa sinpin ijo", _lili: 1)
#penpo.nimisin("Newen", "namako en weka en namako", _lili: "namako/2 namako")

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

#penpo.pakala.open()

#let words = segment("
== mun Masi

suno mi la, mun Masi (toki Inli:", ["Mars"], ")
~ li mun nanpa tu tu lon weka suno Sola.
ona li lili nanpa tu. ~~ mun Masi la mun Mekuliju taso li lili.
ma Tela la, ona li lili. ~~ ma pi mun Masi li jo e kiwen mute.
ona li lete li jo e kon lili.
ona li loje lukin la, nimi ante ona li te mun loje to.
telo li lon ala ma Masi. ~~ taso, kiwen telo lete li lon.
ona li jo e nena ma suli.
nena ma Olinpu Mon li nena ma nanpa wan lon
ma Masi lon kulupu mun suno.
nimi pi mun Masi li sama e jan sewi tan nasin sewi Loma.
jan sewi ni li jan sewi utala.

jan li tawa mun Masi ala. ~~ taso, ilo mun mute li tawa mun Masi.
ma Mewika en ma Elopa
~ en ma Losi en ma Nijon
~ en ma Imalasi en ma Sonko
~ li tawa e ilo tawa mun Masi.
ilo li awen lon selo. ~~ ilo ante li ken tawa lon selo.
ilo Insanjuwisi
~ (toki Inli:", ["Ingenuity"], ") li ken tawa lon kon.
ilo ante li tawa sike e mun Masi li pali e sitelen pi selo ona.

mun lili tu li sike e mun Masi.
nimi ona li mun Popo li mun Temo.
ona li kiwen li sike lukin ala.
")

#show-Lasina(words)

#show-pona(words)

#show-hangul(words)

#show-kanji(words)

#penpo.pakala.pini()
