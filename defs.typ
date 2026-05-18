#let IntelBlue = rgb("#0071C5")
#let GNNGreen = rgb("#2E8B57")
#let WarnOrange = rgb("#D97706")
#let SoftGray = rgb("#F3F4F6")
#let DarkGray = rgb("#374151")

#let card(body, fill: rgb("#F8FAFC"), stroke: IntelBlue, width: auto) = block(
  width: width,
  inset: 8pt,
  radius: 4pt,
  fill: fill,
  stroke: 0.8pt + stroke,
)[#body]

#let arrow = text(size: 18pt, fill: DarkGray)[→]
#let tiny-note(x) = text(size: 8.5pt, fill: DarkGray)[#x]
