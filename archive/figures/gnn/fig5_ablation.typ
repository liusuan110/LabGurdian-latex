#import "../../defs.typ": *


#figure(
  card(
    table(
      columns: (1.2fr, 1fr, 2.4fr, 1fr, 2.4fr),
      inset: 6pt,
      table.header(strong[配置], strong[Val F1], strong[Val 条形], strong[Test F1], strong[Test 条形]),
      [Baseline], [0.941], [#text(fill: IntelBlue)[███████████████████░]], [0.854], [#text(fill: GNNGreen)[█████████████████░░░]],
      [No pretrain], [0.946], [#text(fill: IntelBlue)[███████████████████░]], [0.832], [#text(fill: GNNGreen)[█████████████████░░░]],
      [No DRNL], [0.943], [#text(fill: IntelBlue)[███████████████████░]], [0.918], [#text(fill: GNNGreen)[██████████████████░░]],
    ),
    width: 100%,
  ),
  caption: [P3 follow-up ablation：架构组件收益弱于 fixture 多样性],
) <fig:ablation>
