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
  if type(word) != str { panic("detach-num expects a string!") }
  if "/" in word {
    let (word, num) = word.split("/")
    (word, int(num))
  } else {
    (word, 1)
  }
}

#let of-word(word) = {
  let (word, variant) = detach-num(word)
  if word in nimi.ale {
    let id = nimi.ale.at(word)
    let variant = sitelen-ante-nanpa(variant, max: id.maxvar)
    (word: word, variant: variant)
  } else {
    (word: word, variant: none)
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
    } else if char == "\n" {
      "newline"
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

#let nimi-kipisi(..txt) = {
  let nimi = ()
  for part in txt.pos() {
    if type(part) == str {
      for elem in segmentation(part) {
        nimi.push(elem)
      }
    } else {
      nimi.push(part)
    }
  }
  nimi
}

#let nimi-li-seme(elems) = {
  let paragraphs = ()
  let paragraph = ()
  let line = ()
  let errors = ()
  for elem in elems {
    if type(elem) == content {
      line.push((type: "content", val: elem))
    } else if type(elem) == str {
      if elem == "\n" {
        if line != () {
          paragraph.push(line)
          line = ()
        }
      } else if elem == "\n\n" {
        paragraph.push(line)
        line = ()
        paragraphs.push((par: paragraph, err: errors.filter(x => x != none)))
        paragraph = ()
        errors = ()
      } else if elem in nimi.punctuation {
        let id = nimi.punctuation.at(elem)
        id.insert("type", "punct")
        line.push(id)
      } else if elem == "=" or elem == "==" {
        // TODO: validate that this comes at the beginning of a line somewhere ?
        line.push((type: "fmt", symb: elem))
      } else {
        line.push((
          type: "word",
          word: elem,
        ))
        //let (word, variant) = detach-num(elem)
        //if word in nimi.ale {
        //  let id = nimi.ale.at(word)
        //  let variant = sitelen-ante-nanpa(variant, max: id.maxvar)
        //  errors.push(pakala.pu-ala-pu(word, "nimi", nanpa-ante: variant))
        //  line.push((
        //    type: "word",
        //    var: variant,
        //    word: word,
        //  ))
        //} else {
        //  line.push((
        //    type: "ext",
        //    var: none,
        //    word: word,
        //  ))
        //}
      }
    }
  }
  if line != () {
    paragraph.push(line)
  }
  if paragraph != () {
    paragraphs.push((par: paragraph, err: errors.filter(x => x != none)))
  }
  paragraphs
}

