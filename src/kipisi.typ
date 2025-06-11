#import "aux.typ"
#import "nimi.typ"
#import "pakala.typ"

#let sitelen-ante-nanpa(var, max: none) = {
  if max == none or var < 1 or var > max {
    none
  } else {
    var
  }
}

#let detach-num(word) = {
  if "/" in word {
    let (word, num) = word.split("/")
    (word, int(num))
  } else {
    (word, 1)
  }
}

#let segmentation(line) = {
  let words = ()
  let start = 0
  let end = 0
  let category(char) = {
    if ("a" <= char and char <= "z") or ("A" <= char and char <= "Z") or (char == "/") or ("0" <= char and char <= "9") {
      "alpha"
    } else if char in (" ", "\t") {
      "blank"
    } else {
      "symb"
    }
  }
  while start < line.len() {
    while end < line.len() and category(line.at(start)) == category(line.at(end)) {
      end += 1
    }
    if category(line.at(start)) != "blank" {
      words.push(line.slice(start, end))
    }
    start = end
  }
  words
}

#let nimi-kipisi(txt) = {
  let lines = txt.split("\n")
  let paragraphs = ()
  let paragraph = ()
  let errors = ()
  for line in lines + ("",) {
    if line == "" {
      if paragraph != () {
        paragraphs.push((par: paragraph, err: errors.filter(x => x != none)))
        paragraph = ()
        errors = ()
      }
      continue
    }
    let words = ()
    for word in segmentation(line) {
      let (word, variant) = detach-num(word)
      if word in nimi.ale {
        errors.push(pakala.pu-ala-pu(word, "nimi"))
        let id = nimi.ale.at(word)
        words.push((
          type: "word",
          var: sitelen-ante-nanpa(variant, max: id.maxvar),
          word: word,
        ))
      } else if word in nimi.punctuation {
        let id = nimi.punctuation.at(word)
        id.insert("type", "punct")
        words.push(id)
      } else if word == "=" or word == "==" {
        words.push((type: "fmt", symb: word))
      } else {
        words.push((
          type: "ext",
          var: none,
          word: word,
        ))
      }
    }
    paragraph.push(words)
  }
  paragraphs
}

