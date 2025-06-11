// List of known words and associated metadata.
//
// The vocabulary tuples are composed of a subset of the keys
// - group : "word", "open", "close"
// - rarity : "pu", "ku", "sin"
// - maxvar : int >= 1
// - word : content
// - symb : content
//
// More specifically, words of vocabulary have group, rarity, maxvar,
// and items of punctuation have group, symb, word.
//
// Vocabulary:
// - group = "word"
// - rarity = "pu"   -> common word
//          = "ku"   -> uncommon word, usage will result in a mild warning
//          = "sin"  -> obscure word, usage will result in a severe warning
// - maxvar          -> how many variants to the hieroglyph are there
//
// Punctuation
// - group = "close" -> space goes after this symbol
//         = "open"  -> space goes before this symbol
// - word            -> how this punctuation is rendered in latin font
// - symb            -> how this punctuation is rendered in hieroglyphs

// This word is in the base vocabulary.
#let pu(var: none) = (
  group: "word",
  rarity: "pu",
  maxvar: var,
)

// This word is in the extended vocabulary.
#let ku(var: none) = (
  group: "word",
  rarity: "ku",
  maxvar: var,
)

// This word is obscure.
#let sin(var: none) = (
  group: "word",
  rarity: "sin",
  maxvar: var,
)

// This is a punctuation symbol.
#let punct(word, symb, spacing: "close") = (
  word: word,
  symb: symb,
  group: spacing,
)

// Set of punctuation markers.
// This is kind of a fit-all category of markup symbols that are trivial to render
// but aren't rendered identically in latin or sitelen pona.
// This is why "~" and "~~" which aren't *really* punctuation are here
// (because they're trivial) but "=" and "==" are hardcoded elsewhere
// (because those are much less easy to handle).
#let punctuation = (
  te: punct("\"", " te ", spacing: "open"),
  to: punct("\"", " to "),
  ".": punct(".", ""),
  ":": punct(":", ""),
  "!": punct("!", ""),
  ",": punct(",", ""),
  "?": punct("?", ""),
  "~": punct("", h(2.5mm)),
  "~~": punct("", h(5mm)),
  "\\": punct(linebreak(), ""),
)

/// Record of all existing words.
#let ale = (
  a: pu(),
  akesi: pu(var: 2),
  ala: pu(),
  alasa: pu(),
  ale: pu(),
  anpa: pu(),
  ante: pu(),
  anu: pu(),
  awen: pu(),
  e: pu(),
  en: pu(),
  esun: pu(),
  ijo: pu(),
  ike: pu(),
  ilo: pu(),
  insa: pu(),
  jaki: pu(),
  jan: pu(),
  jelo: pu(),
  jo: pu(),
  kala: pu(var: 2),
  kalama: pu(),
  kama: pu(),
  kasi: pu(),
  ken: pu(),
  kepeken: pu(),
  kili: pu(),
  kiwen: pu(),
  ko: pu(),
  kon: pu(),
  kule: pu(),
  kulupu: pu(),
  kute: pu(),
  la: pu(),
  lape: pu(),
  laso: pu(),
  lawa: pu(),
  len: pu(),
  lete: pu(),
  li: pu(),
  lili: pu(),
  linja: pu(),
  lipu: pu(),
  loje: pu(),
  lon: pu(),
  luka: pu(),
  lukin: pu(),
  lupa: pu(),
  ma: pu(),
  mama: pu(),
  mani: pu(),
  mi: pu(),
  moku: pu(),
  moli: pu(),
  monsi: pu(),
  mu: pu(),
  mun: pu(),
  musi: pu(),
  mute: pu(),
  nanpa: pu(),
  nasa: pu(),
  nasin: pu(),
  nena: pu(),
  ni: pu(var: 2),
  nimi: pu(),
  noka: pu(),
  o: pu(),
  olin: pu(var: 3),
  ona: pu(),
  open: pu(),
  pakala: pu(),
  pali: pu(),
  palisa: pu(),
  pan: pu(),
  pana: pu(),
  pi: pu(),
  pilin: pu(),
  pimeja: pu(),
  pini: pu(),
  pipi: pu(),
  poka: pu(),
  poki: pu(),
  pona: pu(),
  pu: pu(),
  sama: pu(),
  seli: pu(),
  selo: pu(),
  seme: pu(),
  sewi: pu(var: 2),
  sijelo: pu(),
  sike: pu(),
  sin: pu(),
  sina: pu(),
  sinpin: pu(),
  sitelen: pu(),
  sona: pu(),
  soweli: pu(),
  suli: pu(),
  suno: pu(),
  supa: pu(),
  suwi: pu(),
  tan: pu(),
  taso: pu(),
  tawa: pu(),
  telo: pu(),
  tenpo: pu(),
  toki: pu(),
  tomo: pu(),
  tu: pu(),
  unpa: pu(),
  uta: pu(var: 2),
  utala: pu(),
  walo: pu(),
  wan: pu(),
  waso: pu(),
  wawa: pu(),
  weka: pu(),
  wile: pu(var: 2),
  kijetesantakalu: ku(),
  kin: ku(),
  kipisi: ku(),
  ku: ku(),
  leko: ku(),
  meli: ku(var: 2),
  mije: ku(var: 2),
  misikeke: ku(),
  monsuta: ku(),
  n: ku(),
  namako: ku(var: 2),
  soko: ku(var: 3),
  tonsi: ku(),
  ali: ku(),
  epiku: ku(var: 2),
  jasima: ku(),
  lanpan: ku(var: 2),
  linluwi: ku(var: 3),
  majuna: ku(var: 3),
  meso: ku(),
  nimisin: ku(),
  oko: ku(),
  su: ku(),
  apeja: sin(),
  isipin: sin(),
  jami: sin(),
  jonke: sin(),
  kamalawala: sin(),
  kapesi: sin(var: 3),
  kiki: sin(),
  kokosila: sin(),
  konwe: sin(),
  kulijo: sin(),
  melome: sin(),
  mijomi: sin(),
  misa: sin(var: 2),
  mulapisu: sin(),
  nja: sin(),
  ojuta: sin(),
  oke: sin(),
  omekapo: sin(),
  owe: sin(),
  pake: sin(),
  pakola: sin(),
  penpo: sin(),
  pika: sin(),
  po: sin(),
  powe: sin(),
  puwa: sin(),
  san: sin(),
  soto: sin(),
  sutopatikuna: sin(),
  taki: sin(var: 2),
  teje: sin(),
  unu: sin(),
  usawi: sin(),
  wa: sin(),
  wasoweli: sin(),
  wekama: sin(),
  wuwojiti: sin(),
  yupekosi: sin(),
)

