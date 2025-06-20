#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kipisi.typ"

#let localize-label(lab) = aux.localize-label("nimisin", lab)

#let spellings = state(localize-label("spellings"), (:))
#let shortenable = state(localize-label("shortenable"), (:))
#let initials = state(localize-label("initials"), (:))

// TODO: allow configuring when this is called
#let nimisin-lili-forget() = {
  shortenable.update(_ => (:))
  initials.update(_ => (:))
}

#let nimisin-kama-lili(nimi, lili, spelling) = context {
  if lili == none {
    return
  }
  shortenable.update(seen => {
    seen.insert(nimi, ())
    seen
  })
  let seen = initials.get()
  let key = lili.join(" ")
  if key in seen {
    if nimi != seen.at(key) {
      pakala.sama-sitelen-wan(key, (nimi, spelling), initials.get().at(key))
    }
  } else {
    initials.update(seen => {
      seen.insert(key, (nimi, spelling))
      seen
    })
  }
}

#let nimisin(word, letters, _lili: auto) = {
  let errors = ()
  let letters = letters.split(" ").filter(w => w != "")
  if word.len() != letters.len() {
    pakala.nanpa-ante(word, letters)
    return
  }
  if not ("A" <= word.at(0) and word.at(0) <= "Z") {
    pakala.lili-ike(word.at(0), word)
  }
  for l in word.slice(1) {
    if not ("a" <= l and l <= "z") {
      pakala.suli-ike(l, word)
    }
  }
  let chars = ()
  for char in letters {
    let (word, variant) = kipisi.of-word(char)
    let word = if word in nimi.ale {
      let err = pakala.pu-ala-pu(word, "sitelen", nanpa-ante: variant)
      if err != none {
        errors.push(err.log)
      }
      char + aux.str-some(variant)
    } else {
      errors.push(pakala.sitelen-ala(char))
      "???"
    }
    chars.push(word)
  }
  for (letter, hieroglyph) in word.clusters().zip(chars) {
    if hieroglyph.at(0) != "?" and lower(letter) != hieroglyph.at(0) {
      errors.push(pakala.sitelen-ante(letter, hieroglyph, word, letters))
    }
  }
  for error in errors {
    error
  }
  let short = if _lili == auto {
    chars.slice(0, 1)
  } else if _lili == none {
    none
  } else if type(_lili) == int {
    chars.slice(0, _lili)
  } else if type(_lili) == str {
    let short = ()
    for char in _lili.split(" ") {
      let (word, variant) = kipisi.of-word(char)
      let word = if word in nimi.ale {
        let (color, log) = pakala.pu-ala-pu(word, "sitelen", nanpa-ante: variant)
        // TODO: use bad
        errors.push(log)
        word + aux.str-some(variant)
      } else {
        errors.push(pakala.sitelen-ala(char))
        "???" // TODO: make it red in the text
      }
      short.push(word)
    }
    short
  } else {
    panic("_lili of type '" + str(type(_lili)) + "' cannot be interpreted.")
  }
  spellings.update(nimi => {
    nimi.insert(word, (full: chars, short: short))
    nimi
  })
}

#let nimisin-mute(_lili: auto, ..args) = {
  for (key, val) in args.named() {
    nimisin(key, val, _lili: _lili)
  }
}
