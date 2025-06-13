#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kipisi.typ"

#let localize-label(lab) = aux.localize-label("nimisin", lab)

#let spellings = state(localize-label("spellings"), (:))
#let shortenable = state(localize-label("shortenable"), (:))
#let initials = state(localize-label("initials"), (:))

#let nimisin-lili-forget() = {
  shortenable.update(_ => (:))
  initials.update(_ => (:))
}

#let nimisin-kama-lili(nimi, lili, spelling) = context {
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

#let nimisin-wan(word) = (letters) => {
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
    let (char, variant) = kipisi.detach-num(char)
    let char = if char in nimi.ale {
      errors.push(pakala.pu-ala-pu(char, "sitelen"))
      let variant = kipisi.sitelen-ante-nanpa(variant, max: nimi.ale.at(char).maxvar)
      char + aux.str-some(variant)
    } else {
      errors.push(pakala.sitelen-ala(char))
      "???"
    }
    chars.push(char)
  }
  for (letter, hieroglyph) in word.clusters().zip(letters) {
    if hieroglyph.at(0) != "?" and lower(letter) != hieroglyph.at(0) {
      errors.push(pakala.sitelen-ante(letter, hieroglyph, word, letters))
    }
  }
  for error in errors {
    error
  }
  spellings.update(nimi => {
    nimi.insert(word, (full: chars, short: chars.slice(0, 1)))
    nimi
  })
}

#let nimisin(..args) = {
  for (key, val) in args.named() {
    nimisin-wan(key)(val)
  }
}
