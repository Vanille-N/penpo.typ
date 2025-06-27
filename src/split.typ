// An experimental lexer
// word :: [a-zA-Z][a-ZA-Z0-9]*
// number :: [0-9]+
// markup :: = == ~ ~~ - -- ---
// punctuation :: , . ? ! : ; ( ) { } [ ] ' "
// newlines :: \n \n\n
// with-variant :: (word | markup | punctuation) ( / [a-zA-Z0-9+-]+ )*

#let classify(chr) = {
  if chr == none {
    "none"
  } else if ("a" <= chr and chr <= "z") or ("A" <= chr and chr <= "Z") {
    "alpha"
  } else if ("0" <= chr and chr <= "9") {
    "num"
  } else if (chr in "=~-") {
    "markup"
  } else if (chr in " ") {
    "space"
  } else if (chr in "\n") {
    "newline"
  } else if (chr in "\\") {
    "linebreak"
  } else if (chr in ",.?!:;()\"") {
    "punct"
  } else if (chr in "/") {
    "sep"
  } else {
    panic(chr)
  }
}

#let take-one(txt) = {
  (txt.slice(0, 1), 1)
}

#let take-while-alpha(txt) = {
  let i = 0
  while classify(txt.at(i, default: none)) in ("alpha", "num") {
    i += 1
  }
  (txt.slice(0, i), i)
}

#let take-while-num(txt) = {
  let i = 0
  while classify(txt.at(i, default: none)) in ("alpha", "num") {
    i += 1
  }
  (txt.slice(0, i), i)
}

#let skip-while-space(txt) = {
  let i = 0
  while classify(txt.at(i, default: none)) == "space" {
    i += 1
  }
  (none, i)
}

#let take-full-sep(txt) = {
  let i = 1
  while i < txt.len() and (txt.at(i, default: none) in "-+" or classify(txt.at(i, default: none)) in ("alpha", "num")) {
    i += 1
  }
  (txt.slice(0, i), i)
}

#let take-identical(txt) = {
  let i = 0
  while txt.at(i, default: none) == txt.at(0) {
    i += 1
  }
  (txt.slice(0, i), i)
}

#let into-segments(txt) = {
  let fragments = ()
  let start = 0
  while start < txt.len() {
    let initial = txt.at(start)
    let class = classify(initial)
    let (handler, allows-options) = (
      alpha: (take-while-alpha, true),
      space: (skip-while-space, false),
      punct: (take-one, true),
      newline: (take-identical, false),
      markup: (take-identical, false),
      num: (take-while-num, false),
      sep: (take-full-sep, false),
      linebreak: (take-one, true),
    ).at(class)
    let (tok, next) = handler(txt.slice(start))
    start += next
    if allows-options {
      while start < txt.len() and txt.at(start) == "/" {
        let (extra, next) = take-full-sep(txt.slice(start))
        tok += extra
        start += next
      }
    }
    if tok != none {
      fragments.push(tok)
    }
  }
  fragments
}

#let test(input, expected) = rect({
  let expected = expected.split("|")
  let output = into-segments(input)
  if output == expected {
    text(fill: green)[All OK]
    return
  }
  for i in range(calc.max(output.len(), expected.len())) {
    let left = output.at(i, default: "")
    let right = expected.at(i, default: "")
    if left == right {
      text(fill: green)[(#left)]
    } else {
      text(fill: red)[[#strike[#left]|#right]]
    }
  }
})

#test("mi olin e kalama musi pi jan Usawi a", "mi|olin|e|kalama|musi|pi|jan|Usawi|a")

#test("mi(jan! o\n???: )", "mi|(|jan|!|o|\n|?|?|?|:|)")

#test("- -- ---e----- =o==~~", "-|--|---|e|-----|=|o|==|~~")

#test("olin3 a2 2044", "olin3|a2|2044")

#test("awen/3/+en :/An ?/-La,\"", "awen/3/+en|:/An|?/-La|,|\"")

#test("test

test \\/+kr", "test|\n\n|test|\\/+kr")
