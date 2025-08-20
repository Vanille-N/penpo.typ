#import "extra.typ"

/// Global variable that determines if the library
/// should use English (`kokosila = true`) or
/// toki pona (`kokosila = false`, by default).
/// -> bool
#let kokosila = state(extra.localize-label("kokosila", "kokosila"), false)

/// This toggles the value of the variable `kokosila`,
/// which among other things is queried by `pakala.typ`
/// to determine if error messages should be printed
/// in English or toki pona.
#let toggle() = kokosila.update(b => not b)

/// Choose based on the value of the variable.
/// -> any
#let switch(
  /// Return this if `kokosila = false` -> any
  tp,
  /// Return this if `kokosila = true` -> any
  en,
) = context {
  if kokosila.get() { en } else { tp }
}
