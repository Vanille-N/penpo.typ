#import "aux.typ"
#import "nimi.typ"
#import "pakala.typ"
#import "split.typ"

/// Return `var` only if between `1` and `max`.
///
/// For our purposes specifically, this is used for word variants in sitelen pona:
/// - if there are no variants, `max = none` and we ignore the variant indicator
/// - if there are several, we choose the right one, defaulting to `none` if
///   the value is invalid.
/// -> int | none
#let clamp(
  /// Number to be clamped. -> int
  var,
  /// Upper value. Setting to `none` will make the return value always `none`.
  /// -> int | none
  max: none,
) = {
  if max == none or var < 1 or var > max {
    none
  } else {
    var
  }
}

/// Split the string to interpret it as a word an a variant number.
/// -> (str, int)
#let detach-num(
  /// Word to split in the format `"word/n"` for the `n`'th variant of `"word"`
  /// -> str
  word
) = {
  if type(word) != str { panic("detach-num expects a string!") }
  if "/" in word {
    let (word, num) = word.split("/")
    (word, int(num))
  } else {
    (word, 1)
  }
}

/// Wraps together `detach-num` and `clamp` to split the word and validate
/// the variant number.
/// -> dict
#let of-word(
  /// Word to split in the format `"word/n"` for the `n`'th variant of `"word"`
  /// -> str
  word
) = {
  let (word, variant) = detach-num(word)
  if word in nimi.ale {
    let id = nimi.ale.at(word)
    let variant = clamp(variant, max: id.maxvar)
    (word: word, variant: variant)
  } else {
    (word: word, variant: none)
  }
}

/// Cuts a text in tokens.
/// This function assumes that a token is a maximal sequence of characters
/// from the same category among
/// - alphanumeric: 'a'-'z', 'A'-'Z', '0'-'9', '/'
/// - blank: ' ', '\t'
/// - linebreaks: '\n'
/// - symbols: everything else
#let segmentation(
  /// -> str
  line
) = {
  let group(chr) = {
    if ("a" <= chr and chr <= "z") or ("A" <= chr and chr <= "Z") {
      "alpha"
    } else if chr == " " {
      "blank"
    } else if chr == "\n" {
      "break"
    } else {
      "other"
    }
  }
  let extract(tok) = tok.tok
  let extends(tok, chr) = {
    if tok.group == "blank" {
      (false, (tok:none))
    } else if tok.tok + chr in ("==", "~~", "\n\n") {
      tok.tok += chr
      (true, tok)
    } else if tok.group == "alpha" {
      if ("a" <= chr and chr <= "z") or ("A" <= chr and chr <= "Z") {
        tok.tok += chr
        (true, tok)
      } else if (chr == "/") or ("0" <= chr and chr <= "9") {
        tok.tok += chr
        (true, tok)
      } else {
        (false, tok)
      }
    } else {
      (false, tok)
    }
  }
  let words = ()
  let idx = 0
  while idx < line.len() {
    let tok = (group: group(line.at(idx)), tok: line.at(idx))
    idx += 1
    while idx < line.len() {
      let add = line.at(idx)
      let (ans, newtok) = extends(tok, add)
      if ans {
        tok = newtok
        idx += 1
      } else {
        words.push(extract(newtok))
        break
      }
    }
  }
  //words
  split.segment(line)
}

/// Turns an alternation of `str` and `content` into a stream of tokens.
/// Strings are split using `segmentation`. Content is as-is.
/// -> array(str or content)
#let nimi-kipisi(
  /// -> array(str or content)
  ..txt
) = {
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

/// Structure the stream of tokens given by `nimi-kipisi` by splitting
/// it per-paragraph and per-line.
/// -> array(array(array(str or content)))
#let nimi-li-seme(
  /// Output of `nimi-kipisi`.
  /// -> array(str or content)
  elems
) = {
  let paragraphs = ()
  let paragraph = ()
  let line = ()
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
        paragraphs.push(paragraph)
        paragraph = ()
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
      }
    }
  }
  if line != () {
    paragraph.push(line)
  }
  if paragraph != () {
    paragraphs.push(paragraph)
  }
  paragraphs
}

