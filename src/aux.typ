/// Conditional bold formatting.
#let bold-if(b, t) = {
  if b [*#t*] else [ #t ]
}

/// Bypass the fact that `none` is not `str`-able.
#let str-some(x) = {
  if x == none {
    ""
  } else {
    str(x)
  }
}

#let make-new-log(lab) = {
  let log = state(lab, (:))
  let end() = [#[]#label(lab)]
  let begin(title) = context {
    let errors = log.at(label(lab)).values().sorted(key: k => k.at(0))
    if errors != () {
      text(fill: red)[*#title*]
      for (_, _, count, msg) in errors [
        - #msg #text(fill: gray.darken(20%))[($times #count$)] \
      ]
    }
  }
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

