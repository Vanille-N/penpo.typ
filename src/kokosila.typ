#import "aux.typ"

#let kokosila = state(aux.localize-label("kokosila", "kokosila"), false)

#let toggle() = kokosila.update(b => not b)

#let switch(tp, en) = context {
  if kokosila.get() { en } else { tp }
}
