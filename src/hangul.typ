#import "aux.typ"
#import "kipisi.typ"
#import "nimi.typ"
#import "pakala.typ"
#import "nasin-sitelen.typ"
#import "nimisin.typ" as libnimisin

#let chart = (
  n: [ㄴ],

  a: [아], an: [안], o: [오], on: [온],
  e: [에], en: [엔], u: [우], un: [운],
  i: [이], "in": [인],

  pa: [바], pan: [반], po: [보], pon: [본],
  pe: [베], pen: [벤], pu: [부], pun: [분],
  pi: [비], pin: [빈],

  ka: [가], kan: [간], ko: [고], kon: [곤],
  ke: [게], ken: [겐], ku: [구], kun: [군],
  ki: [기], kin: [긴],

  sa: [사], san: [산], so: [소], son: [손],
  se: [세], sen: [센], su: [수], sun: [순],
  si: [시], sin: [신],

  ta: [다], tan: [단], to: [도], ton: [돈],
  te: [데], ten: [덴], tu: [두], tun: [둔],
  ti: none, tin: none,

  ma: [마], man: [만], mo: [모], mon: [몬],
  me: [메], men: [멘], mu: [무], mun: [문],
  mi: [미], min: [민],

  na: [나], nan: [난], no: [노], non: [논],
  ne: [네], nen: [넨], nu: [누], nun: [눈],
  ni: [니], nin: [닌],

  la: [라], lan: [란], lo: [로], lon: [론],
  le: [레], len: [렌], lu: [루], lun: [룬],
  li: [리], lin: [린],

  wa: [와], wan: [완], we: [웨], wen: [웬],
  wi: [위], win: [윈],
  wu: none, wun: none, wo: none, won: none,

  ja: [야], jan: [얀], jo: [요], jon: [욘],
  je: [예], jen: [옌], ju: [유], jun: [윤],
  ji: none, jin: none,
)

#let segments(txt) = {
  let classify(c) = {
    let c = lower(c)
    if c == "n" {
      "N"
    } else if c in ("p", "k", "s", "t", "m", "l", "w", "j") {
      "C"
    } else if c in ("a", "o", "e", "u", "i") {
      "V"
    } else if c in (" ", "\n") {
      " "
    } else {
      "X"
    }
  }
  let letters = txt.clusters()
  let letters = letters.map(classify).zip(letters)
  let next(vec) = {
    let take(i) = {
      (vec.slice(0, i).map(x => x.at(1)).join(""), vec.slice(i))
    }
    let matches(pat) = {
      pat.len() <= vec.len() and pat.clusters().zip(vec).map(arg => {
        let (expect, (found, _)) = arg
        expect == found
      }).all(x => x)
    }
    if matches("CVNV") {
      take(2)
    } else if matches("CVN") {
      take(3)
    } else if matches("NVNV") {
      take(2)
    } else if matches("NVN") {
      take(3)
    } else if matches("NV") {
      take(2)
    } else if matches("VNV") {
      take(1)
    } else if matches("VN") {
      take(2)
    } else if matches("CV") {
      take(2)
    } else {
      take(1)
    }
  }
  let letters = letters
  let split = ()
  while letters != () {
    let (head, rest) = next(letters)
    letters = rest
    split.push(head)
  }
  split
}

#let translit(sentence) = {
  text(font: "Noto Serif KR", {
    segments(sentence).map(s => {
      if lower(s) in chart {
        let ans = chart.at(lower(s))
        if ans == none {
          box(fill: red, inset: 0pt)[#s]
        } else if s == lower(s) {
          ans
        } else {
          strong(ans)
        }
      } else {
        box(fill: red, inset: 2pt)[#s]
      }
    }).join([])
  })
}

#let title-markup(line) = {
  if line.at(0).type == "fmt" {
    if line.at(0).symb == "=" {
      (16pt, true, line.slice(1))
    } else if line.at(0).symb == "==" {
      (14pt, true, line.slice(1))
    } else {
      panic[No such markup modifier]
    }
  } else {
    (12pt, false, line)
  }
}

#let spacing-category(old, word) = {
  if word.type == "ext" or word.type == "word" or word.type == "content" {
    if old == "open" or old == "" { ([], "word") } else { ([ ], "word") } 
  } else if word.type == "punct" {
    if word.group == "open" {
      ([ ], word.group)
    } else {
      ([], word.group)
    }
  } else {
    panic[spacing-category of #word.type]
  }
}

#let interp-hangul = state(aux.localize-label("hangul", "punct"), (
  ",": (none, [,], 1),
  ".": (none, [.], 1),
  ":": (none, [:], 1),
  "~": (none, [#h(2mm)], none),
  "~~": (none, [#h(5mm)], none),
  "(": (none, [#h(3mm)---], none),
  ")": (none, [---#h(3mm)], none),
  te: (1, [「], none),
  to: (none, [」], 1),
))

#let punct-interp-hangul(word) = {
  interp-hangul.get().at(word, default: (1, [#text(fill: red, nasin-sitelen.Lasina[
    #{sym.angle.l}#{word}#{sym.angle.r}
  ])], 1))
}

#let sitelen(structure) = {
  structure.map(paragraph => context par(justify: true, {
    let prev-category = ""
    for line in paragraph {
      let (size, bold, line) = title-markup(line)
      text(size: size, font: "Noto Serif KR")[#aux.bold-if(bold)[#{
        for word in line {
          // TODO: improve spacing here
          [ ]
          if word.type == "word" {
            let (word, variant) = kipisi.of-word(word.word)
            if word in nimi.ale {
              let err = pakala.pu-ala-pu(word, "kansi")
              if err != none {
                err.log
                text(fill: err.color)[#translit(word)]
              } else {
                [#translit(word)]
              }
            } else if word in libnimisin.spellings.get() {
              translit(word)
            } else {
              let (color, log) = pakala.pu-ala-pu(word, "sitelen")
              log
              [#text(fill: color, nasin-sitelen.Lasina[
                #{sym.angle.l}#{word}#{sym.angle.r}
              ])]
            }
          } else if word.type == "punct" {
            punct-interp-hangul(word.word).at(1)
          } else if word.type == "content" {
            [#nasin-sitelen.Lasina[#word.val]]
          } else {
            panic[#word.type]
          }
        }
      }]]
      linebreak()
    }
  }))
}
