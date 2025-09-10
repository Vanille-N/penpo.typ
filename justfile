doc:
  typst watch --root=. --font-path=sama-ni/fonts docs/main.typ docs/main.pdf

test +cmd:
  tt --font-path=. {{cmd}}

scrybe:
  scrybe README.md O-LUKIN.md typst.toml --version=0.1.0

scrybe-publish:
  scrybe release/README.md release/O-LUKIN.md release/typst.toml --publish --version=0.1.0

publish:
  mkdir -p release
  rm -rf release/*
  cp typst.toml release/
  cp README.md O-LUKIN.md LICENSE.txt LAWA-JASIMA.txt release/
  mkdir -p release/sama-ni
  cp sama-ni/main-sl.svg sama-ni/main-sp.svg release/sama-ni/
  cp -r src logo release/
