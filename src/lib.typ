#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kokosila.typ"

#import "nimisin.typ" as libnimisin
#import libnimisin: nimisin

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

#let spacing-category(old, word) = {
  if word.type == "ext" or word.type == "word" {
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

#let sitelen-Lasina(structure) = {
  structure.map(paragraph => par(justify: true, {
    let prev-category = ""
    for line in paragraph.par {
      let (size, bold, line) = title-markup(line)
      if bold {
        libnimisin.nimisin-lili-forget()
      }
      text(size: size)[#aux.bold-if(bold)[#{
        for word in line {
          let (spacing, next) = spacing-category(prev-category, word)
          [#spacing]
          prev-category = next
          if word.type == "ext" {
            [#word.word]
          } else if word.type == "word" {
            [#word.word]
          } else if word.type == "punct" {
            [#word.word]
          } else {
            panic[#word.type]
          }
        }
      }]]
    }
    for a in paragraph.err { a }
  }))
}

#let sitelen-pona(structure) = {
  structure.map(paragraph => par(justify: true, {
    let prev-category = ""
    for line in paragraph.par {
      let (size, bold, line) = title-markup(line)
      text(size: size)[#nasin-sitelen.seli-kiwen[#aux.bold-if(bold)[#{
        for word in line {
          let (spacing, next) = spacing-category(prev-category, word)
          [#spacing]
          prev-category = next
          if word.type == "ext" {
            context {
              if word.word in libnimisin.nimisin-spellings.get() {
                let data = libnimisin.nimisin-spellings.get().at(word.word)
                let shorten = word.word in libnimisin.nimisin-shortenable.get()
                let spelling = if shorten { data.short } else { data.full }
                [#nasin-sitelen.Nimi(spelling)]
                if not shorten {
                  libnimisin.nimisin-kama-lili(word.word, data.short, spelling)
                }
              } else {
                [#text(fill: red, nasin-sitelen.Lasina[
                  #{sym.angle.l}#{word.word}#{sym.angle.r}
                ])]
                pakala.pu-ala-pu(word.word, "nimi")
              }
            }
          } else if word.type == "word" {
            [#word.word#word.var]
          } else if word.type == "punct" {
            [#word.symb]
          } else {
            panic[#word.type]
          }
        }
      }]]]
      [\ ]
    }
    for a in paragraph.err { a }
  }))
}

