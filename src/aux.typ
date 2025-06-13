// Conditional bold formatting.
#let bold-if(b, t) = {
  if b [*#t*] else [ #t ]
}

// Bypass the fact that `none` is not `str`-able,
// by turning `none` into `""`.
#let str-some(x) = {
  if x == none {
    ""
  } else {
    str(x)
  }
}

// Global variables made unique.
#let localize-label(file, lab) = "@penpo/" + file + ":" + lab

// Creates a new logging triplet.
// That is, a global variable that contains a log of errors is created
// and closured into 3 functions:
// - `begin` prints the errors in the log
// - `push` adds a new error in the log
// - `end` is a label that marks the end of the log
//
// `lab` should be globally unique.
#let make-new-log(lab) = {
  let log = state(lab, (:))
  let lab = localize-label("aux", lab)
  // Label that marks the end of the collection of errors
  let end() = [#[]#label(lab)]
  // Print logging
  let begin(title) = context {
    let errors = log.at(label(lab)).values().sorted(key: k => k.at(0))
    if errors != () {
      text(fill: red)[*#title*]
      for (_, _, count, msg) in errors [
        - #msg #text(fill: gray.darken(20%))[($times #count$)] \
      ]
    }
  }
  // Add a new entry in the log
  let push(color, uid, badness, msg) = {
    log.update(acc => {
      if uid not in acc {
        acc.insert(uid, (badness, uid, 1, text(fill: color, msg)))
      } else {
        let (badness, uid, count, cont) = acc.at(uid)
        acc.insert(uid, (badness, uid, count + 1, cont))
      }
      acc
    })
  }

  (begin, push, end)
}

