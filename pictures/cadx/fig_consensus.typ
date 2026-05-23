#import "../../defs.typ": *

// 共识门决策流程图（学术极简版）
#figure(
  acad-card(
    grid(
      columns: (1fr, auto, 1.8fr),
      gutter: 12pt,
      align: center + horizon,
      // 左：双路输入
      grid(
        columns: 1,
        rows: (auto, auto),
        gutter: 6pt,
        acad-card(
          fill: acad-bg-plain, stroke: acad-ink,
          [#strong[GNN-A]\
           GraphSAGE 22k params\
           softmax top-K]
        ),
        acad-card(
          fill: acad-bg-plain, stroke: acad-ink,
          [#strong[Template Matcher]\
           VF2 subgraph iso\
           + parametric_invariants\
           coverage-aware]
        ),
      ),
      acad-arrow,
      // 右：共识判定 4 band
      grid(
        columns: 1,
        rows: (auto, auto, auto, auto, auto),
        gutter: 4pt,
        align: left,
        acad-card(label: "HIGH",
          fill: acad-bg-emphasis, stroke: acad-ink,
          [GNN top-1 == Template top-1 ∧ both strong → adopt automatically]),
        acad-card(label: "MEDIUM",
          fill: acad-bg-plain, stroke: acad-ink,
          [GNN strong, Template weak → "needs confirmation"]),
        acad-card(label: "DISAGREE",
          fill: acad-bg-plain, stroke: acad-ink,
          [both strong but different → dual-hypothesis side-by-side]),
        acad-card(label: "LOW",
          fill: acad-bg-plain, stroke: acad-ink,
          [GNN conf $<$ 0.4 → unknown + manual fallback]),
        acad-note([判定逻辑见 #raw("app/services/topology_classifier_service.py::_consensus")]),
      ),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [共识门 (Consensus Gate)：让数据驱动的 GNN 与符号化的 Template 独立判断，仅当两者达成共识时才进入高置信度路径。HIGH band 以浅蓝衬底标识为前端"自动采用"的触发条件；其他 band 用相同灰底，依靠左上徽章语义传达层级。],
) <fig:consensus-gate>
