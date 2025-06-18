#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kokosila.typ"

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
          if word.type == "word" {
            let (word,) = kipisi.of-word(word.word)
            [#word]
          } else if word.type == "punct" {
            [#word.word]
          } else if word.type == "content" {
            [#word.val]
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
          context if word.type == "word" {
            let (word,variant) = kipisi.of-word(word.word)
            if word in nimi.ale {
              pakala.pu-ala-pu(word, "sitelen")
              [#word#variant]
            } else if word in libnimisin.spellings.get() {
              let data = libnimisin.spellings.get().at(word)
              let shorten = word in libnimisin.shortenable.get()
              let spelling = if shorten { data.short } else { data.full }
              [#nasin-sitelen.Nimi(spelling)]
              if not shorten {
                libnimisin.nimisin-kama-lili(word, data.short, spelling)
              }
            } else {
              [#text(fill: red, nasin-sitelen.Lasina[
                #{sym.angle.l}#{word.word}#{sym.angle.r}
              ])]
            }
          } else if word.type == "punct" {
            [#word.symb]
          } else if word.type == "content" {
            [#nasin-sitelen.Lasina[#word.val]]
          } else {
            panic[#word.type]
          }
        }
      }]]]
      linebreak()
    }
    for a in paragraph.err { a }
  }))
}

