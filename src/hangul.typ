#import "extra.typ"
#import "kipisi.typ"
#import "nimi.typ"
#import "pakala.typ"
#import "nasin-sitelen.typ"
#import "nimisin.typ" as libnimisin

// TODO: Use quotes not te/to

#let special-words = (
  n: [ㄴ],
  nja: [냐],

  yupekosi: [쥬페코시],
  yubekosi: [쥬베코시],
  yupegosi: [쥬페고시],
  yubegosi: [쥬베고시],

  wuwojiti: [우우오오이이티],
  wuwojidi: [우우오오이이디],
)

#let chart = (
  a: [아], an: [안], o: [오], on: [온],
  e: [에], en: [엔], u: [우], un: [운],
  i: [이], "in": [인],

  ba: [바], ban: [반], bo: [보], bon: [본],
  be: [베], ben: [벤], bu: [부], bun: [분],
  bi: [비], bin: [빈],

  ga: [가], gan: [간], go: [고], gon: [곤],
  ge: [게], gen: [겐], gu: [구], gun: [군],
  gi: [기], gin: [긴],

  da: [다], dan: [단], do: [도], don: [돈],
  de: [데], den: [덴], du: [두], dun: [둔],
  di: none, din: none,

  pa: [파], pan: [판], po: [포], pon: [폰],
  pe: [페], pen: [펜], pu: [푸], pun: [푼],
  pi: [피], pin: [핀],

  ka: [카], kan: [칸], ko: [코], kon: [콘],
  ke: [케], ken: [켄], ku: [쿠], kun: [쿤],
  ki: [키], kin: [킨],

  ta: [타], tan: [탄], to: [토], ton: [톤],
  te: [테], ten: [텐], tu: [투], tun: [툰],
  ti: none, tin: none,

  sa: [사], san: [산], so: [소], son: [손],
  se: [세], sen: [센], su: [수], sun: [순],
  si: [시], sin: [신],
 
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
  nwa: [놔], nwan: [놘], nwe: [눼], nwen: [눤],
  nwi: [뉘], nwin: [뉜],
  nwu: none, nwun: none, nwo: none, nwon: none,

  ja: [야], jan: [얀], jo: [요], jon: [욘],
  je: [예], jen: [옌], ju: [유], jun: [윤],
  ji: none, jin: none,
  nja: [냐], njan: [냔], njo: [뇨], njon: [뇬],
  nje: [녜], njen: [녠], nju: [뉴], njun: [뉸],
  nji: none, njin: none,
)

#let make-voiced(word) = {
  word.replace("p", "b").replace("t", "d").replace("k", "g")
}

#let segments(txt, strict-cvn: false) = {
  let classify(c) = {
    let c = lower(c)
    if c in ("p", "k", "s", "t", "b", "g", "d", "m", "l", "w", "j", "n") {
      "C"
    } else if c in ("a", "o", "e", "u", "i") {
      "V"
    } else {
      panic("unsupported character: '" + c + "'")
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
        let (expect, (found, exact)) = arg
        if expect == lower(expect) {
          expect == lower(exact)
        } else {
          expect == found
        }
      }).all(x => x)
    }
    if false {
    } else if matches("VnV") {
      take(1)
    } else if matches("Vn") {
      take(2)
    } else if matches("CVnV") {
      take(2)
    } else if matches("CVn") {
      take(3)
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
  if not strict-cvn {
    for i in range(split.len() - 1) {
      if split.at(i).last() == "n" and split.at(i + 1).first() in "wj" {
        split.at(i) = split.at(i).slice(0, -1)
        split.at(i + 1) = "n" + split.at(i + 1)
      }
    }
  }
  split
}

#let translit(word, voiced: true, strict-cvn: false) = {
  if voiced {
    word = make-voiced(word)
  }
  text(font: "Noto Serif KR", {
    if word in special-words {
      special-words.at(word)
    } else {
      segments(word, strict-cvn: strict-cvn).map(s => {
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
    }
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
  "-": (1, [-], 1),
  "--": (1, [--], 1),
  "---": (1, [---], 1),
  "?": (0, [?], 1),
  "!": (0, [!], 1),
  te: (1, [「], none),
  to: (none, [」], 1),
))

#let punct-interp-hangul(word) = {
  interp-hangul.get().at(word, default: (1, [#text(fill: red, nasin-sitelen.Lasina[
    #{sym.angle.l}#{word}#{sym.angle.r}
  ])], 1))
}

#let sitelen(structure, ..params) = {
  let voiced = params.named().at("voiced", default: true)
  let strict-cvn = params.named().at("strict-cvn", default: false)
  structure.map(paragraph => context par(justify: true, {
    let prev-category = ""
    for line in paragraph {
      let (size, bold, line) = title-markup(line)
      text(size: size, font: "Noto Serif KR")[#aux.bold-if(bold)[#{
        for word in line {
          // TODO: improve spacing here
          [ ]
          if word.type == "word" {
            let (base, var) = kipisi.of-word(word.word)
            let chrs-base = translit(base, voiced: voiced, strict-cvn: strict-cvn)
            if base in nimi.ale {
              let err = pakala.pu-ala-pu(base)
              if err != none {
                err.log
                text(fill: err.color)[#chrs-base]
              } else {
                [#chrs-base]
              }
            } else if base in libnimisin.spellings.get() {
              chrs-base
            } else {
              let (color, log) = pakala.pu-ala-pu(base)
              log
              text(fill: color)[#chrs-base]
            }
          } else if word.type == "punct" {
            punct-interp-hangul(word.word).at(1)
          } else if word.type == "content" {
            nasin-sitelen.Lasina[#word.val]
          } else {
            panic[#word.type]
          }
        }
      }]]
      linebreak()
    }
  }))
}
