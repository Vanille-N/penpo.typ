doc:
  typst watch --root=. --font-path=sama-ni/fonts docs/main.typ docs/main.pdf

test +cmd:
  tt --font-path=. {{cmd}}

publish:
  mkdir -p release
  rm -rf release/*
  cp typst.toml release/
  cp README.md O-LUKIN.md LICENSE.txt LAWA-JASIMA.txt release/
  mkdir -p release/sama-ni
  cp sama-ni/main.svg release/sama-ni/
  cp -r src logo release/
