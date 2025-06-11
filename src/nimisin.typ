#import "aux.typ"
#import "nimi.typ"
#import "nasin-sitelen.typ"
#import "pakala.typ"
#import "kipisi.typ"

#let nimisin-spellings = state("nimisin-spellings", (:))
#let nimisin-shortenable = state("nimisin-shortenable", (:))
#let nimisin-initials = state("nimisin-initials", (:))

#let nimisin-lili-forget() = {
  nimisin-shortenable.update(_ => (:))
  nimisin-initials.update(_ => (:))
}

#let nimisin-kama-lili(nimi, lili, spelling) = context {
  nimisin-shortenable.update(seen => {
    seen.insert(nimi, ())
    seen
  })
  let seen = nimisin-initials.get()
  let key = lili.join(" ")
  if key in seen {
    if nimi != seen.at(key) {
      pakala.sama-sitelen-wan(key, (nimi, spelling), nimisin-initials.get().at(key))
    }
  } else {
    nimisin-initials.update(seen => {
      seen.insert(key, (nimi, spelling))
      seen
    })
  }
}

#let nimisin(word) = (letters) => {
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
  nimisin-spellings.update(nimi => {
    nimi.insert(word, (full: chars, short: chars.slice(0, 1)))
    nimi
  })
}

