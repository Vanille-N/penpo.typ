#import "common.typ": *

#let txt = "
== mun Masi

suno mi la, mun Masi (toki Inli:)
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
~ (toki Inli:) li ken tawa lon kon.
ilo ante li tawa sike e mun Masi li pali e sitelen pi selo ona.

mun lili tu li sike e mun Masi.
nimi ona li mun Popo li mun Temo.
ona li kiwen li sike lukin ala.
"

#let split-old = penpo.kipisi.segmentation(txt).filter(x => x != none)
#let split-new = penpo.kipisi.split.segment(txt)

#let diff(old, new) = rect({
  if old == new {
    text(fill: green)[All OK]
    return
  }
  for i in range(calc.max(new.len(), old.len())) {
    let left = old.at(i, default: "")
    let right = new.at(i, default: "")
    if left == right {
      text(fill: green)[(#left)]
    } else {
      text(fill: red)[[#strike[#left]|#right]]
    }
  }
})

#diff(split-old, split-new)
