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

/// Wraps together `detach-num` and `clamp` to split the word and validate
/// the variant number.
/// -> dict
#let of-word(
  /// Word to split in the format `"word/n"` for the `n`'th variant of `"word"`
  /// -> str
  word
) = {
  let elems = word.split("/")
  let sem = (base: elems.at(0), var: none)
  for elem in elems.slice(1) {
    // If it's `int`able, we interpret it as a variant number
    let int-like = elem.clusters().all(c => "0" <= c and c <= "9")
    if int-like {
      if sem.var != none { panic("Duplicate int markers") }
      sem.insert("var", int(elem))
      continue
    }
    // Otherwise it's just a string in the options
    panic("Unimplemented")
  }
  sem
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
      for elem in split.into-segments(part) {
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

