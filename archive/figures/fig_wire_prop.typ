#import "../../defs.typ": *

// Wire-Aware Role Propagation 对照图（学术极简版）
#figure(
  acad-card(
    grid(
      columns: (1fr, auto, 1fr),
      gutter: 14pt,
      align: center,
      // 左：传统方法
      grid(
        columns: 1,
        gutter: 4pt,
        align: center + horizon,
        align(center, text(weight: "bold")[传统方法：跳线当一等元件]),
        acad-card(
          fill: acad-bg-plain, stroke: acad-ink,
          [节点投票池: \
           \{R1.pin1, W1.pin1, W2.pin1, R2.pin2\}\
           #acad-note[(wire 也参与投票)]
          ]),
        align(center, acad-arrow),
        acad-card(
          fill: acad-bg-plain, stroke: acad-ink,
          [#strong[问题]：学生加 5 根装饰跳线 →\
           wire 没语义但占 5 票 →\
           容易把 net 误标 default_signal]),
      ),
      // 中：VS
      align(horizon, text(size: 18pt, fill: acad-muted, weight: "bold")[VS]),
      // 右：本文方法
      grid(
        columns: 1,
        gutter: 4pt,
        align: center + horizon,
        align(center, text(weight: "bold")[本文：跳线是 net 物理延伸]),
        acad-card(
          fill: acad-bg-emphasis, stroke: acad-ink,
          [节点投票池: \
           \{R1.pin1, R2.pin2\}\
           #acad-note[(wire 不参与，仅继承)]
          ]),
        align(center, acad-arrow),
        acad-card(
          fill: acad-bg-emphasis, stroke: acad-ink,
          [#strong[效果]：投票出 INV 后\
           W1.pin1、W2.pin1 自动继承 INV\
           对冗余跳线鲁棒]),
      ),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [Wire-Aware Role Propagation。把跳线从"一等元件"重新表征为"net 的物理延伸"，跳线 pin 不参与角色投票仅继承所在 net 的 canonical name。右侧两栏以浅蓝衬底标识为本文采用的方案。],
) <fig:wire-prop>
