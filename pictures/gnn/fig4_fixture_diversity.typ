#import "../../defs.typ": *


#figure(
  card(
    table(
      columns: (1.4fr, 1fr, 3.2fr),
      inset: 6pt,
      table.header(strong[阶段], strong[OOD Test F1], strong[趋势]),
      [4-ref baseline], [0.700], [#text(fill: IntelBlue)[██████████████░░░░░░]],
      [+2 fixtures], [0.827], [#text(fill: IntelBlue)[█████████████████░░░]],
      [+LM358], [0.993], [#text(fill: GNNGreen)[████████████████████]],
    ),
    width: 92%,
  ),
  caption: [训练 fixture 多样性带来的 held-out OOD F1 提升],
) <fig:fixture-diversity>
