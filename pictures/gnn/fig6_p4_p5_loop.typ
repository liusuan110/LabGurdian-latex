#import "../../defs.typ": *


#figure(
  card(
    grid(
      columns: (1fr, auto, 1fr, auto, 1fr),
      rows: (auto, auto, auto),
      gutter: 8pt,
      align: center,
      card([orchestrator\规则裁决], fill: rgb("#EEF6FF")), arrow,
      card([GNNAdvisor\边级证据], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([validator report\gnn hints], fill: rgb("#F8FAFC")),
      [], [], [↓], [], [],
      card([nightly CI\exit 0/2/3/4], fill: rgb("#FFF7ED"), stroke: WarnOrange), [←], card([P5 evaluator\false pass 红线], fill: rgb("#EEF6FF")), [→], card([risk register\规则修正], fill: rgb("#ECFDF5"), stroke: GNNGreen),
    ),
    width: 100%,
  ),
  caption: [P4/P5 集成与评估闭环：advisory 输出、规则修正与 nightly 红线监控],
) <fig:p4-p5-loop>
