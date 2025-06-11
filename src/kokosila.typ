#let kokosila = state("kokosila", false)

#let toggle() = kokosila.update(b => not b)

#let switch(tp, en) = context {
  if kokosila.get() { en } else { tp }
}
