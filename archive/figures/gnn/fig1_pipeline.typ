#import "../../defs.typ": *


#figure(
  card(
    grid(
      columns: (1.05fr, auto, 1.35fr, auto, 1.35fr, auto, 1.25fr, auto, 1.2fr),
      rows: (auto, auto, auto),
      gutter: 8pt,
      align: center,
      card([参考电路\ $G_r$], fill: rgb("#EEF6FF")), arrow,
      card([HeteroCircuitGraph\ component / port / net], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([SEAL 局部子图\ DRNL + 节点特征], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([CircuitMatchNet\ $P("edge correct")$], fill: rgb("#ECFDF5"), stroke: GNNGreen), arrow,
      card([GNNAdvisor\ hotspots / hints], fill: rgb("#FFF7ED"), stroke: WarnOrange),
      card([学生电路\ $G_s$], fill: rgb("#EEF6FF")), [], [], [], [], [], [], [], [],
      [], [], card([规则比较器\ 图同构 + 角色规则], fill: rgb("#F8FAFC")), [→], card([validator report\ summary.gnn], fill: rgb("#F8FAFC")), [], tiny-note([GNN advisory only\最终 pass/fail 仍由规则层裁决]), [], [],
    ),
    width: 100%,
  ),
  caption: [LabGuardian-GNN 从标准电路与学生电路到诊断报告的整体流程],
) <fig:pipeline>
