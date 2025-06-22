#import "aux.typ"
#import "kipisi.typ"
#import "nimi.typ"
#import "pakala.typ"
#import "nasin-sitelen.typ"
#import "nimisin.typ" as libnimisin

#let chart = (
  n: [ん],

   a: [あ],  i: [い],  u: [う],  e: [え],  o: [お],
  pa: [あ], pi: [い], pu: [う], pe: [え], po: [お],
  ka: [ぱ], ki: [ぴ], ku: [ぷ], ke: [ぺ], ko: [ぽ],
  sa: [か], si: [き], su: [く], se: [け], so: [こ],
  ta: [た], ti: none, tu: [つ], te: [て], to: [と],
  ma: [ま], mi: [み], mu: [む], me: [め], mo: [も],
  na: [な], ni: [に], nu: [ぬ], ne: [ね], no: [の],
  la: [ら], li: [り], lu: [る], le: [れ], lo: [ろ],
  wa: [わ], wi: [ゐ], wu: none, we: [ゑ], wo: none,
  ja: [や], ji: none, ju: [ゆ], je: [よ], jo: [よ],
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
    if matches("CV") {
      take(2)
    } else if matches("NV") {
      take(2)
    } else if matches("VN") {
      take(1)
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
  segments(sentence).map(s => {
    if lower(s) in chart {
      let ans = chart.at(lower(s))
      if ans == none {
        box(fill: red, inset: 0pt)[#s]
      } else if s == lower(s) {
        ans
      } else {
        strong(ans) // TODO: fix the strong not showing up
      }
    } else {
      box(fill: red, inset: 2pt)[#s]
    }
  }).join([])
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

#let interp-kanji = state(aux.localize-label("kanji", "punct"), (
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

#let punct-interp-kanji(word) = {
  interp-kanji.get().at(word, default: (1, [#text(fill: red, nasin-sitelen.Lasina[
    #{sym.angle.l}#{word}#{sym.angle.r}
  ])], 1))
}

#let sitelen(structure) = {
  structure.map(paragraph => par(justify: true, {
    let prev-category = ""
    for line in paragraph {
      let (size, bold, line) = title-markup(line)
      text(size: size)[#aux.bold-if(bold)[#{
        for word in line {
          let (spacing, next) = spacing-category(prev-category, word)
          [#spacing]
          prev-category = next
          context if word.type == "word" {
            let (base, var) = kipisi.of-word(word.word)
            if base in nimi.ale {
              let err = pakala.pu-ala-pu(base, "kanji")
              if err != none {
                err.log
                text(fill: err.color)[#translit(base)]
              } else {
                translit(base)
              }
            } else if base in libnimisin.spellings.get() {
              translit(base)
            } else {
              let (color, log) = pakala.pu-ala-pu(base, "sitelen")
              log
              [#text(fill: color, nasin-sitelen.Lasina[
                #{sym.angle.l}#{base}#{sym.angle.r}
              ])]
            }
          } else if word.type == "punct" {
            punct-interp-kanji(word.word).at(1)
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
