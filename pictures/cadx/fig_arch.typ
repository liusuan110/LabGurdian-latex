#import "../../defs.typ": *

// CADx 五层架构纵向图（学术极简版：白底/浅灰底 + 深灰边框 + 徽章传递层级）
#figure(
  acad-card(
    grid(
      columns: 1,
      rows: (auto,) * 5,
      gutter: 4pt,
      align: left + horizon,
      acad-card(label: "L5",
        fill: acad-bg-plain, stroke: acad-ink,
        [#strong[Expression Layer 表达层] #h(1fr) #acad-note[Gemma3-4B / Template fallback · polish only · verifier-gated]]),
      acad-card(label: "L4",
        fill: acad-bg-plain, stroke: acad-ink,
        [#strong[Orchestration Layer 编排层] #h(1fr) #acad-note[LangGraph · 4-intent unified ReAct]]),
      acad-card(label: "L3",
        fill: acad-bg-plain, stroke: acad-ink,
        [#strong[Retrieval Layer 检索层] #h(1fr) #acad-note[Multimodal RAG · Anti-hallucination routing]]),
      acad-card(label: "L2",
        fill: acad-bg-emphasis, stroke: acad-ink,
        [#strong[Decision Layer — Consensus Gate 决策层] #h(1fr) #acad-note[GNN-A ∩ Template Matcher → confidence_band]]),
      acad-card(label: "L1",
        fill: acad-bg-plain, stroke: acad-ink,
        [#strong[Representation Layer 表征层] #h(1fr) #acad-note[HCG · DSL Reference · Wire-Aware Phase E]]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [LabGuardian CADx 五层神经-符号架构。每层向上层提供"可证伪"的结构化输出而非不确定的概率，构成端到端的可解释推理链。决策层（L2）以浅蓝衬底标识为系统核心。],
) <fig:cadx-arch>
