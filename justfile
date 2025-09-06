doc:
  typst watch --root=. --font-path=sama-ni/fonts docs/main.typ docs/main.pdf

test +cmd:
  tt --font-path=. {{cmd}}
