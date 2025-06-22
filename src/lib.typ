#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kokosila.typ"

#import "hangul.typ"
#import "kanji.typ"

#import "nimisin.typ" as libnimisin
#import libnimisin: nimisin, nimisin-mute

#import "kipisi.typ"
#import "kipisi.typ": nimi-kipisi

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

#let interp-Lasina = state(aux.localize-label("Lasina", "punct"), (
  ".": (none, [.], 1),
  ",": (none, [,], 1),
  ":": (none, [:], 1),
  "!": (none, [!], 1),
  "?": (none, [?], 1),
  "te": (1, smartquote(), none),
  "to": (none, smartquote(), 1),
  "(": (1, [(], none),
  ")": (none, [)], 1),
  "~": (none, none, none),
  "~~": (none, none, none),
))

#let punct-interp-Lasina(word) = {
  interp-Lasina.get().at(word, default: (1, [#text(fill: red, nasin-sitelen.Lasina[
    #{sym.angle.l}#{word}#{sym.angle.r}
  ])], 1))
}

#let sitelen-Lasina(structure) = {
  structure.map(paragraph => context par(justify: true, {
    let prev-category = ""
    for line in paragraph {
      let (size, bold, line) = title-markup(line)
      if bold {
        libnimisin.nimisin-lili-forget()
      }
      text(size: size)[#aux.bold-if(bold)[#{
        let prevspace = none
        for word in line {
          let (space-pre, space-post) = {
            if word.type == "word" {
              (1, 1)
            } else if word.type == "punct" {
              let (pre, _, post) = punct-interp-Lasina(word.word)
              (pre, post)
            } else {
              (0, 0)
            }
          }
          aux.autospace(prevspace, space-pre)
          prevspace = space-post
          if word.type == "word" {
            let (base,) = kipisi.of-word(word.word)
            [#base]
          } else if word.type == "punct" {
            [#punct-interp-Lasina(word.word).at(1)]
          } else if word.type == "content" {
            [#word.val]
          } else {
            panic[#word.type]
          }
        }
      }]]
    }
  }))
}

#let interp-pona = state(aux.localize-label("pona", "punct"), (
  ",": (none, [ ], none),
  ".": (none, [#h(5mm)], none),
  ":": (none, [#h(1mm)], none),
  "~": (none, [#h(2mm)], none),
  "~~": (none, [#h(5mm)], none),
  "(": (none, [#h(3mm)---], none),
  ")": (none, [---#h(3mm)], none),
  te: (none, [ te ], none),
  to: (none, [ to ], none),
))

#let punct-interp-pona(word) = {
  interp-pona.get().at(word, default: (1, [#text(fill: red, nasin-sitelen.Lasina[
    #{sym.angle.l}#{word}#{sym.angle.r}
  ])], 1))
}

#let sitelen-pona(structure) = {
  structure.map(paragraph => context par(justify: true, {
    let prev-category = ""
    for line in paragraph {
      let (size, bold, line) = title-markup(line)
      text(size: size)[#nasin-sitelen.seli-kiwen[#aux.bold-if(bold)[#{
        for word in line {
          context if word.type == "word" {
            let (base, var) = kipisi.of-word(word.word)
            if base in nimi.ale {
              let err = pakala.pu-ala-pu(base, "sitelen", nanpa-ante: var)
              if err != none {
                err.log
                text(fill: err.color)[#base#var]
              } else {
                [#base#var]
              }
            } else if base in libnimisin.spellings.get() {
              let data = libnimisin.spellings.get().at(base)
              let shorten = base in libnimisin.shortenable.get()
              let spelling = if shorten { data.short } else { data.full }
              [#nasin-sitelen.Nimi(spelling)]
              if not shorten {
                libnimisin.nimisin-kama-lili(base, data.short, spelling)
              }
            } else {
              let (color, log) = pakala.pu-ala-pu(base, "sitelen")
              log
              [#text(fill: color, nasin-sitelen.Lasina[
                #{sym.angle.l}#{base}#{sym.angle.r}
              ])]
            }
          } else if word.type == "punct" {
            punct-interp-pona(word.word).at(1)
          } else if word.type == "content" {
            [#nasin-sitelen.Lasina[#word.val]]
          } else {
            panic[#word.type]
          }
        }
      }]]]
      linebreak()
    }
  }))
}

